// lib/planner/task_model.dart
class Task {
  String id;
  String title;
  DateTime date;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isDone = false,
  });

  // For saving to Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'isDone': isDone,
    };
  }

  // For retrieving from Firestore
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      isDone: json['isDone'] ?? false,
    );
  }
}
