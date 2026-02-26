// lib/screens/startup/startup_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../root_screen.dart';
import 'applicants_screen.dart';
import 'post_task_screen.dart';

class StartupDashboard extends StatelessWidget {
  const StartupDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthProvider>().currentUser!;
    final userId = currentUser.id;
    final userId = context.read<AuthProvider>().currentUser!.id;
    final tasks = context
        .watch<AppProvider>()
        .tasks
        .where((t) => t.postedBy == userId)
        .toList();

    final openCount = tasks.where((t) => t.status == 'Open').length;
    final activeCount =
        tasks.where((t) => t.status == 'Assigned' || t.status == 'Submitted').length;
    final verifiedCount = tasks.where((t) => t.status == 'Verified').length;

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Welcome, ${currentUser.name.isEmpty ? 'Startup User' : currentUser.name}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatChip(label: 'Open', value: openCount.toString()),
                _StatChip(label: 'Active', value: activeCount.toString()),
                _StatChip(label: 'Verified', value: verifiedCount.toString()),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('You have not posted any tasks yet'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final TaskModel task = tasks[index];
                      return Card(
                        child: ListTile(
                          title: Text(task.title),
                          subtitle: Text('Status: ${task.status}'),
                          trailing: const Icon(Icons.chevron_right),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PostTaskScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Post Task'),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
