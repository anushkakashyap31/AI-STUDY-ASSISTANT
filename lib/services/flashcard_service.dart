import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> generateFlashcards(String text) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.100:5000/generate_flashcards'), // for Android Emulator
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'text': text}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return List<Map<String, String>>.from(data['flashcards']);
  } else {
    throw Exception('Failed to generate flashcards');
  }
}
