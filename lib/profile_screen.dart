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
          :Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue.shade700,
                        child: Text(
                          (user_data.name!.isNotEmpty)
                              ? user_data.name![0].toUpperCase()
                              : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditProfileScreen()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user_data.name??"",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      user_data.email??"",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildOptionTile(Icons.history, 'Booking History', () {
                    Navigator.of(context)
                        .push(PageRouteBuilder(
                      pageBuilder: (context,
                          animation,
                          secondaryAnimation) {
                        return LastBooking();
                      },
                      transitionsBuilder:
                          (context,
                          animation,
                          secondaryAnimation,
                          child) {
                        const begin =
                        Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve =
                            Curves.easeInOut;
                        var tween = Tween(
                            begin: begin,
                            end: end)
                            .chain(CurveTween(
                            curve: curve));
                        var offsetAnimation =
                        animation
                            .drive(tween);
                        return SlideTransition(
                            position:
                            offsetAnimation,
                            child: child);
                      },
                    ));
                  }),
                  _buildOptionTile(Icons.support, 'Govt Support Information', () {
                    Navigator.of(context)
                        .push(PageRouteBuilder(
                      pageBuilder: (context,
                          animation,
                          secondaryAnimation) {
                        return SupportProgramsScreen();
                      },
                      transitionsBuilder:
                          (context,
                          animation,
                          secondaryAnimation,
                          child) {
                        const begin =
                        Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve =
                            Curves.easeInOut;
                        var tween = Tween(
                            begin: begin,
                            end: end)
                            .chain(CurveTween(
                            curve: curve));
                        var offsetAnimation =
                        animation
                            .drive(tween);
                        return SlideTransition(
                            position:
                            offsetAnimation,
                            child: child);
                      },
                    ));
                  }),
                  _buildOptionTile(Icons.info_outline, 'About Us', () {
                    Navigator.of(context)
                        .push(PageRouteBuilder(
                      pageBuilder: (context,
                          animation,
                          secondaryAnimation) {
                        return AboutUsScreen();
                      },
                      transitionsBuilder:
                          (context,
                          animation,
                          secondaryAnimation,
                          child) {
                        const begin =
                        Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve =
                            Curves.easeInOut;
                        var tween = Tween(
                            begin: begin,
                            end: end)
                            .chain(CurveTween(
                            curve: curve));
                        var offsetAnimation =
                        animation
                            .drive(tween);
                        return SlideTransition(
                            position:
                            offsetAnimation,
                            child: child);
                      },
                    ));
                  }),
                  _buildOptionTile(Icons.privacy_tip_outlined, 'Privacy Policy', () {
                    Navigator.of(context)
                        .push(PageRouteBuilder(
                      pageBuilder: (context,
                          animation,
                          secondaryAnimation) {
                        return PrivacyPolicyScreen();
                      },
                      transitionsBuilder:
                          (context,
                          animation,
                          secondaryAnimation,
                          child) {
                        const begin =
                        Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve =
                            Curves.easeInOut;
                        var tween = Tween(
                            begin: begin,
                            end: end)
                            .chain(CurveTween(
                            curve: curve));
                        var offsetAnimation =
                        animation
                            .drive(tween);
                        return SlideTransition(
                            position:
                            offsetAnimation,
                            child: child);
                      },
                    ));
                  }),
                  _buildOptionTile(Icons.location_on_outlined, 'Address List', () {
                    Navigator.of(context)
                        .push(PageRouteBuilder(
                      pageBuilder: (context,
                          animation,
                          secondaryAnimation) {
                        return AddressListScreen();
                      },
                      transitionsBuilder:
                          (context,
                          animation,
                          secondaryAnimation,
                          child) {
                        const begin =
                        Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve =
                            Curves.easeInOut;
                        var tween = Tween(
                            begin: begin,
                            end: end)
                            .chain(CurveTween(
                            curve: curve));
                        var offsetAnimation =
                        animation
                            .drive(tween);
                        return SlideTransition(
                            position:
                            offsetAnimation,
                            child: child);
                      },
                    ));
                  }),
                  SizedBox(height: 10),
                  _buildLogoutTile(context),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.red.shade50,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: Icon(Icons.logout_outlined, color: Colors.red),
        ),
        title: Text(
          "Log out",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
        ),
        onTap: () {
          _showLogoutConfirmationDialog(context);
        },
      ),
    );
  }
}

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
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
                            color: Color(0xff3EA4D2),
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
                                Color(0xff3EA4D2), // Filled button color
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
                                Color(0xff3EA4D2), // Text color
                                side: BorderSide(
                                    color: Color(0xff3EA4D2)), // Border color
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

