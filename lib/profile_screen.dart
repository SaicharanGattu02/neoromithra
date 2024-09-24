import 'package:flutter/material.dart';
import 'package:neuromithra/Aboutus.dart';
import 'package:neuromithra/PrivacyPolicyScreen.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'AddRating.dart';
import 'Editprofile _screen.dart';
import 'LastBooking.dart';
import 'Model/ProfileDetailsModel.dart'; // Import the Edit Profile Screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    GetProfileDetails();
    super.initState();
  }
  ProfilePicture? profilePicture;
  Future<void> GetProfileDetails() async {
    String user_id = await PreferenceService().getString('user_id')??"";
    final registerResponse = await Userapi.getprofiledetails(user_id);
    if (registerResponse != null) {
      setState(() {
        if (registerResponse.status == true) {
          profilePicture=registerResponse.profilePicture;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
        leading: Container(),
        leadingWidth: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to Edit Profile screen when image is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfileScreen()),
                        );
                      },
                      child: ClipOval(
                        child: Container(
                          width: 80, // Set width for the oval
                          height: 80, // Set height for the oval
                          color: Colors.grey[300], // Background color when the image is loading
                          child: Image.network(
                            "${profilePicture?.userProfile}", // Local asset image
                            fit: BoxFit.cover, // Cover the entire oval
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( "${profilePicture?.name}"),
                        Text("${profilePicture?.email}"),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Image(image: AssetImage("assets/Fill 1.png"),height: 20,width: 25,),
              ]
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Booking History'),
              onTap: () {
                // Navigate to Booking History screen
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LastBooking()));
              },
            ),
            // About Us Option
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_rounded),
              title: Text('Privacy Policy'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.login_rounded),
              title: Text('Log out'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductRating(app_id: "",page_source: "",)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
