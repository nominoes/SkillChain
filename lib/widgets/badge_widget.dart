import 'package:flutter/material.dart';
import '../models/badge_model.dart';

class BadgeWidget extends StatelessWidget {
  final BadgeModel badge;
  const BadgeWidget({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(badge.skill, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Verified by ${badge.verifiedBy}'),
            const SizedBox(height: 6),
            Text('Issued ${badge.issuedDate.toLocal().toIso8601String().split("T").first}'),
          ],
        ),
      ),
    );
  }
}