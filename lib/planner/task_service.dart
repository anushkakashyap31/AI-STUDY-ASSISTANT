import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_model.dart';

class TaskService {
  final _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  void addTask(Task task) {
    _tasksCollection.doc(task.id).set(task.toJson());
  }

  Stream<List<Task>> getTasks() {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
    });
  }

  void updateTask(Task task) {
    _tasksCollection.doc(task.id).update({'isDone': task.isDone});
  }

  // ✅ NEW FUNCTION: For Progress Tracker (one-time fetch)
  Future<List<Task>> fetchAllTasksOnce() async {
    final snapshot = await _tasksCollection.get();
    return snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
  }
}
