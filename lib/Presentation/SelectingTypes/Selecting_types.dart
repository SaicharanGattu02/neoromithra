import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:neuromithra/Components/CustomAppButton.dart';
import 'package:neuromithra/Presentation/SelectingTypes/ExploreAdults.dart';
import 'package:neuromithra/Presentation/SelectingTypes/ExploreChildren.dart';

import '../../utils/Color_Constants.dart';

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
      appBar: AppBar(
        title: Text('About NeuroMitra',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/applogo.jpeg',
                    scale: 12,
                    fit: BoxFit.cover,
                  ),
                ),
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
                            fontWeight: FontWeight.w400,
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
            SizedBox(height: 14),
            Center(
              child: Text(
                '“From children with developmental delays to adults seeking mental wellness, we’re here for you."',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Epi"),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                '“We believe in empowering Neurodiverse Minds & Mental Wellness for All.”',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Epi"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/banner.webp",
                    fit: BoxFit.cover,
                  )),
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
