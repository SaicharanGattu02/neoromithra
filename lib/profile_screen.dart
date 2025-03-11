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
import 'GovtSupportinfo.dart';
import 'LastBooking.dart';
import 'LogIn.dart';
import 'Model/ProfileDetailsModel.dart'; // Import the Edit Profile Screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool is_loading = true;
  @override
  void initState() {
    GetProfileDetails();
    super.initState();
  }

  User user_data= User();
  Future<void> GetProfileDetails() async {
    String user_id = await PreferenceService().getString('user_id') ?? "";
    final Response = await Userapi.getprofiledetails(user_id);
    if (Response != null) {
      setState(() {
        user_data = Response.user??User();
        is_loading = false;
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
      body: (is_loading)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  child: Text(
                                    (user_data?.name != null &&
                                            user_data!.name!.isNotEmpty)
                                        ? user_data!.name![0].toUpperCase()
                                        : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  backgroundColor: Colors
                                      .blue, // Customize the background color
                                  radius: 30,
                                ),
                                Positioned(
                                    right: -10,
                                    bottom: -8,
                                    child: Container(height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,

                                      ),
                                      child: IconButton(visualDensity: VisualDensity.compact,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfileScreen()));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: 16,
                                          )),
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user_data?.name}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                Text(
                                  "${user_data?.email}",
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
                      ]),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Booking History'),
                    onTap: () {
                      // Navigate to Booking History screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LastBooking()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.support),
                    title: Text('Govt Support information'),
                    onTap: () {
                      // Navigate to About Us screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SupportProgramsScreen()));
                    },
                  ),
                  // About Us Option
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('About Us'),
                    onTap: () {
                      // Navigate to About Us screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy Policy'),
                    onTap: () {
                      // Navigate to About Us screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.area_chart_outlined),
                    title: Text('Address List'),
                    onTap: () {
                      // Navigate to About Us screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressListScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Color(0xff000000),
                    ),
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
        return Dialog(
          elevation: 4.0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Power Icon Positioned Above Dialog
                Positioned(
                  top: -35.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6.0, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.red.shade100, // Light red background
                    ),
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 40.0,
                      color: Colors.red, // Power icon color
                    ),
                  ),
                ),

                // Dialog Content
                Positioned.fill(
                  top: 30.0, // Moves content down
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff27BDBE),
                              fontFamily: "Poppins"),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontFamily: "Poppins"),
                        ),
                        const SizedBox(height: 20.0),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // No Button (Filled)
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                  Color(0xff27BDBE), // Filled button color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),

                            // Yes Button (Outlined)
                            SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () async {
                                  PreferenceService().clearPreferences();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LogIn()));
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                  Color(0xff27BDBE), // Text color
                                  side: BorderSide(
                                      color: Color(0xff27BDBE)), // Border color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
