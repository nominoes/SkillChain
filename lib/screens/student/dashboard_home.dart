// lib/screens/student/dashboard_home.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_card.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser!;
    final app = context.watch<AppProvider>();
    final badges = app.getBadgesForUser(user.id);
    final reputation = app.getReputationForUser(user.id);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Hi, ${user.name.isEmpty ? 'Learner' : user.name} 👋',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Skill Progress', style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: 0.7,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 10),
                Text('Flutter - 70%', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Reputation Score', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('$reputation ⭐', style: const TextStyle(fontSize: 24)),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Badges Earned', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${badges.length} verified badges'),
              ],
            ),
          ),
          const CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mentorship Credits', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('2 hours available'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
