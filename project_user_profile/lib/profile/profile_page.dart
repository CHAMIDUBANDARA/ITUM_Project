import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 33, // Back arrow icon size
          onPressed: () {
            Navigator.pop(context); // Action to navigate back
          },
        ),
        title: const Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/passenger.png'), // Add your avatar image here
              radius: 22,
            ),
            SizedBox(width: 10),
            Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Correct way to set font weight
                fontSize: 25, // Font size
              ),
              strutStyle: StrutStyle(
                fontSize: 20, // Optional: Customize the strutStyle if needed
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 33,
            onPressed: () {
              // Add menu functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 25), // Space between AppBar and ListView
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                SizedBox(
                  height: 80, // Set height for button
                  child: _buildProfileButton(
                    icon: Icons.person,
                    text: 'Edit Profile',
                    onTap: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),
                ),
                const SizedBox(height: 10), // Gap between buttons
                SizedBox(
                  height: 80, // Set height for button
                  child: _buildProfileButton(
                    icon: Icons.notifications,
                    text: 'Notifications',
                    onTap: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                ),
                const SizedBox(height: 10), // Gap between buttons
                SizedBox(
                  height: 80, // Set height for button
                  child: _buildProfileButton(
                    icon: Icons.security,
                    text: 'Privacy',
                    onTap: () {
                      Navigator.pushNamed(context, '/privacy');
                    },
                  ),
                ),
                const SizedBox(height: 10), // Gap between buttons
                SizedBox(
                  height: 80, // Set height for button
                  child: _buildProfileButton(
                    icon: Icons.payment,
                    text: 'Payments',
                    onTap: () {
                      Navigator.pushNamed(context, '/payments');
                    },
                  ),
                ),
                const SizedBox(height: 10), // Gap between buttons
                SizedBox(
                  height: 80, // Set height for button
                  child: _buildProfileButton(
                    icon: Icons.power_settings_new,
                    text: 'Logout',
                    onTap: () {
                      Navigator.pushNamed(context, '/logout');
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

  // Widget for building buttons on the profile page
  Widget _buildProfileButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

// MainPage with Bottom Navigation Bar
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Define pages corresponding to the icons
  final List<Widget> _pages = [
    HomePage(),
    BusPage(),
    LocationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Example'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Bus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Sample page for Home
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}

// Sample page for Bus
class BusPage extends StatefulWidget {
  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Bus Page'),
      ),
    );
  }
}

// Sample page for Location
class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Location Page'),
      ),
    );
  }
}

// Sample page for Profile
/*class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}*/
