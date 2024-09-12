import 'package:flutter/material.dart';

import 'CounsellingScreens/BehavioralCounsellingScreen.dart';
import 'CounsellingScreens/CareerCounsellingScreen.dart';
import 'CounsellingScreens/CrisisCounsellingScreen.dart';
import 'CounsellingScreens/EducationalCounsellingScreen.dart';
import 'CounsellingScreens/FamilyCounsellingScreen.dart';
import 'CounsellingScreens/GeneralStressManagementCounsellingScreen.dart';
import 'CounsellingScreens/GriefCounsellingScreen.dart';
import 'CounsellingScreens/GroupCounsellingScreen.dart';
import 'CounsellingScreens/IndividualCounsellingForChildrenScreen.dart';
import 'CounsellingScreens/MentalHealthCounsellingScreen.dart';
import 'CounsellingScreens/ParentChildRelationshipCounsellingScreen.dart';
import 'CounsellingScreens/ParentCounsellingForAutismScreen.dart';
import 'CounsellingScreens/RelationshipCounsellingScreen.dart';
import 'CounsellingScreens/SiblingCounsellingScreen.dart';

class CounsellingListScreen extends StatelessWidget {
  final List<Map<String, String>> counsellings = [
    {'image': 'assets/RelationshipCounseling.png',
      'text': 'Relationship Counselling'},
    {'image': 'assets/BehavioralCounseling.png',
      'text': 'Behavioral Counselling'},
    {'image': 'assets/GriefCounseling.png',
      'text': 'Grief Counselling'},
    {'image': 'assets/GroupCounseling.png',
      'text': 'Group Counselling'},
    {'image':'assets/CrisisCounseling.png',
      'text': 'Crisis Counselling'},
    {'image': 'assets/CareerCounseling.png',
      'text': 'Career Counselling for parents'},
    {'image': 'assets/SiblingCounseling.png',
      'text': 'Sibling Counselling'},
    {'image': 'assets/EducationalCounseling.png',
      'text': 'Educational Counselling'},
    {'image':'assets/Parent-ChildRelationship.png',
      'text': 'Parent-Child Relationship'},
    {'image': 'assets/IndividualCounseling.png',
      'text': 'Individual Counselling for children'},
    {'image':'assets/FamilyCounseling.png',
      'text': 'Family Counselling'},
    {'image': 'assets/MentalHealth.png',
      'text': 'Mental Health Counselling'},
    {'image': 'assets/GeneralStress.png',
      'text': 'General stress management'},
    {'image': 'assets/ParentCounseling.png',
      'text': 'Parent Counselling for Autism'},
  ];

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
      case 'Parent-Child Relationship':
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
      // Handle unknown text
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counselling List')),
      body:

      //
      // ListView.builder(
      //   itemCount: counsellings.length,
      //   itemBuilder: (context, index) {
      //     final counselling = counsellings[index];
      //     return ListTile(
      //       leading: Image.network(counselling['image']!),
      //       title: Text(counselling['text']!),
      //       onTap: () => _onCounsellingTap(context, counselling['text']!),
      //     );
      //   },
      // ),
      GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
          crossAxisSpacing: 10.0,
        ),
        itemCount: counsellings.length,
        itemBuilder: (context, index) {
          final counselling = counsellings[index];
          return
            InkWell(
              onTap: () => _onCounsellingTap(context, counselling['text']!),

              child: ProductGridItem(
                imageUrl: counselling['image']!,
                title:counselling['text']!,
              ),
            );
        },
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  ProductGridItem({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageUrl,
            width: 150, // Adjust width as needed
            height: 106, // Adjust height as needed
            fit: BoxFit.cover,

          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
