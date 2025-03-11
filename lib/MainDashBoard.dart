import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/Logic/Location/location_cubit.dart';
import 'package:neuromithra/Logic/Location/location_state.dart';
import 'package:neuromithra/NewHomeScreen.dart';
import 'package:neuromithra/profile_screen.dart';
import 'package:neuromithra/services/userapi.dart';
import 'CounsellingListScreen.dart';
import 'TherapiesListScreen.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({super.key});

  @override
  State<MainDashBoard> createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  int _selectedIndex = 0; // Default index for the selected screen
  PageController pageController = PageController();

  // Method to handle tap on bottom navigation bar items
  void onItemTapped(int selectedItems) {
    pageController.jumpToPage(selectedItems);
    setState(() {
      _selectedIndex = selectedItems;
    });
  }

  final List<Widget> screen = [
    NewHomeScreen(),
    TherapiesListScreen(),
    CounsellingListScreen(),
    ProfileScreen()
  ];
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
  @override
  void initState() {
    context.read<LocationCubit>().checkLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationPermissionDenied) {
            showLocationBottomSheet(context);
          }
        },
        child: Scaffold(
          body: PageView(
            onPageChanged: (value) {
              setState(() {
                _selectedIndex = value;
              });
              HapticFeedback.lightImpact();
            },
            controller: pageController,
            children: screen,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures
          ),
          floatingActionButton: BlocBuilder<LocationCubit,LocationState>(builder: (context, state) {
            if(state is LocationLoaded){
              return Container(
                color: Colors.white,
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _makeSOSCall(state.locationName);
                      print("loction:${state.locationName}");
                    });
                  },
                  child: Lottie.asset(
                    'assets/animations/sos.json',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  elevation: 4.0,
                ),
              );
            }return Container(
              color: Colors.white,
              width: 60,
              height: 60,
              child: Lottie.asset(
                'assets/animations/sos.json',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            );
          },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            surfaceTintColor: Colors.blue,
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Home and Therapies icons
                _buildIconButton('assets/filedhome.png', 0),
                _buildIconButton('assets/Physical Therapy.png', 1),
                SizedBox(width: 48), // Empty space for Floating Action Button
                // Counselling and Profile icons
                _buildIconButton('assets/consultation.png', 2),
                _buildIconButton('assets/profile-filled.png', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext bottomSheetContext) {
        return BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              print('loadided');
              Navigator.pop(bottomSheetContext);
            }
          },
          builder: (context, state) {
            bool isLoading = state is LocationLoading;
            return WillPopScope(
              onWillPop: () async => !isLoading,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gps_fixed_sharp, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          'Location Permission is Off',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                            // Request location permission when user taps the 'GRANT' button
                            context.read<LocationCubit>().requestLocationPermission();
                          },
                          child: isLoading
                              ? CircularProgressIndicator(strokeWidth: 2)
                              : const Text('GRANT'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Granting location permission will ensure accurate address and hassle-free service.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  // Method to build icon buttons for the bottom navigation bar
  Widget _buildIconButton(String iconPath, int index) {
    bool isSelected = _selectedIndex == index;

    return IconButton(
      icon: Image.asset(
        iconPath,
        width: 25,
        height: 25,
        color: isSelected ? Colors.black : Colors.black.withOpacity(0.5), // Selected vs Unselected color
      ),
      onPressed: () {
        onItemTapped(index);
      },
    );
  }
}
