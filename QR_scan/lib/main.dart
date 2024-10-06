import 'package:flutter/material.dart';
import 'qr.dart'; // Import the qr.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const QRCodeScreen(), // Set QRCodeScreen as the home screen
    );
  }
}
