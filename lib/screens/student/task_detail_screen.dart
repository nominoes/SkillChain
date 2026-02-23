// lib/screens/student/task_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/task_model.dart';
import 'submit_work_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(task.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(task.description),
          const SizedBox(height: 14),
          Text('Skill: ${task.skillRequired}'),
          const SizedBox(height: 6),
          Text('Estimated hours: ${task.hours}'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SubmitWorkScreen(task: task)));
              },
              child: const Text('Apply / Submit'),
            ),
          )
        ]),
      ),
    );
  }
}