import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skillchain/providers/auth_provider.dart';
import 'package:skillchain/screens/root_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const RootScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text('Admin functionalities go here')),
    );
  }
}
