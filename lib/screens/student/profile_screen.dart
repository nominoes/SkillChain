// lib/screens/student/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../root_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser!;
    final app = context.watch<AppProvider>();
    final badges = app.getBadgesForUser(user.id);
    final reputation = app.getReputationForUser(user.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Reputation: $reputation', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('Badges earned: ${badges.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Verified Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (badges.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text('No badges yet. Complete and get approved on tasks to earn badges.'),
              ),
            )
          else
            ...badges.map(
              (badge) => Card(
                child: ListTile(
                  leading: const Icon(Icons.verified, color: Colors.green),
                  title: Text(badge.skill),
                  subtitle: Text('Issued: ${badge.issuedDate.toLocal()}\nVerified by: ${badge.verifiedBy}'),
                ),
              ),
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const RootScreen()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
