import 'package:cloud_firestore/cloud_firestore.dart';

class Flashcard {
  final String id;
  final String question;
  final String answer;
  final Timestamp createdAt;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'createdAt': createdAt,
    };
  }
}
