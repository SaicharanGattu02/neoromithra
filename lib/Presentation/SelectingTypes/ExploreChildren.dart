import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:neuromithra/Presentation/MainDashBoard.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Components/CustomAppButton.dart';
import '../../utils/Color_Constants.dart';

class ExploreChildren extends StatefulWidget {
  const ExploreChildren({super.key});

  @override
  State<ExploreChildren> createState() => _ExploreChildrenState();
}

class _ExploreChildrenState extends State<ExploreChildren> {
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
          'Support for Children',
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Are You Ready to Redefine Support for Neurodiverse Minds?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primarycolor,
                    fontFamily: "general_sans",
                  ),
                ),
                const SizedBox(height: 20),
                ...[
                  "Is your child struggling with developmental delays, autism, ADHD, or any neurodiverse condition?",
                  "Do you feel lost navigating therapies, government support, and school admissions for your child?"
                ].map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("• $text",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                const SizedBox(height: 20),
                Text(
                  "NeuroMitra is here to guide and support you. Designed for parents and caregivers, we offer solutions tailored for neurodiverse children and their unique challenges.",
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Understanding Neurodiverse Minds",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "general_sans",
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "What Does It Mean to Be Neurodiverse?",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: primarycolor,
                          fontFamily: "general_sans",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                HtmlWidget(
                  'To be neurodiverse means having a brain that processes, learns, and behaves differently from what is considered "typical." Neurodiversity encompasses a range of conditions emphasizing that these differences are natural variations in human cognition rather than deficits. It promotes acceptance, inclusion, and the value of diverse ways of thinking.',
                  textStyle: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                const SizedBox(height: 20),
                Text(
                  "Every child is unique, and neurodiversity celebrates their differences. Whether your child has:",
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                const SizedBox(height: 10),
                ...[
                  "Autism Spectrum Disorder (ASD)",
                  "Attention-Deficit/Hyperactivity Disorder (ADHD)",
                  "Dyslexia, Dyscalculia, or Dyspraxia",
                  "Speech or Language Delays"
                ].map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("• $text",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                const SizedBox(height: 20),
                Text(
                  "We’re here to help them reach their full potential with the right tools, therapies, and support.",
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                const SizedBox(height: 20),
                Text(
                  "• Is Your Child Struggling with These Challenges?",
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                ...[
                  "Difficulty communicating or expressing thoughts?",
                  "Trouble focusing, staying organized, or sitting still?",
                  "Challenges in reading, writing, or basic math skills?",
                  "Frequent meltdowns or difficulty adapting to changes?",
                  "Struggling with motor skills like holding a pencil or tying shoelaces?"
                ].map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("• $text",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                const SizedBox(height: 20),
                Text(
                  "Don’t worry—you’re not alone. NeuroMitra is here to guide you every step of the way.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: "general_sans"),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/image5.webp", fit: BoxFit.cover),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "How NeuroMitra Can Help?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "general_sans",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "At NeuroMitra, we redefine support with:",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: primarycolor,
                    fontFamily: "general_sans",
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  "Early Identification: Our simple guide is designed by experts to identify potential developmental delays.",
                  "Therapies & Resources: Tailored to your child’s unique needs, including speech therapy, occupational therapy, and behavioral support.",
                  "Parental Guidance: We equip parents with tools and strategies to empower their child’s journey."
                ].map((text) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("• $text",
                      style: TextStyle(fontSize: 16, fontFamily: "general_sans")),
                )),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/image6.webp", fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset("assets/banner1.png", fit: BoxFit.contain),
                ),
                const SizedBox(height: 30),
                CustomAppButton(
                  text: 'View our therapy services',
                  onPlusTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainDashBoard(initialIndex: 1),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CustomAppButton(
                  textcolor: Colors.white,
                  text: 'Schedule A Session',
                  color: Colors.green,
                  onPlusTap: () {
                    _launchCall("8885320115");
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
