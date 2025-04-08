import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📝 Choose a Quiz")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("General Knowledge"),
            leading: const Icon(Icons.school),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              );
            },
          ),
          // You can add more topics here
        ],
      ),
    );
  }
}
