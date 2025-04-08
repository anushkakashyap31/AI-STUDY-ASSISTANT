// reward_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  List<dynamic> badges = [];

  @override
  void initState() {
    super.initState();
    fetchBadges();
  }

  Future<void> fetchBadges() async {
    final url = Uri.parse('http://192.168.1.100:5000/get_badges');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "quizzes_completed": 5,
        "tasks_completed": 4,
        "login_days": 5,
        "flashcards_reviewed": 20,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        badges = data['badges'];
      });
    } else {
      print("Failed to fetch rewards");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Rewards"),
      ),
      body: badges.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: badges.length,
              itemBuilder: (context, index) {
                final badge = badges[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Text(badge['icon'], style: const TextStyle(fontSize: 28)),
                    title: Text(badge['name'] ?? badge['title']),
                    subtitle: Text(badge['description']),
                  ),
                );
              },
            ),
    );
  }
}
