import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuromithra/Presentation/LogIn.dart';
import 'package:neuromithra/Logic/Location/location_state.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';

import '../CounsellingScreens/BehavioralCounsellingScreen.dart';
import '../CounsellingScreens/CareerCounsellingScreen.dart';
import '../CounsellingScreens/CrisisCounsellingScreen.dart';
import '../CounsellingScreens/EducationalCounsellingScreen.dart';
import '../CounsellingScreens/FamilyCounsellingScreen.dart';
import '../CounsellingScreens/GeneralStressManagementCounsellingScreen.dart';
import '../CounsellingScreens/GriefCounsellingScreen.dart';
import '../CounsellingScreens/GroupCounsellingScreen.dart';
import '../CounsellingScreens/IndividualCounsellingForChildrenScreen.dart';
import '../CounsellingScreens/MentalHealthCounsellingScreen.dart';
import '../CounsellingScreens/ParentChildRelationshipCounsellingScreen.dart';
import '../CounsellingScreens/ParentCounsellingForAutismScreen.dart';
import '../CounsellingScreens/RelationshipCounsellingScreen.dart';
import '../CounsellingScreens/SiblingCounsellingScreen.dart';
import '../Logic/Location/location_cubit.dart';
import '../TherapyScreens/ABA_TherapyScreen.dart';
import '../TherapyScreens/ArtTherapyScreen.dart';
import '../TherapyScreens/BehavioralTherapyScreen.dart';
import '../TherapyScreens/CBT_Screen.dart';
import '../TherapyScreens/DevelopmentalTherapyScreen.dart';
import '../TherapyScreens/FeedingTherapyScreen.dart';
import '../TherapyScreens/MusicTherapyScreen.dart';
import '../TherapyScreens/OccupationalTherapyScreen.dart';
import '../TherapyScreens/PhysicalTherapyScreen.dart';
import '../TherapyScreens/PlayTherapyScreen.dart';
import '../TherapyScreens/SensoryIntegrationTherapyScreen.dart';
import '../TherapyScreens/SocialSkillsTrainingScreen.dart';
import '../TherapyScreens/SpeechTheraphyScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool onclick = false;
  String profile_image = "";
  String name = "";

  final List<Map<String, String>> items = [
    {'image': 'assets/Therephy/speech_theraphy.jpg', 'text': 'Speech Therapy'},
    {
      'image': 'assets/Therephy/occupational_theraphy.jpeg',
      'text': 'Occupational Therapy'
    },
    {
      'image': 'assets/Therephy/physical_theraphy.jpeg',
      'text': 'Physical Therapy'
    },
    {
      'image': 'assets/Therephy/behavioural_theraphy.jpg',
      'text': 'Behavioral Therapy'
    },
    {'image': 'assets/Therephy/ABA_theraphy.jpeg', 'text': 'ABA Therapy'},
    {
      'image': 'assets/Therephy/sensor_integration.jpeg',
      'text': 'Sensory Integration Therapy'
    },
    {'image': 'assets/Therephy/play_theraphy.png', 'text': 'Play Therapy'},
    {
      'image': 'assets/Therephy/feeding_theraphy.jpg',
      'text': 'Feeding Therapy'
    },
    {
      'image': 'assets/Therephy/cbt_theraphy.jpeg',
      'text': 'Cognitive Behavioral Therapy(CBT)'
    },
    {
      'image': 'assets/Therephy/socail_skill_theraphy.jpeg',
      'text': 'Social Skills Training Therapy'
    },
    {'image': 'assets/Therephy/music_theraphy.jpeg', 'text': 'Music Therapy'},
    {'image': 'assets/Therephy/art_theraphy.png', 'text': 'Art Therapy'},
    {
      'image': 'assets/Therephy/development_theraphy.jpeg',
      'text': 'Developmental Therapy'
    },
  ];

  final List<Map<String, String>> items1 = [
    {
      'image': 'assets/Counciling/relationship_counsiling.jpeg',
      'text': 'Relationship Counselling'
    },
    {
      'image': 'assets/Counciling/behavioral_counciling.jpeg',
      'text': 'Behavioral Counselling'
    },
    {
      'image': 'assets/Counciling/grief_counsiling.jpeg',
      'text': 'Grief Counselling'
    },
    {
      'image': 'assets/Counciling/group_counsiling.jpeg',
      'text': 'Group Counselling'
    },
    {
      'image': 'assets/Counciling/crisis_counsiling.jpeg',
      'text': 'Crisis Counselling'
    },
    {
      'image': 'assets/Counciling/carreer_counsling.jpeg',
      'text': 'Career Counselling for parents'
    },
    {
      'image': 'assets/Counciling/sibiling_counciling.jpeg',
      'text': 'Sibling Counselling'
    },
    {
      'image': 'assets/Counciling/educationol_counsiling.jpeg',
      'text': 'Educational Counselling'
    },
    {
      'image': 'assets/Counciling/parent_children_relationship.jpeg',
      'text': 'Parent-Child Relationship Counselling'
    },
    {
      'image': 'assets/Counciling/individual_counsilng_children.jpeg',
      'text': 'Individual Counselling for children'
    },
    {
      'image': 'assets/Counciling/family_counsiling.jpeg',
      'text': 'Family Counselling'
    },
    {
      'image': 'assets/Counciling/mental_health_counsiling.jpeg',
      'text': 'Mental Health Counselling'
    },
    {
      'image': 'assets/Counciling/generalstress_councsiling.jpeg',
      'text': 'General stress management Counselling'
    },
    {
      'image': 'assets/Counciling/autism_Counsiling.png',
      'text': 'Parent Counselling for Autism'
    },
  ];

  @override
  void initState() {

    super.initState();
  }

  void _navigateToDetails(BuildContext context, String text) {
    Widget detailsScreen;

    switch (text) {
      case 'Speech Therapy':
        detailsScreen = SpeechTherapyScreen();
        break;
      case 'Occupational Therapy':
        detailsScreen = OccupationalTherapyScreen();
        break;
      case 'Physical Therapy':
        detailsScreen = PhysicalTherapyScreen();
        break;
      case 'Behavioral Therapy':
        detailsScreen = BehavioralTherapyScreen();
        break;
      case 'ABA Therapy':
        detailsScreen = ABA_TherapyScreen();
        break;
      case 'Sensory Integration Therapy':
        detailsScreen = SensoryIntegrationTherapyScreen();
        break;
      case 'Play Therapy':
        detailsScreen = PlayTherapyScreen();
        break;
      case 'Feeding Therapy':
        detailsScreen = FeedingTherapyScreen();
        break;
      case 'Cognitive Behavioral Therapy(CBT)':
        detailsScreen = CBT_Screen();
        break;
      case 'Social Skills Training Therapy':
        detailsScreen = SocialSkillsTrainingScreen();
        break;
      case 'Music Therapy':
        detailsScreen = MusicTherapyScreen();
        break;
      case 'Art Therapy':
        detailsScreen = ArtTherapyScreen();
        break;
      case 'Developmental Therapy':
        detailsScreen = DevelopmentalTherapyScreen();
        break;
      default:
        detailsScreen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailsScreen),
    );
  }

  void _onCounsellingTap(BuildContext context, String text) {
    Widget screen;
    switch (text) {
      case 'Relationship Counselling':
        screen = RelationshipCounsellingScreen();
        break;
      case 'Behavioral Counselling':
        screen = BehavioralCounsellingScreen();
        break;
      case 'Grief Counselling':
        screen = GriefCounsellingScreen();
        break;
      case 'Group Counselling':
        screen = GroupCounsellingScreen();
        break;
      case 'Crisis Counselling':
        screen = CrisisCounsellingScreen();
        break;
      case 'Career Counselling for parents':
        screen = CareerCounsellingScreen();
        break;
      case 'Sibling Counselling':
        screen = SiblingCounsellingScreen();
        break;
      case 'Educational Counselling':
        screen = EducationalCounsellingScreen();
        break;
      case 'Parent-Child Relationship Counselling':
        screen = ParentChildRelationshipCounsellingScreen();
        break;
      case 'Individual Counselling for children':
        screen = IndividualCounsellingForChildrenScreen();
        break;
      case 'Family Counselling':
        screen = FamilyCounsellingScreen();
        break;
      case 'Mental Health Counselling':
        screen = MentalHealthCounsellingScreen();
        break;
      case 'General stress management':
        screen = GeneralStressManagementCounsellingScreen();
        break;
      case 'Parent Counselling for Autism':
        screen = ParentCounsellingForAutismScreen();
        break;
      default:
        screen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  bool makingSOSCall = false;

  void _makeSOSCall(loc) async {
    setState(() {
      makingSOSCall = true;
    });
    try {
      var res = await Userapi.makeSOSCallApi(loc);
      setState(() {
        if (res != null) {
          makingSOSCall = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              res ?? "",
              style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xFF32657B),
          ));
        }
      });
    } catch (e) {
      debugPrint("${e.toString()}");
    }
  }


  Widget build(BuildContext context) {
    String nameInitial =
        (name.trim().isNotEmpty) ? name.trim()[0].toUpperCase() : "";
    return
      Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 50,
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child:
                  BlocBuilder<LocationCubit,LocationState>(builder: (context, state) {
                    if(state is LocationLoaded){
                      return
                        ElevatedButton.icon(
                        onPressed: makingSOSCall
                            ? null
                            : () {
                          _makeSOSCall(state.locationName);
                          print("loction:${state.locationName}");
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                          Colors.blue, // Keep background blue during loading
                          foregroundColor: Colors.blue,
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: makingSOSCall
                            ? SizedBox.shrink() // No icon when loading
                            : Icon(Icons.phone, color: Colors.white), // Phone icon
                        label: Center(
                          child: makingSOSCall
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors
                                    .white), // Limit the size of the loader
                          )
                              : Text(
                            "SOS Call",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Inter"),
                          ),
                        ),
                      );

                    }
                    return Container();

                  },


                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/homeimg.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Therapies",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return InkWell(
                              onTap: () =>
                                  _navigateToDetails(context, item['text']!),
                              child: Container(
                                width: 170,
                                padding: EdgeInsets.all(
                                    8), // Padding inside the item container
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          12), // Border radius for the image
                                      child: Image.asset(
                                        item['image']!,
                                        width: 150, // Adjust width as needed
                                        height: 106, // Adjust height as needed
                                        fit: BoxFit
                                            .cover, // Ensure image covers the container
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      item['text']!,
                                      textAlign:
                                          TextAlign.center, // Center-align text
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Inter"
                                          // Bold text
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        "Counselling",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 200, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: items1.length,
                          itemBuilder: (context, index) {
                            final item = items1[index];
                            return InkWell(
                              onTap: () =>
                                  _onCounsellingTap(context, item['text']!),
                              child: Container(
                                width: 170,
                                padding: EdgeInsets.all(
                                    8), // Padding inside the item container
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          12), // Border radius for the image
                                      child: Image.asset(
                                        item['image']!,
                                        width: 150, // Adjust width as needed
                                        height: 106, // Adjust height as needed
                                        fit: BoxFit
                                            .cover, // Ensure image covers the container
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      item['text']!,
                                      textAlign:
                                          TextAlign.center, // Center-align text
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Inter"
                                          // Bold text
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LogIn()));
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
