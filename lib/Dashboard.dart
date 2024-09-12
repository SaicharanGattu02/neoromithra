import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neuromithra/HomeScreen.dart';

import 'CounsellingListScreen.dart';
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
            ],
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );

  }
}
