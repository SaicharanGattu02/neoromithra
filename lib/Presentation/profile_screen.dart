import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Providers/SignInProviders.dart';
import 'package:neuromithra/Providers/UserProvider.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:provider/provider.dart';
import '../Components/Shimmers.dart';
import '../services/AuthService.dart';
import '../utils/Color_Constants.dart';
import 'Editprofile _screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!await AuthService.isGuest) {
        Provider.of<UserProviders>(context, listen: false).getProfileDetails();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
            color: primarycolor,
            fontSize: 20,
          ),
        ),
        leading: IconButton.filled(
          icon: const Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () {
            context.push("/main_dashBoard?initialIndex=0");
          },
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFECFAFA),
          ),
        ),
      ),
      body: FutureBuilder<bool>(
        future: AuthService.isGuest,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final isGuest = snapshot.data!;

          return Consumer<UserProviders>(
              builder: (context, profileDetails, child) {
            return profileDetails.isLoading
                ? _buildShimmerEffect()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: primarycolor,
                              backgroundImage: (!isGuest &&
                                      profileDetails.userData.profilePicUrl !=
                                          null &&
                                      profileDetails
                                          .userData.profilePicUrl!.isNotEmpty)
                                  ? CachedNetworkImageProvider(profileDetails
                                      .userData
                                      .profilePicUrl!) as ImageProvider<Object>
                                  : null,
                              child: (!isGuest &&
                                      (profileDetails.userData.profilePicUrl ==
                                              null ||
                                          profileDetails
                                              .userData.profilePicUrl!.isEmpty))
                                  ? Text(
                                      (profileDetails.userData.name != null &&
                                              profileDetails
                                                  .userData.name!.isNotEmpty)
                                          ? profileDetails.userData.name![0]
                                              .toUpperCase()
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontFamily: "general_sans",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : isGuest
                                      ? const Text(
                                          'G',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontFamily: "general_sans",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : null,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isGuest
                                        ? 'Guest User'
                                        : (profileDetails.userData.name !=
                                                    null &&
                                                profileDetails
                                                    .userData.name!.isNotEmpty
                                            ? '${profileDetails.userData.name![0].toUpperCase()}${profileDetails.userData.name!.substring(1)}'
                                            : 'Unknown'),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "general_sans",
                                      color: Colors.black87,
                                    ),
                                  ),
                                  if (!isGuest)
                                    Text(
                                      profileDetails.userData.email ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade600,
                                        fontFamily: "general_sans",
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (!isGuest)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: primarycolor.withOpacity(0.6)),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: primarycolor,
                                    size: 16,
                                  ),
                                ),
                              )
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            children: [
                              if (!isGuest)
                                _buildOptionTile(
                                    Icons.history, 'Booking History', () {
                                  context.push('/booking_history');
                                }),
                              if (!isGuest)
                                _buildOptionTile(
                                    Icons.location_on_outlined, 'Address List',
                                    () {
                                  context.push("/address_list");
                                }),
                              _buildOptionTile(
                                  Icons.support, 'Govt Support Information',
                                  () {
                                context.push("/govt_support_info");
                              }),
                              _buildOptionTile(Icons.info_outline, 'About Us',
                                  () {
                                context.push("/about_us");
                              }),
                              _buildOptionTile(
                                  Icons.privacy_tip_outlined, 'Privacy Policy',
                                  () {
                                context.push("/privacy_policy");
                              }),
                              _buildOptionTile(
                                  Icons.policy_outlined, 'Terms and Conditions',
                                  () {
                                context.push("/terms_conditions");
                              }),
                              _buildOptionTile(Icons.assignment_return_outlined,
                                  'Refund Policy', () {
                                context.push("/refund_policy");
                              }),
                              !isGuest
                                  ? _buildOptionTile(
                                      Icons.delete_outline_sharp,
                                      'Delete Account', () {
                                DeleteAccountConfirmation
                                    .showDeleteConfirmationSheet(context);
                                    })
                                  : _buildOptionTile(
                                      Icons.login, 'Login', () {
                                      context.go('/login_with_mobile');
                                    }),

                              SizedBox(height: 10),
                              !isGuest
                                  ? _buildLogoutTile(context)
                                  : _buildOptionTile(Icons.login, 'Login', () {
                                context.go('/login_with_mobile');
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          });
        },
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              shimmerCircle(70, context),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerText(120, 16, context),
                  SizedBox(height: 5),
                  shimmerText(140, 12, context),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          shimmerContainer(MediaQuery.of(context).size.width, 80, context),
          SizedBox(height: 15),
          shimmerContainer(MediaQuery.of(context).size.width, 80, context),
          SizedBox(height: 15),
          shimmerContainer(MediaQuery.of(context).size.width, 80, context),
          SizedBox(height: 15),
          shimmerContainer(MediaQuery.of(context).size.width, 80, context),
          SizedBox(height: 15),
          shimmerContainer(MediaQuery.of(context).size.width, 80, context),
        ],
      ),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red,
            fontFamily: "general_sans",
          ),
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
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: primarycolor.withOpacity(0.1),
        child: Icon(icon, color: primarycolor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: "general_sans",
        ),
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
                            color: primarycolor,
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
                                    primarycolor, // Filled button color
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
                          SizedBox(
                            width: 100,
                            child: OutlinedButton(
                              onPressed: () async {
                                PreferenceService().remove("access_token");
                                context.go("/login_with_mobile");
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primarycolor, // Text color
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36)),
                                side: BorderSide(
                                    color: primarycolor), // Border color
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

class DeleteAccountConfirmation {
  static void showDeleteConfirmationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
              return Consumer<SignInProviders>(
                builder: (context, signInProvider, child) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          'Are you sure you want to delete your account?',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black87,
                              height: 1.5,
                              fontWeight: FontWeight.w600,
                            fontFamily: "general_sans",),
                          textAlign: TextAlign.center,
                        ),
                        // Description
                        Text(
                          'All your data, including Booking history and preferences, will be permanently removed.',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: signInProvider.isLoading
                                    ? null
                                    : () {
                                  context.pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey[400]!),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "general_sans",
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: signInProvider.isLoading
                                    ? null
                                    : () async {
                                  var res = await signInProvider.deleteAccount();
                                  if(res?.status==true){
                                    context.go('/login_with_mobile');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                  backgroundColor: primarycolor,
                                  foregroundColor: primarycolor,
                                ),
                                child:signInProvider.isLoading
                                    ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : const Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "general_sans",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              );
          },
        );
      },
    );
  }
}
