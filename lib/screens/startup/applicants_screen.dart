// lib/screens/startup/applicants_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class ApplicantsScreen extends StatelessWidget {
  final task;
  const ApplicantsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final applications = context.watch<AppProvider>().getApplicationsForTask(task.id);
    return Scaffold(
      appBar: AppBar(title: const Text('Applicants')),
      body: applications.isEmpty
          ? const Center(child: Text("No applicants yet"))
          : ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final app = applications[index];
          return Card(
            child: ListTile(
              title: Text("Applicant ID: ${app.applicantId}"),
              subtitle: Text("Status: ${app.status}"),
            ),
          );
        },
      ),
    );
  }
}
