// lib/screens/student/browse_tasks_screen.dart
import 'package:flutter/material.dart';
import '../../models/task_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/task_card.dart';
import 'task_detail_screen.dart';

class BrowseTasksScreen extends StatefulWidget {
  const BrowseTasksScreen({super.key});

  @override
  State<BrowseTasksScreen> createState() => _BrowseTasksScreenState();
}

class _BrowseTasksScreenState extends State<BrowseTasksScreen> {
  final FirestoreService _fs = FirestoreService();
  late Future<List<TaskModel>> _futureTasks;

  @override
  void initState() {
    super.initState();
    _futureTasks = _fs.getMockTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Tasks')),
      body: FutureBuilder<List<TaskModel>>(
        future: _futureTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) return const Center(child: Text('No tasks available'));
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final t = tasks[index];
              return TaskCard(
                task: t,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(task: t)));
                },
              );
            },
          );
        },
      ),
    );
  }
}