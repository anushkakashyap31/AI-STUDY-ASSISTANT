import 'package:flutter/material.dart';
import '../planner/task_model.dart';
import '../planner/task_service.dart';
import '../quizzes/quiz_result_service.dart'; // ✅ import quiz service

class ProgressTrackerScreen extends StatefulWidget {
  const ProgressTrackerScreen({super.key});

  @override
  _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  final TaskService _taskService = TaskService();
  final QuizResultService _quizResultService = QuizResultService();

  int _totalTasks = 0;
  int _completedTasks = 0;

  int _totalQuizzes = 0;
  int _totalCorrectAnswers = 0;
  int _totalQuestionsAttempted = 0;

  @override
  void initState() {
    super.initState();
    _loadProgressData();
  }

  void _loadProgressData() async {
    final tasks = await _taskService.fetchAllTasksOnce();
    final quizResults = await _quizResultService.fetchQuizResults();

    int totalQuestions = quizResults.fold(0, (sum, result) => sum + result.total);
    int totalCorrect = quizResults.fold(0, (sum, result) => sum + result.score);

    setState(() {
      _totalTasks = tasks.length;
      _completedTasks = tasks.where((t) => t.isDone).length;

      _totalQuizzes = quizResults.length;
      _totalCorrectAnswers = totalCorrect;
      _totalQuestionsAttempted = totalQuestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    double taskCompletionRate = _totalTasks == 0 ? 0 : _completedTasks / _totalTasks;
    double quizAccuracy = _totalQuestionsAttempted == 0
        ? 0
        : _totalCorrectAnswers / _totalQuestionsAttempted;

    return Scaffold(
      appBar: AppBar(title: const Text("📊 Progress Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("🗂️ Task Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: taskCompletionRate,
                backgroundColor: Colors.grey[300],
                color: Colors.deepPurple,
                minHeight: 10,
              ),
              const SizedBox(height: 10),
              Text("$_completedTasks of $_totalTasks tasks completed"),
              const SizedBox(height: 30),

              const Text("🧠 Quiz Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: quizAccuracy,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
                minHeight: 10,
              ),
              const SizedBox(height: 10),
              Text("$_totalCorrectAnswers correct out of $_totalQuestionsAttempted questions"),
              Text("$_totalQuizzes quizzes attempted"),
              const SizedBox(height: 30),

              const Text("Keep going! You're doing great! 🎯", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
