import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:neuromithra/Components/CustomAppButton.dart';
import 'package:neuromithra/Presentation/SelectingTypes/ExploreAdults.dart';
import 'package:neuromithra/Presentation/SelectingTypes/ExploreChildren.dart';

class SelectingTypes extends StatefulWidget {
  const SelectingTypes({super.key});

  @override
  State<SelectingTypes> createState() => _SelectingTypesState();
}

class _SelectingTypesState extends State<SelectingTypes> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with logo and tagline
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo image with proper scaling
                Image.asset(
                  'assets/neuromitralogo.png',
                  scale: 6,
                  fit: BoxFit.contain,
                ),
                // Text tagline
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NEUROMITRA',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Empowering minds, enriching lives',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // HTML Text Content
            HtmlWidget(
              '''“From children with developmental delays to adults seeking mental wellness, we’re here for you.<br><br>
  “We believe in empowering Neurodiverse Minds & Mental Wellness for All.”<br><br>
  A large, visually appealing banner image or video showcasing both children and adults receiving support.''',
              textStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
            SizedBox(height: 32),

            Text(
              'For Children:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CustomAppButton(
              text: 'Explore Support for Children',
              onPlusTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExploreChildren()));
              },
            ),
            SizedBox(height: 24),

            // Adults Section
            Text(
              'For Adults:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CustomAppButton(
              text: 'Discover Services for Adults',
              onPlusTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExploreAdults()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
