import 'package:flutter/material.dart';
import 'quiz_model.dart';
import 'trivia_service.dart'; // ✅ Using API-based service

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final questions = await TriviaService.fetchTriviaQuestions(amount: 5); // 🔁 You can change amount here
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading questions: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _checkAnswer(String selectedOption) {
    final currentQuestion = _questions[_currentIndex];
    if (selectedOption == currentQuestion.correctAnswer) {
      _score++;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Completed! 🎉"),
        content: Text("You scored $_score / ${_questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // back to quiz list
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text("Question ${_currentIndex + 1}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...question.options.map(
              (option) => Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(option),
                  child: Text(option),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
