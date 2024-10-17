import 'package:flutter/material.dart';
import 'qr.dart'; // Import the QR code scanning functionality from the qr.dart file

void main() {
  runApp(const MyApp()); // Start the app by running MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // This is a constructor for the MyApp class

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Turn off the debug banner
      title: 'QR Code Scanner', // Set the title of the app
      theme: ThemeData(
        primarySwatch: Colors.orange, // Set the primary color theme to orange
      ),
      home:
          const QRCodeScreen(), // Set the main screen of the app to QRCodeScreen
    );
  }
}
