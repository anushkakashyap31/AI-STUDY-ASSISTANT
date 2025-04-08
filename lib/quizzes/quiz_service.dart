import 'quiz_model.dart';

class QuizService {
  // You can replace this with Firebase fetch in future
  static List<QuizQuestion> getSampleQuestions() {
    return [
      QuizQuestion(
        question: "What is the capital of India?",
        options: ["Mumbai", "Delhi", "Kolkata", "Chennai"],
        correctAnswer: "Delhi",
      ),
      QuizQuestion(
        question: "Which planet is known as the Red Planet?",
        options: ["Earth", "Venus", "Mars", "Jupiter"],
        correctAnswer: "Mars",
      ),
      QuizQuestion(
        question: "Who invented the telephone?",
        options: ["Einstein", "Newton", "Alexander Graham Bell", "Edison"],
        correctAnswer: "Alexander Graham Bell",
      ),
    ];
  }
}
