// lib/screens/student/profile_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/badge_widget.dart';
import '../../models/badge_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      BadgeModel(id: 'b1', skill: 'Design', verifiedBy: 'Acme', issuedDate: DateTime.now().subtract(const Duration(days: 30))),
      BadgeModel(id: 'b2', skill: 'Flutter', verifiedBy: 'Beta', issuedDate: DateTime.now().subtract(const Duration(days: 10))),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 36, child: Text('N')),
          const SizedBox(height: 12),
          const Text('Naman Bheda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('B.Sc. Computer Science, VESASC'),
          const SizedBox(height: 16),
          const Text('Badges', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...badges.map((b) => BadgeWidget(badge: b)).toList(),
        ],
      ),
    );
  }
}