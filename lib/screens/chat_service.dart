//chat_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getBotResponse(String message) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.100:5000/chat'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'message': message}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['response'];
  } else {
    throw Exception('Failed to get response from chatbot');
  }
}

