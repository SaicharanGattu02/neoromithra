import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ExploreChildren extends StatefulWidget {
  const ExploreChildren({super.key});

  @override
  State<ExploreChildren> createState() => _ExploreChildrenState();
}

class _ExploreChildrenState extends State<ExploreChildren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Neurodiverse Minds'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Heading
              HtmlWidget(
                '<h1>Are You Ready to Redefine Support for Neurodiverse Minds?</h1>',
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),

              // Bullet Points for initial questions
              Text(
                "• Is your child struggling with developmental delays, autism, ADHD, or any neurodiverse condition?",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Do you feel lost navigating therapies, government support, and school admissions for your child?",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Description about NeuroMitra
              Text(
                "NeuroMitra is here to guide and support you. Designed for parents and caregivers, we offer solutions tailored for neurodiverse children and their unique challenges.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Centered Title
              Center(
                child: Text(
                  "Understanding Neurodiverse Minds",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  "What Does It Mean to Be Neurodiverse?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              HtmlWidget(
                'To be neurodiverse means having a brain that processes, learns, and behaves differently from what is considered "typical." Neurodiversity encompasses a range of conditions emphasizing that these differences are natural variations in human cognition rather than deficits. It promotes acceptance, inclusion, and the value of diverse ways of thinking.',
                textStyle: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Text explaining the uniqueness of each child
              Text(
                "Every child is unique, and neurodiversity celebrates their differences. Whether your child has:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              // Bullet Points for specific neurodiverse conditions
              Text(
                "• Autism Spectrum Disorder (ASD)",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Attention-Deficit/Hyperactivity Disorder (ADHD)",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Dyslexia, Dyscalculia, or Dyspraxia",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Speech or Language Delays",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Text to emphasize NeuroMitra's support
              Text(
                "We’re here to help them reach their full potential with the right tools, therapies, and support.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Bullet Points for challenges children may face
              Text(
                "• Is Your Child Struggling with These Challenges?",
                style: TextStyle(fontSize: 16),
              ),

              Text(
                "• Difficulty communicating or expressing thoughts?",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Trouble focusing, staying organized, or sitting still?",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Challenges in reading, writing, or basic math skills?",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Frequent meltdowns or difficulty adapting to changes?",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Struggling with motor skills like holding a pencil or tying shoelaces?",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(textAlign: TextAlign.center,
                "Don’t worry—you’re not alone. NeuroMitra is here to guide you every step of the way.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "• An iMAGE showing various signs of neurodiversity, like a brain puzzle, child writing, or blocks with letters",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              // Centered Title for "How NeuroMitra Can Help"
              Center(
                child: Text(
                  "How NeuroMitra Can Help?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),

              // Text introducing NeuroMitra's services
              Text(
                "At NeuroMitra, we redefine support with:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Bullet Points for services
              Text(
                "• Early Identification: Our simple guide is designed by experts to identify potential developmental delays.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Therapies & Resources: Tailored to your child’s unique needs, including speech therapy, occupational therapy, and behavioral support.",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "• Parental Guidance: We equip parents with tools and strategies to empower their child’s journey.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "An image where parents and therapists working together to create a supportive environment for a child.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),


            ],
          ),
        ),
      ),
    );
  }
}
