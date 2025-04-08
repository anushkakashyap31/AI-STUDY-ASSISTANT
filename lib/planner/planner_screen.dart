import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'task_model.dart';
import 'task_service.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final TextEditingController _controller = TextEditingController();
  final TaskService _taskService = TaskService();

  void _addTask(String title) {
    final task = Task(
      id: Uuid().v4(),
      title: title,
      date: DateTime.now(),
    );
    _taskService.addTask(task);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📅 Study Planner")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Add Task"),
              onSubmitted: _addTask,
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: _taskService.getTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final tasks = snapshot.data!;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.date.toString().substring(0, 10)),
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (val) {
                          setState(() {
                            task.isDone = val!;
                          });
                          _taskService.updateTask(task);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
