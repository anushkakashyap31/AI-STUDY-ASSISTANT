#chatbot_api.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import ollama
from flashcard_api import flashcard_bp
from reward_logic import check_rewards  # ✅ Add this line
from flask import request
from models import user_progress
from db_config import pg_engine
from sqlalchemy import insert

app = Flask(__name__)
CORS(app)

app.register_blueprint(flashcard_bp)

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json()
    user_message = data.get('message')

    try:
        response = ollama.chat(
            model='llama3',
            messages=[{"role": "user", "content": user_message}]
        )
        bot_reply = response['message']['content']
        return jsonify({'response': bot_reply})
    except Exception as e:
        return jsonify({'response': f"Error: {str(e)}"}), 500

# ✅ NEW: Gamification Badge API
@app.route('/get_badges', methods=['POST'])
def get_badges():
    data = request.get_json()
    try:
        result = check_rewards(data)
        return jsonify(result)
    except Exception as e:
        return jsonify({'error': f'Failed to get rewards: {str(e)}'}), 500

@app.route('/update_progress', methods=['POST'])
def update_progress():
    data = request.get_json()
    try:
        with pg_engine.connect() as conn:
            stmt = insert(user_progress).values(**data)
            conn.execute(stmt)
        return jsonify({"status": "Progress updated!"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
