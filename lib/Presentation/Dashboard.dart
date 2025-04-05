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

}
