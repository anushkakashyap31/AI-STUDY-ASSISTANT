//recommendation_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  TextEditingController queryController = TextEditingController();
  List<dynamic> recommendations = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchRecommendations() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      recommendations = [];
    });

    final query = queryController.text.trim();
    if (query.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Please enter a topic to search.';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.100:5001/recommend'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        setState(() {
          // ✅ Access the 'recommended_content' key from the decoded response
          recommendations = decoded['recommended_content'];
        });
      } else {
        setState(() {
          errorMessage = "Error: Server returned status ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Failed to fetch recommendations: $e";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendation System"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: queryController,
              decoration: const InputDecoration(
                labelText: 'Enter topic (e.g., Python, AI)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: fetchRecommendations,
              icon: const Icon(Icons.search),
              label: const Text("Get Recommendations"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red))
            else if (recommendations.isEmpty)
              const Text("No recommendations yet.")
            else
              Expanded(
                child: ListView.builder(
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    final item = recommendations[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.book, color: Colors.teal),
                        title: Text(item['title']),
                        subtitle: Text(item['description']),
                        trailing: Text("ID: ${item['id']}"),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

