import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Providers/HomeProviders.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Components/ProductGridItem.dart';
import '../Components/Shimmers.dart';
import '../utils/Color_Constants.dart';
import '../utils/spinkits.dart';
import 'DetailsScreen.dart';

class TherapiesListScreen extends StatefulWidget {
  @override
  State<TherapiesListScreen> createState() => _TherapiesListScreenState();
}

class _TherapiesListScreenState extends State<TherapiesListScreen> {
  // final List<Map<String, dynamic>> therapies = [
  //   {
  //     'image': 'assets/Therephy/speech_theraphy.jpg',
  //     'text': 'Speech Therapy',
  //     'description':
  //         'Speech Therapy focuses on diagnosing and treating speech and language disorders to enhance a child’s ability to communicate. This therapy addresses various aspects of communication, including articulation, language comprehension, expressive language, and social communication, ensuring a comprehensive approach to speech and language development.',
  //     'keyAreas': [
  //       'Improved Articulation: Helps children produce clear speech sounds.',
  //       'Enhanced Language Comprehension: Develops understanding of spoken language.',
  //       'Strengthened Expressive Language: Supports expressing thoughts and emotions.',
  //       'Better Social Communication: Teaches essential interaction skills.'
  //     ],
  //     'benefits': [
  //       'Helps individuals with speech sound issues.',
  //       'Improves understanding and use of language.',
  //       'Enhances social communication skills.',
  //       'Supports those with speech-related disorders.'
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/occupational_theraphy.jpeg',
  //     'text': 'Occupational Therapy',
  //     'description':
  //         'Occupational Therapy focuses on helping children perform daily activities and tasks that are essential for their growth and development. This therapy addresses a range of skills, including fine motor skills, sensory processing, self-care tasks, and hand-eye coordination, to support overall functional independence and participation in daily life.',
  //     'keyAreas': [
  //       'Enhanced Fine Motor Skills: Develops the precise movements needed for activities such as writing, buttoning clothes, and using utensils.',
  //       'Improved Sensory Processing: Helps children manage and respond to sensory input effectively, promoting better focus and emotional regulation.',
  //       'Support for Self-Care Tasks: Assists in learning and performing essential self-care activities like dressing, grooming, and feeding.',
  //       'Better Hand-Eye Coordination: Improves the ability to coordinate visual input with hand movements, essential for many daily tasks.',
  //       'Increased Independence: Fosters the skills necessary for children to perform tasks independently, boosting their confidence and self-esteem.',
  //     ],
  //     'benefits': [
  //       'Have developmental delays or disabilities',
  //       'Experience difficulties with fine motor skills or hand-eye coordination',
  //       'Struggle with sensory processing issues',
  //       'Need support with self-care tasks and daily activities',
  //       'Need support with self-care tasks and daily activities',
  //       'Seek to improve their participation in school and other daily environments',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/physical_theraphy.jpeg',
  //     'text': 'Physio Therapy',
  //     'description':
  //     'Physio Therapy is a therapeutic approach focused on enhancing physical function, strength, and mobility through various techniques and exercises. This therapy aims to address and treat musculoskeletal, neurological, and developmental issues that impact an individual’s ability to perform daily activities and enjoy a fulfilling life.',
  //     'keyAreas': [
  //       'Improved Mobility: Enhances range of motion and movement abilities, allowing for greater independence in daily activities.',
  //       'Increased Strength: Builds muscle strength and endurance to support overall physical health and functionality.',
  //       'Enhanced Balance and Coordination: Helps improve balance and coordination, reducing the risk of falls and injuries.',
  //       'Pain Relief: Provides techniques and exercises to alleviate pain and discomfort associated with physical conditions or injuries.',
  //       'Rehabilitation Support: Assists in recovering from surgeries, injuries, or physical conditions by promoting optimal healing and function.'
  //     ],
  //     'benefits': [
  //       'Are recovering from injuries or surgeries.',
  //       'Experience chronic pain or discomfort.',
  //       'Have difficulty with movement, strength, or balance.',
  //       'Are dealing with musculoskeletal or neurological conditions.',
  //       'Seek to improve overall physical health and functionality.'
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/behavioural_theraphy.jpg',
  //     'text': 'Behavioral Therapy',
  //     'description':
  //         'Behavioral Therapy focuses on identifying and changing negative behavioral patterns.',
  //     'keyAreas': [
  //       'Behavior Modification: Helps identify and alter specific problematic behaviors, replacing them with positive alternatives.',
  //       'Enhanced Coping Strategies: Teaches effective coping mechanisms to manage stress, anxiety, and other challenges.',
  //       'Improved Social Skills: Supports the development of appropriate social behaviors and interpersonal skills.',
  //       'Increased Emotional Regulation: Assists individuals in managing their emotions and responses in a constructive manner.',
  //       'Goal Achievement: Aids in setting and achieving personal goals related to behavior and overall well-being.'
  //     ],
  //     'benefits': [
  //       'Experience difficulties with managing behaviors and emotions.',
  //       'Struggle with stress, anxiety, or other psychological challenges.',
  //       'Have specific behavioral issues that need to be addressed.',
  //       'Are seeking to improve their overall quality of life through positive behaviour changes.',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/ABA_theraphy.jpeg',
  //     'text': 'Applied Behaviour Analysis (ABA) Therapy',
  //     'description':
  //         'Applied Behavior Analysis (ABA) Therapy is a structured approach that applies principles of behavior science to address and improve targeted behaviors and skills. By using techniques such as reinforcement and behavior modification, ABA Therapy helps individuals develop essential skills and reduce challenging behaviors.',
  //     'keyAreas': [
  //       'Improved Communication Skills: Enhances verbal and non-verbal communication through targeted interventions and practice.',
  //       'Enhanced Social Skills: Teaches effective social interactions and relationship-building techniques.',
  //       'Development of Daily Living Skills: Supports the acquisition of essential life skills, such as self-care and personal organization.',
  //       'Behavior Modification: Helps reduce problematic behaviors and replace them with positive, functional alternatives.',
  //       'Increased Independence: Promotes greater independence and self-sufficiency in daily activities.',
  //     ],
  //     'benefits': [
  //       'Have autism spectrum disorder (ASD)',
  //       'Experience difficulties with communication, social skills, or daily living skills',
  //       'Exhibit challenging behaviors that need to be addressed',
  //       'Are looking to enhance their overall functioning and quality of life',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/sensor_integration.jpeg',
  //     'text': 'Sensory Integration Therapy',
  //     'description':
  //         'Sensory Integration Therapy is a therapeutic method that aims to help individuals with sensory processing issues by enhancing their ability to interpret and respond to sensory input. This therapy uses structured activities to address challenges with sensory modulation, sensory discrimination, and sensory-based motor skills.',
  //     'keyAreas': [
  //       'Improved Sensory Processing: Helps children better interpret and respond to sensory stimuli, such as touch, sound, and movement.',
  //       'Enhanced Motor Skills: Supports the development of sensory-based motor skills, including coordination and balance.',
  //       'Better Emotional Regulation: Assists in managing sensory-related stress and emotional responses, leading to improved behavior and emotional stability.',
  //       'Increased Daily Functioning: Promotes better participation in daily activities by addressing sensory sensitivities and improving sensory integration.',
  //       'Enhanced Quality of Life: Helps children engage more fully in social and recreational activities, improving their overall quality of life.',
  //     ],
  //     'benefits': [
  //       'Difficulty processing sensory information (e.g., touch, sound, sight).',
  //       'Sensory sensitivities or aversions',
  //       'Challenges with coordination and balance',
  //       'Emotional or behavioral issues related to sensory processing',
  //       'Difficulty with daily activities and self-care tasks',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/play_theraphy.png',
  //     'text': 'Play Therapy',
  //     'description':
  //         'Play Therapy is a therapeutic method that utilizes structured play activities to help children explore and express their emotions, thoughts, and experiences. Through play, children can work through psychological challenges, develop coping strategies, and enhance their emotional and social development.',
  //     'keyAreas': [
  //       'Emotional Expression: Provides a safe space for children to express their feelings and emotions through play, which can be more accessible than verbal communication.',
  //       'Problem-Solving Skills: Helps children develop critical thinking and problem-solving skills through creative and interactive play activities.',
  //       'Social Interaction: Improves social skills and relationships by allowing children to practice and learn appropriate behaviors and communication strategies.',
  //       'Behavioral Improvement: Addresses behavioral issues by exploring underlying emotional or psychological factors in a supportive environment.',
  //       'Stress Reduction: Helps children manage stress and anxiety through engaging and enjoyable activities that promote relaxation and emotional regulation.',
  //     ],
  //     'benefits': [
  //       'Children experiencing emotional or behavioral difficulties',
  //       'Those dealing with trauma or significant life changes',
  //       'Children with anxiety, depression, or stress-related issues',
  //       'Kids who have difficulty expressing themselves verbally',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/feeding_theraphy.jpg',
  //     'text': 'Feeding Therapy',
  //     'description':
  //         'Feeding Therapy is a therapeutic intervention aimed at addressing various challenges related to eating and swallowing. This therapy involves a comprehensive assessment of an individual’s feeding habits, sensory responses, and oral-motor skills, followed by personalized strategies to improve their feeding abilities and overall nutritional intake.',
  //     'keyAreas': [
  //       'Improved Oral-Motor Skills: Enhances the strength and coordination needed for effective chewing and swallowing.',
  //       'Addressed Sensory Issues: Helps individuals manage and adapt to sensory sensitivities related to food textures, tastes, and smells.',
  //       'Positive Mealtime Behavior: Encourages healthy eating habits and reduces mealtime stress or aversions.',
  //       'Nutritional Support: Assists in ensuring adequate nutritional intake by addressing specific feeding challenges and dietary needs.',
  //       'Enhanced Family Dynamics: Provides guidance and support for families to create positive and stress-free mealtime experiences.',
  //     ],
  //     'benefits': [
  //       'Difficulty with chewing and swallowing',
  //       'Sensory aversions to certain food textures or flavors',
  //       'Limited food variety and picky eating',
  //       'Weight or growth concerns related to feeding difficulties',
  //       'Behavioral issues during mealtime',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/cbt_theraphy.jpeg',
  //     'text': 'Cognitive Behavioral Therapy (CBT)',
  //     'description':
  //         'Cognitive Behavioral Therapy is a therapeutic approach that aims to identify and modify negative thought patterns and behaviors that contribute to emotional distress. Through CBT, individuals learn to recognize and challenge distorted thinking, develop healthier coping strategies, and make positive changes in their behavior and emotions.',
  //     'keyAreas': [
  //       'Improved Thought Patterns: Helps individuals identify and alter negative or irrational thoughts that contribute to emotional difficulties.',
  //       'Effective Problem-Solving: Teaches practical skills for addressing and managing problems and challenges in daily life.',
  //       'Enhanced Emotional Regulation: Provides strategies for managing and reducing symptoms of anxiety, depression, and other emotional issues.',
  //       'Behavioral Change: Encourages the development of healthier behaviors and coping mechanisms to improve overall well-being.',
  //       'Increased Self-Awareness: Fosters greater understanding of the connections between thoughts, feelings, and behaviors.',
  //     ],
  //     'benefits': [
  //       'Anxiety and panic disorders',
  //       'Depression and low mood',
  //       'Stress and adjustment issues',
  //       'Behavioral problems',
  //       'Obsessive-compulsive disorder (OCD)',
  //       'Post-traumatic stress disorder (PTSD))',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/socail_skill_theraphy.jpeg',
  //     'text': 'Social Skills Training',
  //     'description':
  //         'Social Skills Training involves a structured approach to teaching and practicing the behaviors and techniques necessary for effective social interaction. This training includes role-playing, real-life practice, and feedback to help individuals improve their ability to engage with others in positive and constructive ways.',
  //     'keyAreas': [
  //       'Improved Communication: Enhances verbal and non-verbal communication skills to foster clearer and more effective interactions.',
  //       'Enhanced Social Interaction: Helps individuals understand social cues and norms, leading to better interactions and relationships.',
  //       'Conflict Resolution: Teaches strategies for managing and resolving conflicts in a constructive manner.',
  //       'Increased Confidence: Builds self-esteem and confidence in social settings through practice and successful experiences.'
  //     ],
  //     'benefits': []
  //   },
  //   {
  //     'image': 'assets/Therephy/music_theraphy.jpeg',
  //     'text': 'Music Therapy',
  //     'description':
  //         'Music Therapy is a therapeutic approach that incorporates music as a tool to achieve specific therapeutic goals. This can involve listening to music, creating music, singing, or playing instruments. The therapeutic use of music helps individuals express themselves, improve emotional regulation, and enhance their quality of life.',
  //     'keyAreas': [
  //       'Emotional Expression: Provides a creative outlet for expressing feelings and emotions that may be difficult to articulate verbally.',
  //       'Cognitive Development: Stimulates cognitive functions such as memory, attention, and problem-solving through musical activities.',
  //       'Social Interaction: Encourages socialization and communication skills by participating in group music sessions and collaborative activities.',
  //       'Physical Coordination: Enhances motor skills, coordination, and physical movement through rhythmic and instrumental activities.',
  //       'Stress Reduction: Promotes relaxation and reduces stress through soothing and enjoyable musical experiences.',
  //     ],
  //     'benefits': [
  //       'Children with developmental and emotional challenges',
  //       'Adults dealing with stress, anxiety, or depression',
  //       'Individuals recovering from trauma or injury',
  //       'Seniors seeking cognitive and emotional stimulation',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/art_theraphy.png',
  //     'text': 'Art Therapy',
  //     'description':
  //     'Art Therapy is a form of expressive therapy that uses artistic activities, such as drawing, painting, and sculpting, to help individuals communicate and process their emotions. Unlike traditional talk therapy, art therapy allows for self-expression through visual means, making it an effective tool for those who may find verbal communication challenging.',
  //     'keyAreas': [
  //       'Emotional Expression: Provides a safe and non-verbal way for individuals to express complex emotions and experiences.',
  //       'Self-Discovery: Encourages self-exploration and insight through creative processes, helping individuals understand their thoughts and feelings.',
  //       'Stress Relief: Acts as a therapeutic outlet for reducing stress and promoting relaxation.',
  //       'Enhanced Communication: Improves communication skills by enabling individuals to articulate their emotions and experiences through art.',
  //       'Coping Skills: Develops effective coping mechanisms and problem-solving strategies through artistic expression.'
  //     ],
  //     'benefits': [
  //       'Anxiety and depression',
  //       'Trauma and grief',
  //       'Behavioral issues',
  //       'Low self-esteem',
  //       'Stress and emotional regulation',
  //     ]
  //   },
  //   {
  //     'image': 'assets/Therephy/development_theraphy.jpeg',
  //     'text': 'Developmental Therapy',
  //     'description':
  //     'Developmental Therapy is a specialized approach aimed at helping children reach their full developmental potential. It involves a comprehensive assessment of the child’s abilities and challenges, followed by the implementation of tailored interventions to support their growth and progress. The therapy is grounded in the understanding that each child develops at their own pace, and our goal is to provide the necessary support to foster optimal development.',
  //     'keyAreas': [
  //       'Cognitive Development: Enhancing problem-solving skills, memory, and learning abilities to support academic and daily life success.',
  //       'Social-Emotional Development: Building social skills, emotional regulation, and positive interactions to improve relationships and self-esteem.',
  //       'Language Skills: Supporting communication abilities, including both expressive and receptive language skills, to facilitate effective interaction.',
  //       'Motor Skills: Developing fine and gross motor skills through activities that improve coordination, strength, and physical abilities.',
  //     ],
  //     'benefits': [
  //       'Enhanced Development: Supports children in achieving developmental milestones and improving overall skills.',
  //       'Increased Confidence: Helps children build self-esteem through successful experiences and skill development.',
  //       'Improved Functioning: Facilitates better performance in daily activities, social interactions, and academic tasks.',
  //       'Family Support: Provides families with strategies and tools to support their child’s development at home.',
  //     ]
  //   }
  // ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProviders>(context, listen: false).getTherapiesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Therapies List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
            color: primarycolor, // Ensure primarycolor is defined
            fontSize: 20,
          ),
        ),
        leading: IconButton.filled(
          icon: const Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () {
            context.push("/main_dashBoard?initialIndex=0");
          },
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFECFAFA),
          ),
        ),
      ),
      body: Consumer<HomeProviders>(
        builder: (context, homeProvider, child) {
          final isLoading = homeProvider.isLoading;
          final itemCount = isLoading ? 6 : homeProvider.therapieslist.length;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(), // Smooth scrolling
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12.0), // Slightly increased
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: _getAspectRatio(context), // Dynamic
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (isLoading) {
                        return therapyGridShimmerItem(context);
                      } else {
                        final therapy = homeProvider.therapieslist[index];
                        return ProductGridItem(
                          imageUrl: therapy.servicePicUrl ?? "",
                          title: therapy.name ?? "",
                          onTap: () {
                            debugPrint("Tapped: ${therapy.name}");
                            try {
                              context.push(
                                "/service_details_screen?serviceID=${therapy.id}&serviceName=${Uri.encodeComponent(therapy.name ?? '')}",
                              );
                            } catch (e) {
                              debugPrint("Navigation error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Failed to navigate to details"),
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                    childCount: itemCount,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Dynamic aspect ratio for responsiveness
  double _getAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 1.0 : 0.9; // Adjust for tablets vs phones
  }

  // Shimmer item aligned with ProductGridItem
  Widget therapyGridShimmerItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                color: Colors.grey[300],
                child: Center(child: spinkits.getSpinningLinespinkit()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                shimmerText(100, 14, context),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
