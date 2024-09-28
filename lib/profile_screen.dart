import 'package:flutter/material.dart';
import 'package:neuromithra/Aboutus.dart';
import 'package:neuromithra/AddAddressScreen.dart';
import 'package:neuromithra/CancellationPolicyScreen.dart';
import 'package:neuromithra/PrivacyPolicyScreen.dart';
import 'package:neuromithra/ReturnRefundPolicyScreen.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'AddRating.dart';
import 'AddressListScreen.dart';
import 'Editprofile _screen.dart';
import 'LastBooking.dart';
import 'LogIn.dart';
import 'Model/ProfileDetailsModel.dart'; // Import the Edit Profile Screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool is_loading=true;
  @override
  void initState() {
    GetProfileDetails();
    super.initState();
  }
  ProfileDetailsModel user_data = ProfileDetailsModel();
  Future<void> GetProfileDetails() async {
    String user_id = await PreferenceService().getString('user_id')??"";
    final Response = await Userapi.getprofiledetails(user_id);
    if (Response != null) {
      setState(() {
        user_data=Response;
        is_loading=false;
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
      body: (is_loading)?Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ):
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text(
                        (user_data?.name != null && user_data!.name!.isNotEmpty)
                            ? user_data!.name![0].toUpperCase()
                            : '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      backgroundColor: Colors.blue, // Customize the background color
                      radius: 30,
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( "${user_data?.name}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Inter",
                        ),),
                        Text("${user_data?.email}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                // InkResponse(
                //     onTap: () {
                //       // Navigate to Edit Profile screen when image is tapped
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => EditProfileScreen()),
                //       );
                //     },
                //     child: Image(image: AssetImage("assets/Fill 1.png"),height: 20,width: 25,color: Colors.blue,)),
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
              leading: Icon(Icons.info_outline),
              title: Text('About Us'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.area_chart_outlined),
              title: Text('Address List'),
              onTap: () {
                // Navigate to About Us screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined,color: Color(0xff000000),),
              title: Text('Log out'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },

            ),
          ],
        ),
      ),
    );
  }
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                PreferenceService().clearPreferences();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn()));
                print('User logged out');
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
