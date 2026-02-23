// lib/screens/auth/role_selection_screen.dart
import 'package:flutter/material.dart';
import '../student/student_dashboard.dart';
import '../startup/startup_dashboard.dart';
import '../admin/admin_dashboard.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _goTo(BuildContext ctx, Widget screen) {
    Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) => screen));
  }

  Widget _button(BuildContext ctx, String label, Color color, Widget screen) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        onPressed: () => _goTo(ctx, screen),
        child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(title: const Text('Select Role')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              Text('Continue as', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: primary)),
              const SizedBox(height: 20),
              _button(context, 'Student', const Color(0xFF1E88E5), const StudentDashboard()),
              const SizedBox(height: 12),
              _button(context, 'Startup / NGO', const Color(0xFF43A047), const StartupDashboard()),
              const SizedBox(height: 12),
              _button(context, 'Admin', const Color(0xFF6A1B9A), const AdminDashboard()),
              const Spacer(),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Back to Login'))
            ],
          ),
        ),
      ),
    );
  }
}