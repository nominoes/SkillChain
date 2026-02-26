// lib/screens/startup/applicants_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skillchain/models/task_model.dart';
import 'package:skillchain/providers/app_provider.dart';

class ApplicantsScreen extends StatelessWidget {
  final TaskModel task;
  const ApplicantsScreen({super.key, required this.task});

  Color _statusColor(String status) {
    switch (status) {
      case AppProvider.appApplied:
        return Colors.blue;
      case AppProvider.appSelected:
        return Colors.orange;
      case AppProvider.appSubmitted:
        return Colors.deepPurple;
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
    final appProvider = context.watch<AppProvider>();
    final applications = appProvider.getApplicationsForTask(task.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Applicants')),
      body: applications.isEmpty
          ? const Center(child: Text('No applicants yet'))
          : ListView.builder(
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final app = applications[index];
                final color = _statusColor(app.status);
                return Card(
                  margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Applicant: ${app.applicantId}',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                app.status,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (app.submissionLink.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text('Submission: ${app.submissionLink}'),
                        ],
                        if (app.feedback.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text('Feedback: ${app.feedback}'),
                        ],
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: app.status == 'applied'
                                  ? () {
                                      context.read<AppProvider>().selectApplicant(
                                        task.id,
                                        app.applicantId,
                                      );
                                    }
                                  : null,
                              child: const Text('Assign'),
                            ),
                            ElevatedButton(
                              onPressed: app.status == 'submitted'
                                  ? () {
                                      context.read<AppProvider>().approveSubmission(
                                        taskId: task.id,
                                        applicantId: app.applicantId,
                                        feedback: 'Great work, approved!',
                                      );
                                    }
                                  : null,
                              child: const Text('Approve'),
                            ),
                            OutlinedButton(
                              onPressed: (app.status == 'applied' ||
                                      app.status == 'submitted')
                                  ? () {
                                      context.read<AppProvider>().rejectApplication(
                                        taskId: task.id,
                                        applicantId: app.applicantId,
                                        feedback: 'Please revise and reapply',
                                      );
                                    }
                                  : null,
                              child: const Text('Reject'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
