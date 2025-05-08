import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ZEN - Dashboard')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildTile(context, 'Room Booking', Icons.meeting_room, '/room-booking'),
          _buildTile(context, 'Washing Booking', Icons.local_laundry_service, '/washing-booking'),
          _buildTile(context, 'AI Chatbot', Icons.smart_toy, '/ai-chatbot'),
          _buildTile(context, 'Lost & Found', Icons.search, '/lost-found'),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.indigo),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
