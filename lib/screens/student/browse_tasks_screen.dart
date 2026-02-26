// lib/screens/student/browse_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/task_model.dart';
import 'task_detail_screen.dart';

class BrowseTasksScreen extends StatelessWidget {
  const BrowseTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<AppProvider>().tasks;
    return Scaffold(
      appBar: AppBar(title: const Text('All Tasks')),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks posted yet'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final TaskModel task = tasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('Skill: ${task.skillRequired}'),
              trailing: Text(task.status),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskDetailScreen(task: task),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
