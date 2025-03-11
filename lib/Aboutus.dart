import 'package:flutter/material.dart';

import 'CustomAppBar.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'About Us',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: Color(0xff3EA4D2),
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: Color(0xff3EA4D2)), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('About NeuroMitra'),
            _buildText(
              'At NeuroMitra, we specialize in providing a comprehensive range of therapy services aimed at nurturing and enhancing the well-being of individuals across all ages. Our dedicated team of highly qualified therapists is committed to creating a supportive environment where every client can thrive.\n\n'
                  'At NeuroMitra, we believe in a personalized approach to therapy, recognizing each individual’s unique needs and strengths. Our holistic treatment plans are designed to empower clients and their families, fostering independence and a sense of achievement.',
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity, // Set desired width for the image container
              height: 200, // Set desired height for the image container
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img.png'), // Replace with your image URL
                  fit: BoxFit.cover, // Cover the container with the image
                ),
                borderRadius: BorderRadius.circular(8), // Optional: round corners
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity, // Set desired width for the image container
              height: 250, // Set desired height for the image container
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/SGDGER.jpg'), // Replace with your image URL
                  fit: BoxFit.cover, // Cover the container with the image
                ),
                borderRadius: BorderRadius.circular(8), // Optional: round corners
              ),
            ),
            _buildTeamMember('ROHINI THAKUR', 'Director/ Co-Founder of NeuroMitra',
                'Hello I am Rohini, a passionate NLP Practitioner and a certified life coach dedicated to making a positive impact on the lives of children and parents.\n\n'
                    'With a background as an ex-Amazon employee, I have honed my analytical and problem-solving skills, which I now apply to my work in Neuro-Linguistic Programming. My goal is to empower children and parents alike, helping them navigate challenges, unlock potential, and achieve personal growth.\n\n'
                    'Whether it’s overcoming behavioral issues, enhancing communication, or fostering a positive mindset, I’m here to support you every step of the way on your journey to a more fulfilling life. Together, we can create lasting change and a brighter future for your family.'
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity, // Set desired width for the image container
              height: 360, // Set desired height for the image container
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/1.jpg'), // Replace with your image URL
                  fit: BoxFit.cover, // Cover the container with the image
                ),
                borderRadius: BorderRadius.circular(8), // Optional: round corners
              ),
            ),
            _buildTeamMember('Arshiya', 'Co-Founder of NeuroMitra',
                'Arshiya, the Co-Founder of NeuroMitra, is a B.Tech graduate and experienced event manager who brings a unique combination of technical expertise and organizational skills to the organization.\n\n'
                    'With a deep passion for supporting children diagnosed with autism, ADHD, and other psychological disorders, Arshiya has dedicated her career to making a positive impact in their lives. Her technological background enables her to contribute innovative solutions to NeuroMitra’s offerings, while her event management experience ensures that workshops, therapy sessions, and support events are both engaging and effective.\n\n'
                    'At the core of Arshiya’s work at NeuroMitra is her commitment to creating a nurturing and supportive environment for children and their families. She is actively involved in developing programs that focus on skill development, school admission support, and emotional well-being, ensuring that each child receives the individualized care they need to flourish. Through NeuroMitra, Arshiya strives to provide holistic support that empowers children and their parents, leaving a lasting, positive impact on their lives.'
            ),

            _buildSectionTitle('Why Choose NeuroMitra?'),
            _buildBulletPoint('Expertise: Our team consists of qualified and experienced professionals committed to your child’s success.'),
            _buildBulletPoint('Personalized Care: We tailor our services to meet the specific needs of each child and family.'),
            _buildBulletPoint('Comprehensive Services: We offer a wide range of therapy and counseling services to address various developmental and psychological needs.'),
            _buildBulletPoint('Supportive Environment: We create a nurturing space for children to grow and families to find the support they need.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildText(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildTeamMember(String name, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String point) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8),
          Expanded(child: Text(point,
            style: TextStyle(
              fontSize: 16
            ),
          )),
        ],
      ),
    );
  }
}
