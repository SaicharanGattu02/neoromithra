import 'package:flutter/material.dart';

class ExploreAdults extends StatefulWidget {
  const ExploreAdults({super.key});

  @override
  State<ExploreAdults> createState() => _ExploreAdultsState();
}

class _ExploreAdultsState extends State<ExploreAdults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Heading
              Center(
                child: Text(
                  "For Everyone’s Mental Wellness",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  "Do you or someone you know need help managing stress, anxiety, or emotions?",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "NeuroMitra isn’t just for neurodiverse kids. Our app is a trusted companion for adults seeking to overcome mental health challenges and achieve emotional well-being.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 20),
              Text(
                "Image of a A serene, calm setting like a person meditating under a tree, symbolizing emotional balance and mental peace.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),
              Center(
                child: Text(
                  "How NeuroMitra Helps Adults Manage Mental Health Conditions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              Text("an image of A therapist and an adult in a comforting session with warm lighting and supportive body language.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                "Our expert-led counseling services are tailored to address common mental health conditions in adults, such as stress, emotional imbalance, and trauma. We also offer support for adults struggling with a range of mental health conditions, including:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),



              // Bullet Points for conditions
              Text(
                  "• Anxiety Disorders: Helping individuals manage excessive worry, panic attacks, and other anxiety-related symptoms.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Depression: Providing tools and guidance to combat feelings of hopelessness, sadness, and loss of interest.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Bipolar Disorder: Offering support in managing mood swings, including episodes of mania and depression.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Post-Traumatic Stress Disorder (PTSD): Assisting individuals in coping with trauma-related experiences and emotions.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Schizophrenia: Providing guidance and strategies to manage symptoms such as delusions, hallucinations, and cognitive challenges.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Eating Disorders: Offering support for those dealing with disordered eating behaviors and related emotional struggles.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Neurodevelopmental Disorders: Assisting individuals with conditions such as autism spectrum disorder, ADHD, and learning disabilities to enhance personal growth and functioning.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Panic Disorder: Learn to manage panic attacks with grounding techniques and breathing exercises.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Obsessive-Compulsive Disorder (OCD): Break free from repetitive thoughts and behaviors with evidence-based strategies.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              Center(
                child: Text(
                  "How NeuroMitra Counseling Services Work:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),


              Center(
                child: Text(
                  "an image of a dark-to-light transition showing emotional recovery.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),

              // Counseling Services Bullet Points
              Text(
                  "• Emotional Resilience: Learn proven strategies to regulate emotions, reduce stress, and develop resilience.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Stress Management Techniques: From mindfulness exercises to guided relaxation, our counselors provide practical tools to help individuals regain control.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Anxiety Coping Mechanisms: Sessions include techniques such as grounding exercises and cognitive reframing to manage racing thoughts and calm the mind.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "• Trauma Recovery: For those recovering from past trauma, our counselors use evidence-based practices like CBT (Cognitive Behavioral Therapy) to rebuild emotional well-being.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // Additional Features Heading
              Center(
                child: Text(
                  "Additional Features on NeuroMitra for Mental Wellness",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),


              Center(
                child: Text(
                  "an image of a person sitting with headphones on, looking peaceful, with floating icons for mindfulness, learning, and resilience.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),

              // Additional Features Bullet Points
              Text(
                  "1. Personalized Support Plans: Each user receives a tailored plan based on their unique challenges and goals.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "2. Self-Paced Learning Modules: Access courses on stress management, emotional resilience, and mindfulness practices.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // Why Choose NeuroMitra Heading
              Center(
                child: Text(
                  "Why Choose NeuroMitra for Mental Wellness?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),

              Text(
                  "1. Expert Counseling Services: Certified professionals with experience in addressing a wide range of mental health issues.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "2. NLP-Based Growth Techniques: Proven strategies to help individuals reframe their mindset and create lasting change.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "3. Holistic Approach: Combining counseling, NLP, and self-care tools for comprehensive mental wellness.",
                  style: TextStyle(fontSize: 16)),
              Text(
                  "4. Accessible Anytime, Anywhere: Connect with counselors and access resources through the app whenever needed.",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),


              Center(
                child: Text(
                  "an image of a person holding a smartphone with the NeuroMitra app interface displayed, surrounded by calming blue light.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
