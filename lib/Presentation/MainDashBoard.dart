import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuromithra/Logic/Location/location_cubit.dart';
import 'package:neuromithra/Logic/Location/location_state.dart';
import 'package:neuromithra/Presentation/NewHomeScreen.dart';
import 'package:neuromithra/Presentation/profile_screen.dart';
import 'CounsellingListScreen.dart';
import 'SelectingTypes/GuideScreen.dart';
import 'TherapiesListScreen.dart';


class MainDashBoard extends StatefulWidget {
  final int initialIndex; // Add this
  const MainDashBoard({super.key, this.initialIndex = 0}); // Default to Home

  @override
  State<MainDashBoard> createState() => _MainDashBoardState();
}


class _MainDashBoardState extends State<MainDashBoard> {
  late int _selectedIndex;
  late PageController pageController;

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
    _selectedIndex = widget.initialIndex; // Use the passed index
    pageController = PageController(initialPage: widget.initialIndex); // Initialize controller
    // context.read<LocationCubit>().checkLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
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
        //         debugPrint("loction:${loc}");
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
    );
  }

  // void showLocationBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isDismissible: false,
  //     enableDrag: false,
  //     isScrollControlled: true, // Allows the bottom sheet to adjust to content size
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
  //     ),
  //     builder: (BuildContext bottomSheetContext) {
  //       return BlocConsumer<LocationCubit, LocationState>(
  //         listener: (context, state) {
  //           if (state is LocationLoaded) {
  //             debugPrint('Location Loaded');
  //             Navigator.pop(bottomSheetContext);
  //           }
  //         },
  //         builder: (context, state) {
  //           bool isLoading = state is LocationLoading;
  //           return WillPopScope(
  //             onWillPop: () async => !isLoading,
  //             child: SafeArea(
  //               child: ConstrainedBox(
  //                 constraints: BoxConstraints(
  //                   maxHeight: MediaQuery.of(context).size.height * 0.5, // Limit height
  //                 ),
  //                 child: Container(
  //                   padding: const EdgeInsets.all(20.0),
  //                   decoration: BoxDecoration(
  //                     color: Theme.of(context).scaffoldBackgroundColor,
  //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
  //                   ),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Header with Icon and Title
  //                       Row(
  //                         children: [
  //                           Container(
  //                             padding: const EdgeInsets.all(8.0),
  //                             decoration: BoxDecoration(
  //                               color: Theme.of(context).primaryColor.withOpacity(0.1),
  //                               shape: BoxShape.circle,
  //                             ),
  //                             child: Icon(
  //                               Icons.gps_fixed_sharp,
  //                               size: 24,
  //                               color: Theme.of(context).primaryColor,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 12),
  //                           Expanded(
  //                             child: Text(
  //                               'Enable Location Services',
  //                               style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                                 fontWeight: FontWeight.w600,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 16),
  //                       // Description
  //                       Text(
  //                         'Granting location permission ensures accurate address detection and a seamless service experience.',
  //                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                           color: Colors.grey[600],
  //                           height: 1.4,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 24),
  //                       // Action Buttons
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           if (!isLoading)
  //                             TextButton(
  //                               onPressed: () {
  //                                 Navigator.pop(bottomSheetContext);
  //                               },
  //                               child: const Text(
  //                                 'CANCEL',
  //                                 style: TextStyle(color: Colors.grey),
  //                               ),
  //                             ),
  //                           const SizedBox(width: 8),
  //                           ElevatedButton(
  //                             onPressed: isLoading
  //                                 ? null
  //                                 : () {
  //                               context.read<LocationCubit>().requestLocationPermission();
  //                             },
  //                             style: ElevatedButton.styleFrom(
  //                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8.0),
  //                               ),
  //                             ),
  //                             child: isLoading
  //                                 ? const SizedBox(
  //                               width: 20,
  //                               height: 20,
  //                               child: CircularProgressIndicator(
  //                                 strokeWidth: 2,
  //                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //                               ),
  //                             )
  //                                 : const Text(
  //                               'GRANT',
  //                               style: TextStyle(fontWeight: FontWeight.w600),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

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
