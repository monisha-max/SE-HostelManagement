import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/complaint_screen.dart';
import 'screens/food_request_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/roommate_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ① Start on Sign-Up
      initialRoute: '/signup',
      routes: {
        '/signup':    (_) => const SignupScreen(),
        '/login':     (_) => const LoginScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/complaints':(_) => const ComplaintScreen(),
        '/food':      (_) => const FoodRequestScreen(),
        '/chat':      (_) => const ChatbotScreen(),
        '/roommate':  (_) => const RoommateScreen(),
      },
    );
  }
}
