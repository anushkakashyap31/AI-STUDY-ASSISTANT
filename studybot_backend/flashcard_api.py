#flashcard_api.py
from flask import Blueprint, request, jsonify
import ollama
from sqlalchemy import insert, select
from db_config import pg_engine
from models import flashcards

flashcard_bp = Blueprint('flashcard_bp', __name__)

# ✅ 1. Generate flashcards using Ollama
@flashcard_bp.route('/generate_flashcards', methods=['POST'])
def generate_flashcards():
    data = request.get_json()
    input_text = data.get("text", "")

    prompt = f"""
    Convert the following study notes into flashcards. Each flashcard should be in this format:
    Q: <question or term>
    A: <answer or explanation>

    Notes:
    {input_text}
    """

    response = ollama.chat(
        model='llama3',
        messages=[{"role": "user", "content": prompt}]
    )

    cards = []
    for line in response['message']['content'].split("\n"):
        if line.startswith("Q:"):
            question = line[2:].strip()
        elif line.startswith("A:"):
            answer = line[2:].strip()
            cards.append({"question": question, "answer": answer})

    return jsonify({"flashcards": cards})

# ✅ 2. Save flashcard to PostgreSQL
@flashcard_bp.route('/add_flashcard', methods=['POST'])
def add_flashcard():
    data = request.get_json()
    try:
        with pg_engine.connect() as conn:
            stmt = insert(flashcards).values(**data)
            conn.execute(stmt)
        return jsonify({"status": "Flashcard saved!"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# ✅ 3. Get all flashcards for a specific user
@flashcard_bp.route('/get_flashcards/<user_id>', methods=['GET'])
def get_flashcards(user_id):
    try:
        with pg_engine.connect() as conn:
            stmt = select(flashcards).where(flashcards.c.user_id == user_id)
            result = conn.execute(stmt)
            flashcard_list = [dict(row) for row in result]
        return jsonify(flashcard_list)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
