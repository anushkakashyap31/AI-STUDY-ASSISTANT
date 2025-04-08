import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quiz_model.dart';

class TriviaService {
  static Future<List<QuizQuestion>> fetchTriviaQuestions({int amount = 5}) async {
    final url = Uri.parse('https://opentdb.com/api.php?amount=$amount&type=multiple');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<QuizQuestion> questions = [];

      for (var item in data['results']) {
        // Combine correct + incorrect options
        List<String> allOptions = List<String>.from(item['incorrect_answers']);
        allOptions.add(item['correct_answer']);
        allOptions.shuffle();

        questions.add(
          QuizQuestion(
            question: _decodeHtml(item['question']),
            options: allOptions.map((opt) => _decodeHtml(opt)).toList(),
            correctAnswer: _decodeHtml(item['correct_answer']),
          ),
        );
      }

      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  // Decode HTML entities (e.g. &quot;, &amp;)
  static String _decodeHtml(String htmlString) {
    return htmlString.replaceAll('&quot;', '"')
                     .replaceAll('&#039;', "'")
                     .replaceAll('&amp;', '&');
  }
}
