from flask import Flask
from flask_socketio import SocketIO, emit, join_room
import random

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")

questions = [
    {"q": "Capital of India?", "a": "Delhi"},
    {"q": "2 + 2?", "a": "4"},
    {"q": "Python creator?", "a": "Guido"},
]

@socketio.on('join_game')
def handle_join(data):
    room = data['room']
    join_room(room)
    q = random.choice(questions)
    emit('new_question', q, room=room)

@socketio.on('submit_answer')
def handle_answer(data):
    room = data['room']
    user_ans = data['answer']
    correct_ans = data['correct']
    result = user_ans.strip().lower() == correct_ans.strip().lower()
    emit('answer_result', {'correct': result}, room=room)

if __name__ == '__main__':
    socketio.run(app, port=5002)
