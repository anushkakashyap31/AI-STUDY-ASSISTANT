import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'label': 'Chatbot', 'icon': Icons.chat, 'route': '/chatbot'},
      {'label': 'Study Planner', 'icon': Icons.calendar_today, 'route': '/planner'},
      {'label': 'Progress', 'icon': Icons.show_chart, 'route': '/progress'},
      {'label': 'Quizzes', 'icon': Icons.quiz, 'route': '/quizzes'},
      {'label': 'Notes', 'icon': Icons.note, 'route': '/notes'},
      {'label': 'Flashcards', 'icon': Icons.flash_on, 'route': '/flashcards'},
      {'label': 'Recommendation System', 'icon': Icons.recommend, 'route': '/recommendations'},
      {'label': 'Gamification & Rewards', 'icon': Icons.emoji_events, 'route': '/rewards'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: features.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final feature = features[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, feature['route']);
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(feature['icon'], size: 50, color: Colors.deepPurple),
                      const SizedBox(height: 10),
                      Text(
                        feature['label'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
