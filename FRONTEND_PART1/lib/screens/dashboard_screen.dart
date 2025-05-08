// lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import '../models/session.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  bool get _canSeeFood =>
      Session.role == 'Admin' ||
      Session.role == 'Warden' ||
      Session.role == 'Student' ||
      Session.role == 'Maintenance';

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Complaints'),
              onTap: () => Navigator.pushNamed(c, '/complaints'),
            ),
          ),

          if (_canSeeFood) Card(
            child: ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text('Food Requests'),
              onTap: () => Navigator.pushNamed(c, '/food'),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chatbot (FAQs)'),
              onTap: () => Navigator.pushNamed(c, '/chat'),
            ),
          ),

          // only students get Roommate Matching
          if (Session.role == 'Student') Card(
            child: ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Roommate Matching'),
              onTap: () => Navigator.pushNamed(c, '/roommate'),
            ),
          ),
        ],
      ),
    );
  }
}
