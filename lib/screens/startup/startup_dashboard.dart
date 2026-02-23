import 'package:flutter/material.dart';
import 'post_task_screen.dart';
import 'applicants_screen.dart';
import 'view_tasks_screen.dart';

class StartupDashboard extends StatelessWidget {
  const StartupDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Startup Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _menuButton(
              context,
              'Post New Task',
              Icons.add,
              const PostTaskScreen(),
            ),
            _menuButton(
              context,
              'View Posted Tasks',
              Icons.list_alt,
              const ViewTasksScreen(),
            ),
            _menuButton(
              context,
              'View Applicants',
              Icons.people,
              const ApplicantsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
      BuildContext context,
      String title,
      IconData icon,
      Widget screen,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}