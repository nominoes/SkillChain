import 'package:flutter/material.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> applicants = [
      {
        'name': 'Aisha',
        'task': 'Design Instagram Post',
        'rating': 4.5,
      },
      {
        'name': 'Rahul',
        'task': 'Build Login UI',
        'rating': 4.2,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Applicants')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];

          return Card(
            child: ListTile(
              title: Text(applicant['name'] as String),
              subtitle: Text(
                '${applicant['task']} • Rating: ${applicant['rating']}',
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Applicant Approved (mock)'),
                    ),
                  );
                },
                child: const Text('Approve'),
              ),
            ),
          );
        },
      ),
    );
  }
}