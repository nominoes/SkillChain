// lib/screens/student/dashboard_home.dart
import 'package:flutter/material.dart';
import '../../widgets/custom_card.dart';
import '../../core/constants.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Hi, Naman 👋',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Skill progress card
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
                LinearProgressIndicator(value: 0.7, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                SizedBox(height: 10),
                Text('Flutter - 70%', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Reputation card
          const CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reputation Score', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('4.6 ⭐', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),

          // Mentorship credits card
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