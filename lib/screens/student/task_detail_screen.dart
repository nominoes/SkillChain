// lib/screens/student/task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/application_model.dart';
import '../../models/task_model.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import 'submit_work_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser!;
    final appProvider = context.watch<AppProvider>();
    final myApplication = appProvider.getApplication(task.id, user.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(task.description),
            const SizedBox(height: 10),
            Text('Required Skill: ${task.skillRequired}'),
            const SizedBox(height: 6),
            Text('Task Status: ${task.status}'),
            if (myApplication != null) ...[
              const SizedBox(height: 6),
              Text('Your Application: ${myApplication.status}'),
              if (myApplication.feedback.isNotEmpty)
                Text('Feedback: ${myApplication.feedback}'),
            ],
            const SizedBox(height: 20),
            _buildPrimaryButton(context, user.id, myApplication),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context,
    String userId,
    ApplicationModel? myApplication,
  ) {
    if (myApplication == null) {
      return ElevatedButton(
        onPressed: () {
          final application = ApplicationModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            taskId: task.id,
            applicantId: userId,
          );
          context.read<AppProvider>().applyToTask(application);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Applied successfully')),
          );
        },
        child: const Text('Apply'),
      );
    }

    if (myApplication.status == 'selected' || myApplication.status == 'submitted') {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubmitWorkScreen(task: task),
            ),
          );
        },
        child: Text(
          myApplication.status == 'submitted' ? 'Update Submission' : 'Submit Work',
        ),
      );
    }

    return ElevatedButton(
      onPressed: null,
      child: Text('Status: ${myApplication.status}'),
    );
  }
}
