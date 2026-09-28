import 'package:flutter/material.dart';

import 'login.dart';
import '../models/facility.dart';

// StatelessWidget cukup karena profil hanya menampilkan User yang diterima.
class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 16),
            Text(user.nama, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('Username: ${user.username}'),
            const SizedBox(height: 24),
            FilledButton.icon(
              key: const Key('logoutButton'),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
