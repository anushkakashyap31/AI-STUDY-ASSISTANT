// recommendation_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationService 
{
  static const String apiUrl = "http://192.168.1.100:5001"; // 🔁 Update with your IP if on real phone

  Future<List<dynamic>> getRecommendations(String query) async {
    final response = await http.post(
      Uri.parse('$apiUrl/recommend'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['recommended_content'];
      } else {
        throw Exception('Failed to load recommendations');
      }
    }
}
