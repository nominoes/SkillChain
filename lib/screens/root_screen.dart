import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';
import 'student/student_dashboard.dart';
import 'startup/startup_dashboard.dart';
import 'admin/admin_dashboard.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (!auth.isLoggedIn) {

      return const LoginScreen();
    }
    switch (auth.currentUser!.role) {
      case 'student':
        return const StudentDashboard();
      case 'startup':
        return const StartupDashboard();
      case 'admin':
        return const AdminDashboard();
      default:
        return const LoginScreen();
    }
  }
}
