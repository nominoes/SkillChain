// lib/screens/startup/applicants_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/app_provider.dart';

class ApplicantsScreen extends StatelessWidget {
  final TaskModel task;
  const ApplicantsScreen({super.key, required this.task});

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
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Applicant ID: ${app.applicantId}'),
                        const SizedBox(height: 6),
                        Text('Status: ${app.status}'),
                        if (app.submissionLink.isNotEmpty)
                          Text('Submission: ${app.submissionLink}'),
                        if (app.feedback.isNotEmpty)
                          Text('Feedback: ${app.feedback}'),
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
