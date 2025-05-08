import 'package:flutter/material.dart';
import '../models/session.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _api = ApiService();
  final _loginCtl = TextEditingController();
  final _pwCtl    = TextEditingController();

  @override
  void dispose() {
    _loginCtl.dispose();
    _pwCtl.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    try {
      final msg = await _api.login(_loginCtl.text.trim(), _pwCtl.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      if (msg.trim() == 'Login successful!') {
        Session.loginId = _loginCtl.text.trim();
        Session.role    = await _api.getUserRole(Session.loginId);
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(
            controller: _loginCtl,
            decoration: const InputDecoration(labelText: 'Login ID', border: OutlineInputBorder()),
          ),
          const SizedBox(height:12),
          TextField(
            controller: _pwCtl,
            decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            obscureText: true,
          ),
          const SizedBox(height:24),
          ElevatedButton(
            onPressed: _doLogin,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical:14),
              child: Text('Login', style: TextStyle(fontSize:16)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(c, '/signup'),
            child: const Text("Don't have an account? Sign up"),
          ),
        ]),
      ),
    );
  }
}
