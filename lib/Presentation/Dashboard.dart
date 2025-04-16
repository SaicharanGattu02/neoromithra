import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuromithra/Presentation/HomeScreen.dart';
import 'package:neuromithra/Presentation/profile_screen.dart';

import 'CounsellingListScreen.dart';
import '../Logic/Location/location_cubit.dart';
import '../Logic/Location/location_state.dart';

import 'TherapiesListScreen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    context.read<LocationCubit>().checkLocationPermission();
    super.initState();
  }

  void onItemTapped(int selectedItems) {
    pageController.jumpToPage(selectedItems);
    setState(() {
      _selectedIndex = selectedItems;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child:  BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationPermissionDenied) {
            showLocationBottomSheet(context);
          }
        },
        child: Scaffold(
          body: PageView(
            onPageChanged: (value) {
              HapticFeedback.lightImpact();
            },
            controller: pageController,
            children: [
              HomeScreen(),
              TherapiesListScreen(),
              CounsellingListScreen(),
              ProfileScreen()
            ],
            physics: const NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -1),
                  blurRadius: 10,
                  color: (_selectedIndex != 0)
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.grey.withOpacity(0),
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12.0,
              unselectedFontSize: 9.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 0
                          ? Image.asset(
                        'assets/Vector.png',
                        width: 25,
                        height: 25,
                      )
                          : Image.asset(
                        'assets/filedhome.png',
                        width: 25,
                        height: 25,
                      ),
                      Text("Home"),
                    ],
                  ),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 1
                          ? Image.asset(
                        'assets/Vector1.png',
                        width: 25,
                        height: 25,
                        color:Colors.black,
                      )
                          : Image.asset(
                        'assets/unfilledtherapies.png',
                        width: 26,
                        height: 26,
                      ),
                      Text("Therapies"),
                    ],
                  ),
                  label: 'Therapies',
                ),

                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 2
                          ? Image.asset(
                        'assets/filledcounciling.png',
                        width: 25,
                        height: 25,
                        color:Colors.black,
                      )
                          : Image.asset(
                        'assets/discussion.png',
                        width: 25,
                        height: 25,
                      ),
                      Text("Counselling"),
                    ],
                  ),
                  label: 'Counselling',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      _selectedIndex == 3
                          ? Image.asset(
                        'assets/profile-filled.png',
                        width: 25,
                        height: 25,
                        color:Colors.black,
                      )
                          : Image.asset(
                        'assets/profunfiled.png',
                        width: 25,
                        height: 25,
                      ),
                      Text("Profile"),
                    ],
                  ),
                  label: 'Counselling',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: onItemTapped,
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
