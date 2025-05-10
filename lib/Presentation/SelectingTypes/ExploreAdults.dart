import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Components/CustomAppButton.dart';
import '../../utils/Color_Constants.dart';
import '../MainDashBoard.dart';

class ExploreAdults extends StatefulWidget {
  const ExploreAdults({super.key});

  @override
  State<ExploreAdults> createState() => _ExploreAdultsState();
}

class _ExploreAdultsState extends State<ExploreAdults> {

  Future<void> _launchCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support for Adults',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
            color: primarycolor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "For Everyone’s Mental Wellness",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "general_sans",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    '"Do you or someone you know need help managing stress, anxiety, or emotions?"',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontFamily: "general_sans"),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "NeuroMitra isn’t just for neurodiverse kids. Our app is a trusted companion for adults seeking to overcome mental health challenges and achieve emotional well-being.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/image1.webp", fit: BoxFit.cover),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "How NeuroMitra Helps Adults Manage Mental Health Conditions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "general_sans",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/image2.webp", fit: BoxFit.cover),
                ),
                SizedBox(height: 20),
                Text(
                  "Our expert-led counseling services are tailored to address common mental health conditions in adults, such as stress, emotional imbalance, and trauma. We also offer support for adults struggling with a range of mental health conditions, including:",
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                SizedBox(height: 20),
                ...[
                  "Anxiety Disorders: Helping individuals manage excessive worry, panic attacks, and other anxiety-related symptoms.",
                  "Depression: Providing tools and guidance to combat feelings of hopelessness, sadness, and loss of interest.",
                  "Bipolar Disorder: Offering support in managing mood swings, including episodes of mania and depression.",
                  "Post-Traumatic Stress Disorder (PTSD): Assisting individuals in coping with trauma-related experiences and emotions.",
                  "Schizophrenia: Providing guidance and strategies to manage symptoms such as delusions, hallucinations, and cognitive challenges.",
                  "Eating Disorders: Offering support for those dealing with disordered eating behaviors and related emotional struggles.",
                  "Neurodevelopmental Disorders: Assisting individuals with conditions such as autism spectrum disorder, ADHD, and learning disabilities to enhance personal growth and functioning.",
                  "Panic Disorder: Learn to manage panic attacks with grounding techniques and breathing exercises.",
                  "Obsessive-Compulsive Disorder (OCD): Break free from repetitive thoughts and behaviors with evidence-based strategies."
                ].map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("• $text",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "How NeuroMitra Counseling Services Work:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "general_sans",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/image3.webp", fit: BoxFit.cover),
                ),
                SizedBox(height: 20),
                ...[
                  "Emotional Resilience: Learn proven strategies to regulate emotions, reduce stress, and develop resilience.",
                  "Stress Management Techniques: From mindfulness exercises to guided relaxation, our counselors provide practical tools to help individuals regain control.",
                  "Anxiety Coping Mechanisms: Sessions include techniques such as grounding exercises and cognitive reframing to manage racing thoughts and calm the mind.",
                  "Trauma Recovery: For those recovering from past trauma, our counselors use evidence-based practices like CBT (Cognitive Behavioral Therapy) to rebuild emotional well-being."
                ].map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("• $text",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Additional Features on NeuroMitra for Mental Wellness",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "general_sans",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/image4.webp", fit: BoxFit.cover),
                ),
                SizedBox(height: 20),
                ...[
                  "Personalized Support Plans: Each user receives a tailored plan based on their unique challenges and goals.",
                  "Self-Paced Learning Modules: Access courses on stress management, emotional resilience, and mindfulness practices."
                ].asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("${entry.key + 1}. ${entry.value}",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Why Choose NeuroMitra for Mental Wellness?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: "general_sans",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...[
                  "Expert Counseling Services: Certified professionals with experience in addressing a wide range of mental health issues.",
                  "NLP-Based Growth Techniques: Proven strategies to help individuals reframe their mindset and create lasting change.",
                  "Holistic Approach: Combining counseling, NLP, and self-care tools for comprehensive mental wellness.",
                  "Accessible Anytime, Anywhere: Connect with counselors and access resources through the app whenever needed."
                ].asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("${entry.key + 1}. ${entry.value}",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/banner1.png", fit: BoxFit.contain),
                ),
                SizedBox(height: 30),
                CustomAppButton(
                  text: 'View our Counselling services',
                  onPlusTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainDashBoard(initialIndex: 2),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                CustomAppButton(
                  textcolor: Colors.white,
                  text: 'Schedule A Session',
                  color: Colors.green,
                  onPlusTap: () {
                    _launchCall("8885320115");
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
