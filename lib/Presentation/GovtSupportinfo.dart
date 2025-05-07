import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'CustomAppBar.dart';

class SupportProgramsScreen extends StatelessWidget {
  final List<Map<String, String>> programs = [
    {
      'title': 'NIRAMAYA',
      'description':
      'A health insurance scheme that provides affordable coverage for people with autism, cerebral palsy, mental retardation, and multiple disabilities.'
    },
    {
      'title': 'SAHYOGI',
      'description':
      'A caregiver training scheme that establishes Caregiver Cells (CGCs) to train caregivers for people with disabilities and their families.'
    },
    {
      'title': 'GYAN PRABHA',
      'description':
      'A scholarship scheme that encourages people with autism, cerebral palsy, mental retardation, and multiple disabilities to pursue education and vocational courses.'
    },
    {
      'title': 'Deendayal Disabled Rehabilitation Scheme',
      'description':
      'A centrally funded scheme that aims to create an enabling environment for people with disabilities.'
    },
    {
      'title': 'District Disability Rehabilitation Centres',
      'description':
      'Centers that provide rehabilitation services for people with disabilities, including prevention and early detection, surgical care, and more.'
    },
    {
      'title': 'Aadhaar Vocational Centre',
      'description':
      'A center that provides vocational training to help autistic adults lead more meaningful lives.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Govt Support Info',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: Color(0xff3EA4D2),
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: Color(0xff3EA4D2)), // Icon color
          onPressed: () =>  context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    programs[index]['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    programs[index]['description']!,
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter"
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}