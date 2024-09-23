import 'package:flutter/material.dart';
import 'package:neuromithra/Aboutus%20_Screen.dart';
import 'package:neuromithra/Booking%20History%20screen.dart';
import 'package:neuromithra/Settings_Screen.dart';

import 'Editprofile _screen.dart'; // Import the Edit Profile Screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            // Static Profile Image with tap functionality
            GestureDetector(
              onTap: () {
                // Navigate to Edit Profile screen when image is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage('assets/images/profile-filled.png'), // Local asset image
              ),
            ),
            const SizedBox(height: 20),
            // Settings Option
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings screen
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            // Booking History Option
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Booking History'),
              onTap: () {
                // Navigate to Booking History screen
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BookingHistory()));
              },
            ),
            // About Us Option
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_rounded),
              title: Text('Privacy Policy'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.login_rounded),
              title: Text('Log out'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
