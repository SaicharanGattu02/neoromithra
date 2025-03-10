import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuromithra/NewHomeScreen.dart';
import 'package:neuromithra/profile_screen.dart';
import 'CounsellingListScreen.dart';
import 'TherapiesListScreen.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({super.key});

  @override
  State<MainDashBoard> createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = NewHomeScreen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Image.asset(
            'assets/sos.png',
            fit: BoxFit.cover,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            color: Color(0xffF3EFEF),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded( // Added Expanded
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = NewHomeScreen();
                            _selectedIndex = 0;
                          });
                        },
                        child: Column(
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
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = TherapiesListScreen();
                            _selectedIndex = 1;
                          });
                        },
                        child: Column(
                          children: [
                            _selectedIndex == 1
                                ? Image.asset(
                              'assets/Physical Therapy.png',
                              width: 25,
                              height: 25,
                              color: Colors.black,
                            )
                                : Image.asset(
                              'assets/Physical Therapy.png',
                              width: 26,
                              height: 26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40), // Space for the FAB
                Expanded( // Added Expanded
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = CounsellingListScreen();
                            _selectedIndex = 2;
                          });
                        },
                        child: Column(
                          children: [
                            _selectedIndex == 2
                                ? Image.asset(
                              'assets/consultation.png',
                              width: 25,
                              height: 25,
                            )
                                : Image.asset(
                              'assets/consultation.png',
                              width: 25,
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = ProfileScreen();
                            _selectedIndex = 3;
                          });
                        },
                        child: Column(
                          children: [
                            _selectedIndex == 3
                                ? Image.asset(
                              'assets/profile-filled.png',
                              width: 25,
                              height: 25,
                              color: Colors.black,
                            )
                                : Image.asset(
                              'assets/profile-filled.png',
                              width: 26,
                              height: 26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
