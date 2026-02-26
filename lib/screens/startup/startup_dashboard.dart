// lib/screens/startup/startup_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/app_provider.dart';
import 'post_task_screen.dart';
import 'applicants_screen.dart';
import '../root_screen.dart';
import '../../models/task_model.dart';

class StartupDashboard extends StatelessWidget {
  const StartupDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthProvider>().currentUser!.id;
    final tasks = context.watch<AppProvider>().tasks
        .where((t) => t.postedBy == userId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const RootScreen()),
              );
            },
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('You have not posted any tasks yet'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final TaskModel task = tasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('Status: ${task.status}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ApplicantsScreen(task: task),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PostTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
