import 'package:flutter/material.dart';

import '../models/facility.dart';
import 'root.dart';

// StatefulWidget diperlukan untuk controller dan status validasi form.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final isValid =
        _usernameController.text.trim() == dummyUser.username &&
        _passwordController.text == dummyUser.password;

    if (!isValid) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password tidak sesuai.')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RootPage(user: dummyUser)),
    );
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _hasError ? Colors.red : Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _hasError ? Colors.red : Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CampusGo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.school, size: 64),
                const SizedBox(height: 12),
                Text(
                  'Masuk ke CampusGo',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 28),
                TextField(
                  key: const Key('usernameField'),
                  controller: _usernameController,
                  decoration: _decoration('Username'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('passwordField'),
                  controller: _passwordController,
                  decoration: _decoration('Password'),
                  obscureText: true,
                  onSubmitted: (_) => _login(),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  key: const Key('loginButton'),
                  onPressed: _login,
                  child: const Text('Masuk'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
