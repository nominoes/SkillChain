import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../student/student_dashboard.dart';
import '../startup/startup_dashboard.dart';
import '../admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final AuthService _auth = AuthService();

  void login() {
    if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter all details")));
      return;
    }

    final result = _auth.login(emailCtrl.text, passCtrl.text);

    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid credentials")));
      return;
    }

    switch (result["role"]) {
      case "student":
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const StudentDashboard()));
        break;
      case "startup":
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const StartupDashboard()));
        break;
      case "admin":
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const AdminDashboard()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("SkillChain",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email")),
            TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}