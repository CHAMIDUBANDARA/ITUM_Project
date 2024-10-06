import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
      ),
      body: const Center(
        child: Text('Notifications Page'),
      ),
    );
  }
}
