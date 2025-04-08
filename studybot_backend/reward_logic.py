# reward_logic.py
from reward_model import badges  # Importing predefined badge instances

def check_rewards(user_data):
    earned = []

    if user_data.get('quizzes_completed', 0) >= 5:
        earned.append(badges["quiz_master"].__dict__)

    if user_data.get('tasks_completed', 0) >= 5:
        earned.append(badges["goal_crusher"].__dict__)

    if user_data.get('login_days', 0) >= 5:
        earned.append(badges["consistent_learner"].__dict__)

    if user_data.get('flashcards_reviewed', 0) >= 20:
        earned.append(badges["flashcard_pro"].__dict__)

    if not earned:
        earned.append({
            "name": "Keep Going!",
            "description": "Complete tasks, quizzes, or study regularly to earn badges.",
            "icon": "💪"
        })

    return {"badges": earned}
