import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavBar({required this.selectedIndex, required this.onItemTapped});

  Widget _buildIconButton(String iconPath, String label, int index, BuildContext context) {
    bool isSelected = selectedIndex == index;
    double iconSize = MediaQuery.of(context).size.width * 0.07; // Responsive icon size

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.blue.shade50 : Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconPath,
                width: iconSize,
                height: iconSize,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: isSelected ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton('assets/Home.png', "Home", 0, context),
            _buildIconButton('assets/therapy.png', "Therapies", 1, context),
            _buildIconButton('assets/consultation.png', "Counselling", 2, context),
            _buildIconButton('assets/UserCircle.png', "Profile", 3, context),
            _buildIconButton('assets/Info.png', "Info", 4, context),
            _buildIconButton('assets/guide.png', "Guide", 5, context),
          ],
        ),
      ),
    );
  }
}
