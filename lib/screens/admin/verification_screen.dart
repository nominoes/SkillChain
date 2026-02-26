import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final approved = app.approvedApplications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: approved.isEmpty
          ? const Center(child: Text('No approved submissions yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: approved.length,
              itemBuilder: (context, index) {
                final item = approved[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.verified, color: Colors.green),
                    title: Text('Task ID: ${item.taskId}'),
                    subtitle: Text(
                      'Applicant: ${item.applicantId}\nSubmission: ${item.submissionLink.isEmpty ? 'N/A' : item.submissionLink}\nFeedback: ${item.feedback.isEmpty ? 'N/A' : item.feedback}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
