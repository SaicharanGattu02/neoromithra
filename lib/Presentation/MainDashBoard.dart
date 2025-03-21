import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/Logic/Location/location_cubit.dart';
import 'package:neuromithra/Logic/Location/location_state.dart';
import 'package:neuromithra/Presentation/NewHomeScreen.dart';
import 'package:neuromithra/Presentation/profile_screen.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:overlay_support/overlay_support.dart';
import 'CounsellingListScreen.dart';
import 'SelectingTypes/GuideScreen.dart';
import 'SelectingTypes/Selecting_types.dart';
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
    ProfileScreen(),
    Guidescreen()
  ];

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
            physics: const NeverScrollableScrollPhysics(),
          ),
          // floatingActionButton: BlocBuilder<LocationCubit, LocationState>(
          //     builder: (context, state) {
          //   String loc = '';
          //   if (state is LocationLoaded) {
          //     loc = state.locationName;
          //   }
          //   return FloatingActionButton(
          //     onPressed: () {
          //       setState(() {
          //         _makeSOSCall(loc);
          //         print("loction:${loc}");
          //       });
          //     },
          //     child: makingSOSCall
          //         ? Padding(
          //             padding: const EdgeInsets.all(15.0),
          //             child: CircularProgressIndicator(
          //               strokeWidth: 0.5,
          //             ),
          //           )
          //         : Lottie.asset(
          //             'assets/animations/sos.json',
          //             width: 60,
          //             height: 60,
          //             fit: BoxFit.contain,
          //           ),
          //     backgroundColor: Colors.white,
          //     shape: CircleBorder(),
          //     elevation: 4.0,
          //   );
          // }),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            surfaceTintColor: Colors.blue,
            // shape: CircularNotchedRectangle(),
            // notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildIconButton('assets/Home.png', "Home", 0),
                _buildIconButton('assets/therapy.png', "Therapies", 1),
                _buildIconButton('assets/consultation.png', "Counselling", 2),
                _buildIconButton('assets/UserCircle.png', "Profile", 3),
                // _buildIconButton('assets/Info.png', "Info", 4),
                _buildIconButton('assets/guide.png', "Guide", 5),
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
                                  context
                                      .read<LocationCubit>()
                                      .requestLocationPermission();
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

  Widget _buildIconButton(String iconPath, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Image.asset(
            iconPath,
            width: 25,
            height: 25,
            color: isSelected ? Colors.black : Colors.grey, // Selected vs Unselected color
          ),
          onPressed: () {
            onItemTapped(index);
          },
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            color: isSelected ? Colors.black : Colors.grey, // Match icon color
          ),
        ),
      ],
    );
  }

}
