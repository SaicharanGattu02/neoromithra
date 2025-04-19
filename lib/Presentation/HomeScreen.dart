import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuromithra/Presentation/LogIn.dart';
import 'package:neuromithra/Logic/Location/location_state.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import '../Logic/Location/location_cubit.dart';

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
    String nameInitial = (name.trim().isNotEmpty) ? name.trim()[0].toUpperCase() : "";
    return Scaffold(
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
              child:BlocConsumer<LocationCubit, LocationState>(
                listener: (context, state) {
                  if (state is LocationPermissionDenied) {
                    showLocationBottomSheet(context);
                  }
                },
                builder: (context, state) {
                  // Trigger permission check when the widget is built (optional)
                  // You can move this to initState or elsewhere if needed
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<LocationCubit>().checkLocationPermission();
                  });

                  if (state is LocationLoaded) {
                    return ElevatedButton.icon(
                      onPressed: makingSOSCall
                          ? null
                          : () {
                        // Make SOS call with the loaded location
                        _makeSOSCall(state.locationName);
                        print("location:${state.locationName}");
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.blue, // Keep background blue during loading
                        foregroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                              color: Colors.white), // Limit the size of the loader
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
                  } else if (state is LocationLoading) {
                    // Show a loading indicator while fetching location
                    return ElevatedButton.icon(
                      onPressed: null, // Disable button while loading
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: SizedBox.shrink(),
                      label: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  // Return a disabled button or empty container if no valid state
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
                          onTap: () {},
                          child: Container(
                            width: 170,
                            padding: EdgeInsets.all(8),
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
                          onTap: () {},
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

  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true, // Allows the bottom sheet to adjust to content size
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              print('Location Loaded');
              Navigator.pop(bottomSheetContext);
            }
          },
          builder: (context, state) {
            bool isLoading = state is LocationLoading;
            return WillPopScope(
              onWillPop: () async => !isLoading,
              child: SafeArea(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5, // Limit height
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Icon and Title
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.gps_fixed_sharp,
                                size: 24,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Enable Location Services',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          'Granting location permission ensures accurate address detection and a seamless service experience.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!isLoading)
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(bottomSheetContext);
                                },
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                context.read<LocationCubit>().requestLocationPermission();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                                  : const Text(
                                'GRANT',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}
