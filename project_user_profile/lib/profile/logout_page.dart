import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('You have logged out!'),
      ),
    );
  }
}
