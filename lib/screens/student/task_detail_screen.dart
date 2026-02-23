// lib/screens/student/task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_model.dart';
import '../../models/application_model.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser!;
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(task.description),
            const SizedBox(height: 10),
            Text("Required Skill: ${task.skillRequired}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final application = ApplicationModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  taskId: task.id,
                  applicantId: user.id,
                );
                context.read<AppProvider>().applyToTask(application);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Applied successfully")),
                );
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }
}
