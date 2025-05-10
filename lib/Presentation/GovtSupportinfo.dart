import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/Color_Constants.dart';
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
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        title: Text('Govt Support Info',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Optional: Add an icon header
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: primarycolor),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          programs[index]['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "general_sans",
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    programs[index]['description']!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: "general_sans",
                      color: Colors.grey[800],
                      height: 1.5,
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
