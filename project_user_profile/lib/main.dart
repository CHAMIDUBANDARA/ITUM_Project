// Importing necessary Flutter packages and other pages from the project.
import 'package:flutter/material.dart';
import 'package:project_user_profile/Page/notifications_page.dart';
import 'package:project_user_profile/page/edit_profile_page.dart';
import 'package:project_user_profile/page/logout_page.dart';
import 'package:project_user_profile/page/payments_page.dart';
import 'package:project_user_profile/page/privacy_page.dart';

// The main function where the app starts running.
void main() {
  runApp(const MyApp()); // Runs the MyApp widget.
}

// Main App class converted to StatefulWidget.
// StatefulWidget is used because the app's state may change over time.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

// The state class for MyApp.
// This manages the state of the MyApp widget.
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the root of the widget tree and provides theming and routing.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner.
      initialRoute: '/', // Sets the initial route to '/'.
      routes: {
        '/': (context) => const MainPage(), // Main page with Bottom Navigation.
        '/editProfile': (context) =>
            const EditProfilePage(), // Edit Profile Page.
        '/notifications': (context) =>
            const NotificationsPage(), // Notifications Page.
        '/privacy': (context) => const PrivacyPage(), // Privacy Page.
        '/payments': (context) => const PaymentsPage(), // Payments Page.
        '/logout': (context) => const LogoutPage(), // Logout Page.
      },
    );
  }
}

// Main Page with Bottom Navigation Bar.
// This is a StatefulWidget because the selected tab can change.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

// The state class for MainPage.
// Manages which tab is currently selected.
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Tracks the index of the selected tab.

  // List of pages corresponding to each tab in the Bottom Navigation Bar.
  final List<Widget> _pages = [
    const HomePage(), // Home tab.
    const BusPage(), // Bus tab.
    const LocationPage(), // Location tab.
    const ProfilePage(), // Profile tab.
  ];

  // Function called when a tab is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Highlight the selected tab.
        onTap: _onItemTapped, // Handle tab taps.
        selectedItemColor:
            Colors.black, // Color for selected tab icon and label.
        unselectedItemColor:
            Color.fromARGB(255, 176, 174, 174), // Color for unselected tabs.
        backgroundColor:
            Colors.orange, // Background color of the Bottom Navigation Bar.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon for Home tab.
            label: 'Home', // Label for Home tab.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus), // Icon for Bus tab.
            label: 'Bus', // Label for Bus tab.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on), // Icon for Location tab.
            label: 'Location', // Label for Location tab.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icon for Profile tab.
            label: 'Profile', // Label for Profile tab.
          ),
        ],
      ),
    );
  }
}

// Profile Page as StatefulWidget.
// This page contains buttons to navigate to other pages like Edit Profile, Notifications, etc.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// The state class for ProfilePage.
class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // App bar background color.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon.
          iconSize: 33, // Size of the back icon.
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen.
          },
        ),
        title: const Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/passenger.png'), // User avatar image.
              radius: 22, // Size of the avatar.
            ),
            SizedBox(width: 10), // Spacing between avatar and text.
            Text(
              'Profile', // Title text.
              style: TextStyle(
                fontWeight: FontWeight.bold, // Bold text.
                fontSize: 25, // Font size.
              ),
              strutStyle: StrutStyle(
                fontSize: 20, // Strut style for consistent spacing.
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu), // Menu icon.
            iconSize: 33, // Size of the menu icon.
            onPressed: () {
              // Add menu functionality here if needed.
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 25), // Space at the top.
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  vertical: 15), // Padding around the list.
              children: [
                // Button for "Edit Profile".
                SizedBox(
                  height: 80, // Height of the button.
                  child: _buildProfileButton(
                    icon: Icons.person, // Icon for the button.
                    text: 'Edit Profile', // Text for the button.
                    onTap: () {
                      Navigator.pushNamed(context,
                          '/editProfile'); // Navigate to Edit Profile Page.
                    },
                  ),
                ),
                const SizedBox(height: 10), // Space between buttons.

                // Button for "Notifications".
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.notifications,
                    text: 'Notifications',
                    onTap: () {
                      Navigator.pushNamed(context,
                          '/notifications'); // Navigate to Notifications Page.
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Button for "Privacy".
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.security,
                    text: 'Privacy',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/privacy'); // Navigate to Privacy Page.
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Button for "Payments".
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.payment,
                    text: 'Payments',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/payments'); // Navigate to Payments Page.
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Button for "Logout".
                SizedBox(
                  height: 80,
                  child: _buildProfileButton(
                    icon: Icons.power_settings_new,
                    text: 'Logout',
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/logout'); // Navigate to Logout Page.
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for building buttons on the profile page.
// This function creates a styled button with an icon and text.
Widget _buildProfileButton({
  required IconData icon, // Icon to display on the button.
  required String text, // Text to display on the button.
  required VoidCallback onTap, // Function to call when the button is tapped.
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 20, vertical: 8), // Padding around the button.
    child: GestureDetector(
      onTap: onTap, // Handle tap events.
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade100, // Background color of the button.
          borderRadius: BorderRadius.circular(12), // Rounded corners.
        ),
        padding: const EdgeInsets.all(16), // Padding inside the button.
        child: Row(
          children: [
            Icon(icon, color: Colors.black), // Icon on the left.
            const SizedBox(width: 20), // Space between icon and text.
            Expanded(
              child: Text(
                text, // Button text.
                style: const TextStyle(
                  fontSize: 17, // Font size.
                  fontWeight: FontWeight.w700, // Bold text.
                  color: Colors.black, // Text color.
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.black), // Arrow icon on the right.
          ],
        ),
      ),
    ),
  );
}

// Sample page for Home.
// This is a StatefulWidget, so it can manage its own state.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// The state class for HomePage.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'), // Title of the App Bar.
        backgroundColor: Colors.orange, // App Bar background color.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon.
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ProfilePage()), // Navigate to ProfilePage.
              (Route<dynamic> route) => false, // Remove all previous routes.
            );
          },
        ),
      ),
      body: const Center(
        child: Text('Home Page'), // Text displayed in the center.
      ),
    );
  }
}

// Sample page for Bus.
class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

// The state class for BusPage.
class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Page'), // Title of the App Bar.
        backgroundColor: Colors.orange, // App Bar background color.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon.
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ProfilePage()), // Navigate to ProfilePage.
              (Route<dynamic> route) => false, // Remove all previous routes.
            );
          },
        ),
      ),
      body: const Center(
        child: Text('Bus Page'), // Text displayed in the center.
      ),
    );
  }
}

// Sample page for Location.
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

// The state class for LocationPage.
class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Page'), // Title of the App Bar.
        backgroundColor: Colors.orange, // App Bar background color.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon.
          onPressed: () {
            // Navigate back to ProfilePage.
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ProfilePage()), // Navigate to ProfilePage.
              (Route<dynamic> route) => false, // Remove all previous routes.
            );
          },
        ),
      ),
      body: const Center(
        child: Text('Location Page'), // Text displayed in the center.
      ),
    );
  }
}
