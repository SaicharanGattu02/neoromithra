import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'At NeuroMitra, we specialize in providing a comprehensive range of therapy services aimed at nurturing and enhancing the well-being of individuals across all ages. Our dedicated team of highly qualified therapists is committed to creating a supportive environment where every client can thrive.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'At NeuroMitra, we believe in a personalized approach to therapy, recognizing each individual’s unique needs and strengths. Our holistic treatment plans are designed to empower clients and their families, fostering independence and a sense of achievement.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16), // Space between text and image
            Container(
              width: 100, // Set desired width for the image container
              height: 100, // Set desired height for the image container
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img.png'), // Replace with your image URL
                  fit: BoxFit.cover, // Cover the container with the image
                ),
                borderRadius: BorderRadius.circular(8), // Optional: round corners
              ),
            ),
          ],
        ),
      ),
    );
  }
}
