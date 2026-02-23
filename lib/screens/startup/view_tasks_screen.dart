import 'package:flutter/material.dart';

class ViewTasksScreen extends StatelessWidget {
  const ViewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postedTasks = [
      {'title': 'Design Instagram Post', 'status': 'Open'},
      {'title': 'Build Login UI', 'status': 'In Progress'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Posted Tasks')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: postedTasks.length,
        itemBuilder: (context, index) {
          final task = postedTasks[index];
          return Card(
            child: ListTile(
              title: Text(task['title']!),
              subtitle: Text('Status: ${task['status']}'),
            ),
          );
        },
      ),
    );
  }
}