// lib/quiz/quiz_result_service.dart
class QuizResultService {
  Future<List<QuizResult>> fetchQuizResults() async {
    // Dummy results, ideally fetched from Firebase or SQLite
    return [
      QuizResult(score: 3, total: 5),
      QuizResult(score: 4, total: 5),
      QuizResult(score: 2, total: 5),
    ];
  }
}

class QuizResult {
  final int score;
  final int total;

  QuizResult({required this.score, required this.total});
}
