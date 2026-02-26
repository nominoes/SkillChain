import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../root_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _continueAs(BuildContext context, String role) {
    final demoUser = UserModel(
      id: 'demo_$role',
      name: 'Demo ${role[0].toUpperCase()}${role.substring(1)}',
      email: '$role@skillchain.com',
      role: role,
    );

    context.read<AuthProvider>().login(demoUser);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RootScreen()),
    );
  }

  Widget _button(BuildContext context, String label, Color color, String role) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => _continueAs(context, role),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
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
              Text(
                'Continue as',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
              const SizedBox(height: 20),
              _button(context, 'Student', const Color(0xFF1E88E5), 'student'),
              const SizedBox(height: 12),
              _button(context, 'Startup / NGO', const Color(0xFF43A047), 'startup'),
              const SizedBox(height: 12),
              _button(context, 'Admin', const Color(0xFF6A1B9A), 'admin'),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
