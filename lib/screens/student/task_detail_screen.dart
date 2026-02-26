// lib/screens/student/task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skillchain/models/application_model.dart';
import 'package:skillchain/models/task_model.dart';
import 'package:skillchain/providers/app_provider.dart';
import 'package:skillchain/providers/auth_provider.dart';
import 'package:skillchain/screens/student/submit_work_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  const TaskDetailScreen({super.key, required this.task});

  Color _statusColor(String status) {
    switch (status) {
      case AppProvider.taskOpen:
        return Colors.blue;
      case AppProvider.taskAssigned:
        return Colors.orange;
      case AppProvider.taskSubmitted:
        return Colors.deepPurple;
      case AppProvider.taskVerified:
      case AppProvider.appApproved:
        return Colors.green;
      case AppProvider.appRejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _pill(
                  icon: Icons.build_circle_outlined,
                  label: task.skillRequired,
                ),
                _pill(icon: Icons.schedule, label: '${task.hours}h'),
                _pill(
                  icon: Icons.flag,
                  label: task.status,
                  color: _statusColor(task.status),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(task.description),
            if (myApplication != null) ...[
              const SizedBox(height: 14),
              _pill(
                icon: Icons.assignment_turned_in,
                label: 'Application: ${myApplication.status}',
                color: _statusColor(myApplication.status),
              ),
              if (myApplication.feedback.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Feedback: ${myApplication.feedback}'),
              ],
            ],
            const Spacer(),
            _buildPrimaryButton(context, user.id, myApplication),
          ],
        ),
      ),
    );
  }

  Widget _pill({required IconData icon, required String label, Color? color}) {
    final chipColor = color ?? Colors.blueGrey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: chipColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: chipColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context,
    String userId,
    ApplicationModel? myApplication,
  ) {
    if (myApplication == null) {
      final canApply = task.status == AppProvider.taskOpen;
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canApply
              ? () {
                  final application = ApplicationModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    taskId: task.id,
                    applicantId: userId,
                  );
                  context.read<AppProvider>().applyToTask(application);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Applied successfully')),
                  );
                }
              : null,
          child: Text(canApply ? 'Apply Now' : 'Task is not accepting new applications'),
        ),
      );
    }

    if (myApplication.status == AppProvider.appSelected || myApplication.status == AppProvider.appSubmitted) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SubmitWorkScreen(task: task),
              ),
            );
          },
          icon: const Icon(Icons.upload_file),
          label: Text(
            myApplication.status == AppProvider.appSubmitted
                ? 'Update Submission'
                : 'Submit Work',
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null,
        child: Text('Status: ${myApplication.status}'),
      ),
    );
  }
}
