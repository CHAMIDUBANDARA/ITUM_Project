import 'package:flutter/material.dart';
import 'package:project_user_profile/Page/edit_profile_page.dart';
import 'package:project_user_profile/Page/logout_page.dart';
import 'package:project_user_profile/Page/notifications_page.dart';
import 'package:project_user_profile/Page/payments_page.dart';
import 'package:project_user_profile/Page/privacy_page.dart';
import 'package:project_user_profile/profile/profile_page.dart';

void main() {
  runApp(MyApp());
}

// Convert MyApp to a StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define named routes for easy navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const ProfilePage(), // Main profile page
        '/editProfile': (context) => EditProfilePage(),
        '/notifications': (context) => NotificationsPage(),
        '/privacy': (context) => PrivacyPage(),
        '/payments': (context) => PaymentsPage(),
        '/logout': (context) => LogoutPage(),
      },
    );
  }
}
