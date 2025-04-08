# reward_model.py
class Badge:
    def __init__(self, name, description, icon):
        self.name = name
        self.description = description
        self.icon = icon

badges = {
    "quiz_master": Badge("Quiz Master", "Completed 5 quizzes", "🏅"),
    "goal_crusher": Badge("Goal Crusher", "Completed 5 tasks", "🎯"),
    "consistent_learner": Badge("Consistent Learner", "Logged in 5 days", "🔥"),
    "flashcard_pro": Badge("Flashcard Pro", "Reviewed 20 flashcards", "📚"),
}
