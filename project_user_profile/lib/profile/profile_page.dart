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
          icon: const Icon(Icons.arrow_back),iconSize: 33, // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Action to navigate back
          },
        ),
        title: const Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/passenger.png'), // Add your avatar image here
              radius: 22,
            ),
            SizedBox(width: 10),
            Text(
              'Profile',
              style: TextStyle( // Use TextStyle to define the text's font weight
                fontWeight: FontWeight.bold, // Correct way to set font weight
                fontSize: 25, // Add font size if necessary
              ),
              strutStyle: StrutStyle(
                fontSize: 20, // Optional: Customize the strutStyle if needed
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.menu),iconSize: 33,
            onPressed: () {
              // Add menu functionality here
            },
          ),
        ],
      ),


      body: Column(
        children: [
          // Space between AppBar and ListView
          const SizedBox(height: 25),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                // Edit Profile button with height
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

                // Notifications button with height
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

                // Privacy button with height
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

                // Payments button with height
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

                // Logout button with height
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Highlight the 4th item (index starts from 0)
        selectedItemColor: Colors.black, // Selected icon color
        unselectedItemColor: Colors.grey, // Unselected icon color
        backgroundColor:
            Colors.orange, // Background color for the BottomNavigationBar
        type: BottomNavigationBarType.fixed, // Prevent shifting effect
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '', // Remove label text if you don't need it
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
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
