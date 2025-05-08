import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/room_booking_screen.dart';
import 'screens/washing_booking_screen.dart';
import 'screens/ai_chatbot_screen.dart';
import 'screens/lost_found_screen.dart';

void main() {
  runApp(ZenHostelApp());
}

class ZenHostelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZEN Hostel Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/room-booking': (context) => RoomBookingScreen(),
        '/washing-booking': (context) => WashingBookingScreen(),
        '/ai-chatbot': (context) => AIChatbotScreen(),
        '/lost-found': (context) => LostFoundScreen(),
      },
    );
  }
}
