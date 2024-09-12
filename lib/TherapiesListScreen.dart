import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'TherapyScreens/ABA_TherapyScreen.dart';
import 'TherapyScreens/ArtTherapyScreen.dart';
import 'TherapyScreens/BehavioralTherapyScreen.dart';
import 'TherapyScreens/CBT_Screen.dart';
import 'TherapyScreens/DevelopmentalTherapyScreen.dart';
import 'TherapyScreens/FeedingTherapyScreen.dart';
import 'TherapyScreens/MusicTherapyScreen.dart';
import 'TherapyScreens/OccupationalTherapyScreen.dart';
import 'TherapyScreens/PhysicalTherapyScreen.dart';
import 'TherapyScreens/PlayTherapyScreen.dart';
import 'TherapyScreens/SensoryIntegrationTherapyScreen.dart';
import 'TherapyScreens/SocialSkillsTrainingScreen.dart';
import 'TherapyScreens/SpeechTheraphyScreen.dart';

class TherapiesListScreen extends StatelessWidget {
  final List<Map<String, String>> therapies = [
    {'image': 'assets/SpeechTherapy.png', 'text': 'Speech Therapy'},
    {'image': 'assets/OccupationalTherapy.png', 'text': 'Occupational Therapy'},
    {'image': 'assets/PhysicalTherapy.png', 'text': 'Physical Therapy'},
    {'image':'assets/BehavioralTherapy.png', 'text': 'Behavioral Therapy'},
    {'image': 'assets/(ABA)Therapy.png', 'text': 'Applied Behaviour Analysis(ABA) Therapy'},
    {'image': 'assets/SensoryIntegrationTherapy.png', 'text': 'Sensory Integration Therapy'},
    {'image':'assets/PlayTherapy.png', 'text': 'Play Therapy'},
    {'image': 'assets/FeedingTherapy.png', 'text': 'Feeding Therapy'},
    {'image': 'assets/CognitiveBehavioralTherapy(CBT).png', 'text': 'Cognitive Behavioral Therapy(CBT)'},
    {'image': 'assets/SocialSkills.png', 'text': 'Social Skills Training'},
    {'image':'assets/MusicTherapy.png', 'text': 'Music Therapy'},
    {'image':'assets/ArtTherapy.png','text': 'Art Therapy'},
    {'image': 'assets/developmentTherepy.png','text': 'Developmental Therapy'},
  ];

  void _navigateToDetails(BuildContext context, String text) {
    Widget detailsScreen;

    switch (text) {
      case 'Speech Therapy':
        detailsScreen = SpeechTherapyScreen();
        break;
      case 'Occupational Therapy':
        detailsScreen = OccupationalTherapyScreen();
        break;
      case 'Physical Therapy':
        detailsScreen = PhysicalTherapyScreen();
        break;
      case 'Behavioral Therapy':
        detailsScreen = BehavioralTherapyScreen();
        break;
      case 'Applied Behaviour Analysis(ABA) Therapy':
        detailsScreen = ABA_TherapyScreen();
        break;
      case 'Sensory Integration Therapy':
        detailsScreen = SensoryIntegrationTherapyScreen();
        break;
      case 'Play Therapy':
        detailsScreen = PlayTherapyScreen();
        break;
      case 'Feeding Therapy':
        detailsScreen = FeedingTherapyScreen();
        break;
      case 'Cognitive Behavioral Therapy(CBT)':
        detailsScreen = CBT_Screen();
        break;
      case 'Social Skills Training':
        detailsScreen = SocialSkillsTrainingScreen();
        break;
      case 'Music Therapy':
        detailsScreen = MusicTherapyScreen();
        break;
      case 'Art Therapy':
        detailsScreen = ArtTherapyScreen();
        break;
      case 'Developmental Therapy':
        detailsScreen = DevelopmentalTherapyScreen();
        break;
      default:
        detailsScreen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailsScreen),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapies'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
          crossAxisSpacing: 10.0,
        ),
        itemCount: therapies.length,
        itemBuilder: (context, index) {
          final product = therapies[index];
          return
            InkWell(
              onTap: () => _navigateToDetails(context,product['text']!),

              child: ProductGridItem(
              imageUrl: product['image']!,
              title: product['text']!,
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