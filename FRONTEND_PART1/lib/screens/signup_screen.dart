import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _api = ApiService();
  final _formKey  = GlobalKey<FormState>();
  final _loginCtl = TextEditingController();
  final _pwCtl    = TextEditingController();
  final _nameCtl  = TextEditingController();
  String? _role;

  final _roles = ['Admin','Student','Warden','Maintenance Staff'];

  @override
  void dispose() {
    _loginCtl.dispose();
    _pwCtl.dispose();
    _nameCtl.dispose();
    super.dispose();
  }

  Future<void> _doSignup() async {
    if (!_formKey.currentState!.validate() || _role == null) return;
    try {
      final msg = await _api.register(
        loginId: _loginCtl.text.trim(),
        password: _pwCtl.text,
        name: _nameCtl.text.trim(),
        role: _role!,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
      if (msg.contains('successfully')) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _loginCtl,
              decoration: const InputDecoration(labelText: 'Login ID', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height:12),
            TextFormField(
              controller: _pwCtl,
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height:12),
            TextFormField(
              controller: _nameCtl,
              decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height:12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
              items: _roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (v) => setState(() => _role = v),
              validator: (v) => v == null ? 'Select a role' : null,
            ),
            const SizedBox(height:20),
            ElevatedButton(
              onPressed: _doSignup,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical:14),
                child: Text('Sign Up', style: TextStyle(fontSize:16)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(c, '/login'),
              child: const Text('Already have an account? Log in'),
            )
          ]),
        ),
      ),
    );
  }
}
