import 'package:flutter/material.dart';

import 'CounsellingScreens/BehavioralCounsellingScreen.dart';
import 'CounsellingScreens/CareerCounsellingScreen.dart';
import 'CounsellingScreens/CrisisCounsellingScreen.dart';
import 'CounsellingScreens/EducationalCounsellingScreen.dart';
import 'CounsellingScreens/FamilyCounsellingScreen.dart';
import 'CounsellingScreens/GeneralStressManagementCounsellingScreen.dart';
import 'CounsellingScreens/GriefCounsellingScreen.dart';
import 'CounsellingScreens/GroupCounsellingScreen.dart';
import 'CounsellingScreens/IndividualCounsellingForChildrenScreen.dart';
import 'CounsellingScreens/MentalHealthCounsellingScreen.dart';
import 'CounsellingScreens/ParentChildRelationshipCounsellingScreen.dart';
import 'CounsellingScreens/ParentCounsellingForAutismScreen.dart';
import 'CounsellingScreens/RelationshipCounsellingScreen.dart';
import 'CounsellingScreens/SiblingCounsellingScreen.dart';
import 'TherapyScreens/DetailsScreen.dart';

class CounsellingListScreen extends StatelessWidget {
  // final List<Map<String, String>> counsellings = [
  //   {'image': 'assets/Counciling/relationship_counsiling.jpeg',
  //     'text': 'Relationship Counselling'},
  //   {'image': 'assets/Counciling/behavioral_counciling.jpeg',
  //     'text': 'Behavioral Counselling'},
  //   {'image': 'assets/Counciling/grief_counsiling.jpeg',
  //     'text': 'Grief Counselling'},
  //   {'image': 'assets/Counciling/group_counsiling.jpeg',
  //     'text': 'Group Counselling'},
  //   {'image':'assets/Counciling/crisis_counsiling.jpeg',
  //     'text': 'Crisis Counselling'},
  //   {'image': 'assets/Counciling/carreer_counsling.jpeg',
  //     'text': 'Career Counselling for parents'},
  //   {'image': 'assets/Counciling/sibiling_counciling.jpeg',
  //     'text': 'Sibling Counselling'},
  //   {'image': 'assets/Counciling/educationol_counsiling.jpeg',
  //     'text': 'Educational Counselling'},
  //   {'image':'assets/Counciling/parent_children_relationship.jpeg',
  //     'text': 'Parent-Child Relationship'},
  //   {'image': 'assets/Counciling/individual_counsilng_children.jpeg',
  //     'text': 'Individual Counselling for children'},
  //   {'image':'assets/Counciling/family_counsiling.jpeg',
  //     'text': 'Family Counselling'},
  //   {'image': 'assets/Counciling/mental_health_counsiling.jpeg',
  //     'text': 'Mental Health Counselling'},
  //   {'image': 'assets/Counciling/generalstress_councsiling.jpeg',
  //     'text': 'General stress management'},
  //   {'image': 'assets/Counciling/autism_Counsiling.png',
  //     'text': 'Parent Counselling for Autism'},
  // ];


  final List<Map<String, dynamic>> counsellings = [
    {
      'image': 'assets/Counciling/relationship_counsiling.jpeg',
      'text': 'Relationship Counselling',
      'heading1': 'Relationship Counseling for Couples at NeuroMitra',
      'description1':
      'At NeuroMitra, we believe that strong, healthy relationships are the foundation of a fulfilling life. Whether you’re navigating the challenges of a new relationship or looking to strengthen the bond you’ve built over years, our Relationship Counseling for Couples is here to support you.',
      'heading2': 'Why Relationship Counseling?',
      'description2':
      'Every relationship experiences ups and downs, but sometimes challenges can feel overwhelming. Our Relationship Counseling provides couples with a safe space to explore their feelings, improve communication, and rebuild trust. Whether you’re dealing with conflicts, communication issues, or simply want to enhance your relationship, we’re here to help.',
      'keyAreas': [
        'Personalized Sessions: We understand that every couple is unique. Our counseling sessions are tailored to address the specific needs and goals of your relationship.',
        'Effective Communication: We help you develop better communication skills, ensuring that both partners feel heard and understood.',
        'Conflict Resolution: Learn strategies to manage and resolve conflicts in a healthy, constructive manner.',
        'Rebuilding Trust: Whether dealing with past hurts or ongoing issues, we work with you to rebuild and strengthen trust in your relationship.',
        'Growth and Connection: Beyond resolving conflicts, we focus on fostering deeper connection and mutual growth, helping you rediscover the joy in your relationship.'
      ],
      'benefits': [
        'Pre-Marital Counseling: Preparing for marriage and wanting to build a strong foundation.',
        'Married Couples: Looking to navigate challenges or enhance your relationship.',
        'Long-Term Partners: Seeking to reignite connection and strengthen your bond.',
        'Couples in Crisis: Facing significant issues that threaten the stability of your relationship.'
      ]
    },
    {
      'image': 'assets/Counciling/behavioral_counciling.jpeg',
      'text': 'Behavioral Counselling',
      'heading1': 'Behavioral Counseling Services at NeuroMitra',
      'description1':
      'At NeuroMitra, we are committed to helping individuals understand and modify behaviors that may be affecting their lives. Our Behavioral Counseling Services are designed to support clients in identifying negative behavior patterns, developing positive coping strategies, and achieving lasting change.',
      'heading2': 'What is Behavioral Counseling?',
      'description2':
      'Behavioral Counseling focuses on understanding the connection between thoughts, feelings, and behaviors. It involves working with a trained counselor to identify unhelpful behaviors, understand their underlying causes, and develop strategies to replace them with more positive actions. This type of counseling is particularly effective for individuals dealing with issues such as anxiety, depression, stress, anger management, and behavioral disorders.',
      'keyAreas': [
        'Personalized Treatment Plans: We tailor our counseling sessions to address the specific behaviors and challenges you’re facing, ensuring that you receive targeted and effective support.',
        'Evidence-Based Techniques: Our counselors use proven therapeutic approaches, such as Cognitive Behavioral Therapy (CBT), to help you develop healthier behaviors and thought patterns.',
        'Goal-Oriented Therapy: We work with you to set achievable goals and track your progress, helping you stay motivated and focused on your journey to change.',
        'Skill Development: Learn practical techniques to manage emotions, improve decision-making, and respond to situations in healthier ways.'
      ],
      'benefits': [
        'Anxiety and Depression: Learn to manage symptoms by changing the behaviors and thought patterns that contribute to these conditions.',
        'Stress Management: Develop coping strategies to handle stress more effectively, reducing its impact on your daily life.',
        'Anger Management: Understand the triggers of your anger and learn healthier ways to express and manage your emotions.',
        'Behavioral Disorders: Address issues such as ADHD, OCD, and other behavioral challenges with targeted support.',
        'Relationship Issues: Improve communication, conflict resolution, and other behaviors that impact your relationships.'
      ]
    },
    {
      'image': 'assets/Counciling/grief_counsiling.jpeg',
      'text': 'Grief Counselling',
      'heading1': 'Grief Counseling Services at NeuroMitra',
      'description1':
      'At NeuroMitra, we understand that grief is a deeply personal and often overwhelming experience. Our Grief Counseling Services are here to provide compassionate support and guidance as you navigate the difficult journey of loss.',
      'heading2': 'What is Grief Counseling?',
      'description2':
      'Grief Counseling is a therapeutic process designed to help individuals cope with the emotional and psychological impact of losing a loved one. Whether your loss is recent or occurred some time ago, our counselors are here to help you process your feelings, find comfort, and move forward at your own pace.',
      'keyAreas': [
        'Compassionate Support: We offer a safe, non-judgmental space where you can openly express your grief and share your emotions.',
        'Personalized Care: Every individual’s grief journey is unique. We tailor our counseling sessions to meet your specific needs, honoring your personal experience of loss.',
        'Healing Techniques: Our counselors use evidence-based approaches to help you process your grief, manage overwhelming emotions, and find ways to cope with the changes in your life.',
        'Long-Term Support: Grief doesn’t have a timeline, and neither does our support. We’re here to walk alongside you, offering continued care as you navigate your grief journey.'
      ],
      'benefits': [
        'Experienced Counselors: Our grief counselors are specially trained in bereavement support and have extensive experience helping individuals process and cope with loss.',
        'Confidential and Respectful Environment: We respect your privacy and ensure a confidential space where you can share your thoughts and feelings without fear of judgment.',
        'Holistic Healing: We focus on the whole person, addressing not just the emotional aspects of grief but also the physical, spiritual, and psychological impacts.',
        'Flexible Support Options: We offer both individual and group counseling sessions, as well as online and in-person options, to accommodate your preferences and needs.'
      ]
    },
    {
      'image': 'assets/Counciling/group_counsiling.jpeg',
      'text': 'Group Counselling',
      'heading1': 'Group Counseling Services at NeuroMitra',
      'description1':
      'At NeuroMitra, we believe in the power of shared experiences. Our Group Counseling Services provide a supportive and collaborative environment where individuals can come together to explore common challenges, share insights, and find strength in community.',
      'heading2': 'What is Group Counseling?',
      'description2':
      'Group Counseling involves bringing together a small group of individuals who share similar concerns or life experiences. Led by a skilled therapist, these sessions offer a space for participants to discuss their feelings, learn from each other, and develop new coping strategies. Whether you’re dealing with stress, anxiety, grief, or other life challenges, group counseling can offer the support and perspective you need.',
      'keyAreas': [
      ],
      'benefits': [
        'Shared Understanding: Connect with others who are facing similar challenges, fostering a sense of belonging and mutual support.',
        'Multiple Perspectives: Gain insights from the diverse experiences and viewpoints of group members, helping you see your situation in a new light.',
        'Skill Development: Learn practical coping strategies, communication skills, and problem-solving techniques in a supportive setting.',
        'Enhanced Motivation: Being part of a group can provide encouragement and accountability, helping you stay committed to your personal growth.',
        'Cost-Effective: Group counseling is often more affordable than individual sessions, making it a great option for those seeking quality care at a lower cost.'
      ]
    },
    {
      'image': 'assets/Counciling/crisis_counsiling.jpeg',
      'text': 'Crisis Counselling',
      'heading1': 'Crisis Counseling Services at NeuroMitra',
      'description1':
      'At NeuroMitra, we understand that crises can strike unexpectedly, leaving individuals and families feeling overwhelmed and unsure of where to turn. Our Crisis Counseling Services are designed to provide immediate support and guidance during these challenging times.',
      'heading2': 'What is Crisis Counseling?',
      'description2':
      'Crisis Counseling involves short-term intervention aimed at helping individuals cope with acute stress and trauma resulting from a crisis situation. Whether you’re facing a personal crisis, dealing with a traumatic event, or experiencing heightened emotional distress, our counselors are here to provide compassionate support.',
      'keyAreas': [
        'Immediate Support: We offer timely and responsive counseling to address urgent emotional needs.',
        'Holistic Care: Our counselors are trained in various therapeutic approaches, ensuring a comprehensive approach tailored to your unique situation.',
        'Confidentiality: Your privacy is paramount. We provide a safe space for open and honest discussions without judgment.',
        'Collaborative Guidance: We work collaboratively with you to develop coping strategies and navigate through difficult emotions.'
      ],
      'benefits': [
        'Personal Crises: Relationship issues, sudden loss, or personal trauma.',
        'Community Crises: Natural disasters, accidents, or community-wide emergencies.',
        'Health Crises: Serious illness diagnosis or medical emergencies.'
      ]
    },
    {
      'image': 'assets/Counciling/carreer_counsling.jpeg',
      'text': 'Career Counselling for parents',
      'heading1': 'Career Counseling for Parents',
      'description1':
      'Career Counseling for Parents at NEUROMITRA is designed to support parents in navigating the challenges of balancing their careers with family life. Our goal is to help parents achieve both professional fulfillment and a healthy, nurturing home environment.',
      'heading2': 'What is Career Counseling for Parents?',
      'description2':
      'Career Counseling for Parents focuses on helping parents find harmony between their work and family responsibilities. Whether you’re returning to work after a break, managing the demands of a challenging career, or looking to make a career transition, this counseling provides tailored strategies to help you succeed both at work and at home.',
      'keyAreas': [
        'Work-Life Balance: Develop strategies to effectively manage time and energy between career and family responsibilities.',
        'Career Planning: Receive guidance on career advancement, transitions, or re-entry into the workforce after a break.',
        'Stress Management: Learn techniques to reduce work-related stress and maintain emotional well-being.',
        'Job Satisfaction: Explore ways to increase job satisfaction while fulfilling your role as a parent.',
        'Enhanced Family Relationships: Gain insights on how to strengthen family bonds while pursuing professional goals.'
      ],
      'benefits': [
        'Parents returning to work after a break, such as maternity or paternity leave',
        'Parents facing challenges in balancing work and family life',
        'Individuals considering a career change or advancement while managing family responsibilities',
        'Parents experiencing work-related stress or burnout',
        'Those seeking to improve job satisfaction while maintaining a healthy family dynamic'
      ]
    },
    {
      'image': 'assets/Counciling/sibiling_counciling.jpeg',
      'text': 'Sibling Counselling',
      'heading1': 'Sibling Counseling',
      'description1':
      'Sibling Counseling at NEUROMITRA is designed to support siblings of children with special needs, helping them navigate the unique challenges they may face. Our goal is to foster understanding, communication, and emotional resilience within the sibling relationship, ensuring a supportive and harmonious family dynamic.',
      'heading2': 'What is Sibling Counseling?',
      'description2':
      'Sibling Counseling focuses on addressing the emotional and psychological needs of siblings who may experience feelings of jealousy, resentment, confusion, or guilt due to their brother or sister’s special needs. This type of counseling provides a safe space for siblings to express their feelings, gain a deeper understanding of their sibling’s condition, and develop coping strategies to manage their emotions and responsibilities.',
      'keyAreas': [
        'Understanding and Acceptance: Helps siblings develop a better understanding of their brother or sister’s special needs, fostering empathy and acceptance.',
        'Emotional Support: Provides a space for siblings to share their feelings and receive validation and support.',
        'Coping Strategies: Equips siblings with tools and techniques to manage their emotions and cope with the challenges of growing up with a sibling who has special needs.',
        'Improved Communication: Enhances communication skills within the family, helping siblings express their needs and concerns more effectively.',
        'Strengthened Sibling Bonds: Promotes positive interactions and strengthens the emotional bond between siblings, contributing to a more supportive family environment.'
      ],
      'benefits': [
        'Siblings of children with special needs who may be struggling with feelings of jealousy, resentment, or guilt',
        'Families looking to improve communication and strengthen relationships among siblings',
        'Siblings who need support in understanding and accepting their brother or sister’s condition',
        'Parents who want to ensure a balanced and supportive environment for all their children'
      ]
    },
    {
      'image': 'assets/Counciling/educationol_counsiling.jpeg',
      'text': 'Educational Counselling',
      'heading1': 'Educational Counseling',
      'description1':
      'Educational Counseling provides personalized guidance to support children and parents in navigating academic challenges and achieving educational success. This service focuses on identifying learning difficulties, creating effective study plans, and assisting with school transitions, ensuring that each child receives the tools and strategies needed to thrive academically. Whether addressing specific learning disabilities or helping with academic planning, Educational Counseling empowers students to reach their full potential and supports parents in understanding and meeting their child’s educational needs.',
      'heading2': '',
      'description2': '',
      'keyAreas': [
        'Learning Disability Assessment: Identifying and addressing specific learning difficulties.',
        'Academic Planning: Crafting personalized study plans and strategies for success.',
        'School Transitions: Assisting with smooth transitions between schools or educational levels.',
        'Study Skills Development: Teaching effective study habits and time management techniques.',
        'Parental Guidance: Helping parents understand and support their child’s educational journey.',
        'Our goal is to ensure every student receives the support they need to excel in their academic endeavors.'
      ],
      'benefits': [
      ]
    },
    {
      'image': 'assets/Counciling/parent_children_relationship.jpeg',
      'text': 'Parent-Child Relationship',
      'heading1': 'Parent-Child Relationship Counseling',
      'description1':
      'Parent-Child Relationship Counseling at NEUROMITRA is designed to strengthen the connection between parents and their children. This counseling service focuses on improving communication, resolving conflicts, and enhancing emotional bonds within the family, helping both parents and children navigate challenges together.',
      'heading2': 'What is Parent-Child Relationship Counseling?',
      'description2': 'Parent-Child Relationship Counseling addresses the dynamics between parents and their children, focusing on fostering a deeper understanding and improving interactions. This type of counseling helps parents develop effective parenting strategies while providing children with the tools to express their emotions and needs more clearly. The goal is to create a supportive, loving environment where both parent and child feel heard, respected, and valued.',
      'keyAreas': [
        'Improved Communication: Enhances the way parents and children talk to each other, making interactions more positive and meaningful.',
        'Conflict Resolution: Provides strategies for resolving conflicts in a healthy and constructive manner.',
        'Emotional Bonding: Strengthens the emotional connection between parents and children, fostering a sense of security and trust.',
        'Understanding Child Development: Helps parents better understand their child’s developmental stages and how to respond effectively.',
        'Positive Parenting Techniques: Equips parents with practical tools and techniques for managing behavioral challenges and promoting positive behavior.'
      ],
      'benefits': [
        'Parents and children experiencing frequent conflicts or communication breakdowns',
        'Families going through significant changes, such as divorce, relocation, or the addition of a new family member',
        'Parents seeking to strengthen their bond with their child and improve their parenting skills',
        'Children struggling with behavioral issues or emotional challenges that impact their relationship with their parents',
        'Families looking to create a more supportive, loving home environment'
      ]
    },
    {
      'image': 'assets/Counciling/individual_counsilng_children.jpeg',
      'text': 'Individual Counselling for children',
      'heading1': 'Individual Counseling for Children',
      'description1':
      'Individual Counseling for Children at NEUROMITRA is tailored to meet the unique emotional and mental health needs of children. Our goal is to provide a safe, supportive environment where children can express their feelings, overcome challenges, and develop the skills they need to thrive.',
      'heading2': 'What is Individual Counseling for Children?',
      'description2': 'Individual counseling for children focuses on helping them navigate a variety of emotional, behavioral, and psychological issues. Whether your child is dealing with anxiety, depression, behavioral problems, or other mental health concerns, our experienced counselors are here to provide personalized support. Through one-on-one sessions, children are encouraged to explore their emotions, learn coping strategies, and build resilience.',
      'keyAreas': [
        'Emotional Expression: Provides children with a safe space to express their thoughts and feelings openly.',
        'Anxiety and Depression Management: Helps children understand and manage symptoms of anxiety, depression, and other mood disorders.',
        'Behavioral Support: Addresses behavioral challenges by teaching positive behavior strategies and self-control techniques.',
        'Self-Esteem Building: Promotes healthy self-esteem and confidence in children.',
        'Coping Skills Development: Equips children with practical coping mechanisms to handle stress, peer pressure, and other challenges.'
      ],
      'benefits': [
        'Children experiencing anxiety, depression, or other mental health issues',
        'Those struggling with behavioral problems, such as aggression, defiance, or hyperactivity',
        'Children facing significant life changes, such as parental divorce, relocation, or the loss of a loved one',
        'Kids who have difficulty making friends or dealing with peer pressure',
        'Children with low self-esteem or who are experiencing bullying'
      ]
    },
    {
      'image': 'assets/Counciling/family_counsiling.jpeg',
      'text': 'Family Counseling',
      'heading1': 'Family Counseling',
      'description1':
      'Family Counseling at NEUROMITRA is designed to help families navigate challenges, improve communication, and build stronger, healthier relationships. Whether you’re dealing with conflicts, life transitions, or simply want to enhance your family dynamic, our experienced counselors are here to guide you through the process.',
      'heading2': 'What is Family Counseling?',
      'description2': 'Family counseling is a form of therapy that addresses the behaviors, emotions, and interactions within a family system. It focuses on improving communication, resolving conflicts, and fostering a supportive environment where each family member feels valued and understood. Family counseling can be especially beneficial during times of stress, such as divorce, illness, or major life changes.',
      'keyAreas': [
        'Improved Communication: Helps family members express their thoughts and feelings more effectively, leading to better understanding and cooperation.',
        'Conflict Resolution: Provides tools and strategies to resolve conflicts in a healthy and constructive manner.',
        'Strengthened Relationships: Enhances emotional bonds between family members, promoting unity and togetherness.',
        'Coping with Life Transitions: Assists families in navigating significant life changes, such as moving, loss of a loved one, or changes in family structure.',
        'Support for Parenting Challenges: Offers guidance on parenting issues, helping parents and children work together more harmoniously.'
      ],
      'benefits': [
        'Families experiencing ongoing conflicts or communication breakdowns',
        'Parents and children struggling with discipline issues or differing expectations',
        'Families undergoing major life transitions, such as divorce, remarriage, or relocation',
        'Families dealing with the impact of mental health issues, addiction, or trauma',
        'Anyone looking to strengthen their family relationships and create a more positive home environment'
      ]
    },
    {
      'image': 'assets/Counciling/mental_health_counsiling.jpeg',
      'text': 'Mental Health Counseling',
      'heading1': 'Mental Health Counseling',
      'description1':
      'Mental Health Counseling at NEUROMITRA offers personalized support for individuals dealing with a wide range of mental health challenges. Whether you’re facing anxiety, depression, stress, or any other emotional difficulty, our compassionate counselors are here to help you navigate your journey toward better mental health.',
      'heading2': 'What is Mental Health Counseling?',
      'description2': 'Mental health counseling is a professional service that provides support, guidance, and therapeutic strategies to help individuals cope with and overcome emotional and psychological issues. The goal is to improve mental well-being, enhance self-awareness, and empower you to lead a more fulfilling life.',
      'keyAreas': [
        'Anxiety Management: Learn effective techniques to reduce anxiety and regain control over your thoughts and feelings.',
        'Depression Support: Receive the support and tools needed to manage symptoms of depression and find hope in your life.',
        'Stress Relief: Discover practical strategies to manage stress and build resilience in the face of life’s challenges.',
        'Improved Emotional Regulation: Gain insights into your emotions and develop healthier ways to express and manage them.',
        'Enhanced Self-Esteem: Work on building a stronger sense of self-worth and confidence.'
      ],
      'benefits': [
        'Individuals experiencing symptoms of anxiety, depression, or other mood disorders',
        'Those struggling with stress, burnout, or overwhelming life situations',
        'Individuals facing significant life changes or transitions',
        'People dealing with low self-esteem or identity issues',
        'Anyone seeking to improve their overall emotional and psychological well-being'
      ]
    },
    {
      'image': 'assets/Counciling/generalstress_councsiling.jpeg',
      'text': 'General stress management',
      'heading1': 'General Stress Management Counseling',
      'description1':
      'General Stress Management Counseling at NEUROMITRA is designed to help you cope with the pressures of daily life and find a sense of calm and balance. Whether it’s work-related stress, personal challenges, or the constant demands of modern life, our expert counselors are here to guide you in managing stress effectively and improving your overall well-being.',
      'heading2': 'What is Stress Management Counseling?',
      'description2': 'Stress Management Counseling focuses on identifying the sources of stress in your life and developing strategies to manage and reduce it. Through personalized sessions, you’ll learn practical tools and techniques to help you navigate stressful situations, improve your mental clarity, and maintain emotional stability.',
      'keyAreas': [
        'Stress Identification: Understand the root causes of your stress and how it affects your mind and body.',
        'Relaxation Techniques: Learn effective methods such as deep breathing, mindfulness, and meditation to reduce stress levels.',
        'Coping Strategies: Develop healthy coping mechanisms to handle stress in both personal and professional settings.',
        'Time Management: Gain insights into better organizing your time to reduce overwhelm and increase productivity.',
        'Improved Well-being: Achieve a balanced lifestyle that promotes both mental and physical health.'
      ],
      'benefits': [
        'Individuals feeling overwhelmed by work, family, or personal responsibilities',
        'Those experiencing physical symptoms of stress, such as headaches, fatigue, or tension',
        'People struggling with anxiety or worry about the future',
        'Anyone looking to improve their quality of life by reducing stress and increasing relaxation',
        'Individuals seeking to build resilience and better handle life’s challenges'
      ]
    },
    {
      'image': 'assets/Counciling/autism_Counsiling.png',
      'text': 'Parent Counseling for Autism',
      'heading1': 'Parent Counseling for Autism',
      'description1':
      'At NEUROMITRA, we understand the unique challenges that come with raising a child with autism. Our Parent Counseling for Autism services are designed to provide parents with the tools, knowledge, and emotional support needed to navigate this journey with confidence and compassion.',
      'heading2': 'What is Parent Counseling for Autism?',
      'description2': 'Parent Counseling for Autism focuses on helping parents understand autism, manage behaviors, and improve communication with their child. Through personalized counseling sessions, parents are guided in developing effective strategies that support their child’s development and well-being.',
      'keyAreas': [
        'Understanding Autism: Gain a deeper understanding of autism spectrum disorder (ASD) and how it affects your child’s behavior and development.',
        'Behavior Management: Learn practical techniques to manage challenging behaviors and encourage positive development.',
        'Communication Strategies: Discover ways to enhance communication with your child, fostering better understanding and connection.',
        'Emotional Support: Receive emotional guidance and support to cope with the stresses and emotions that can accompany parenting a child with autism.',
        'Access to Resources: Get connected with valuable resources, support networks, and information to help you navigate your child’s needs.'
      ],
      'benefits': [
        'Parents of children newly diagnosed with autism seeking guidance and support',
        'Families looking to better understand their child’s behavior and communication patterns',
        'Caregivers needing strategies to manage challenging behaviors and promote positive development',
        'Parents feeling overwhelmed or stressed by the demands of raising a child with autism',
        'Families seeking to improve their overall communication and relationship with their child'
      ]
    },

  ];


  void _onCounsellingTap(BuildContext context, String text) {
    Widget screen;
    switch (text) {
      case 'Relationship Counselling':
        screen = RelationshipCounsellingScreen();
        break;
      case 'Behavioral Counselling':
        screen = BehavioralCounsellingScreen();
        break;
      case 'Grief Counselling':
        screen = GriefCounsellingScreen();
        break;
      case 'Group Counselling':
        screen = GroupCounsellingScreen();
        break;
      case 'Crisis Counselling':
        screen = CrisisCounsellingScreen();
        break;
      case 'Career Counselling for parents':
        screen = CareerCounsellingScreen();
        break;
      case 'Sibling Counselling':
        screen = SiblingCounsellingScreen();
        break;
      case 'Educational Counselling':
        screen = EducationalCounsellingScreen();
        break;
      case 'Parent-Child Relationship':
        screen = ParentChildRelationshipCounsellingScreen();
        break;
      case 'Individual Counselling for children':
        screen = IndividualCounsellingForChildrenScreen();
        break;
      case 'Family Counselling':
        screen = FamilyCounsellingScreen();
        break;
      case 'Mental Health Counselling':
        screen = MentalHealthCounsellingScreen();
        break;
      case 'General stress management':
        screen = GeneralStressManagementCounsellingScreen();
        break;
      case 'Parent Counselling for Autism':
        screen = ParentCounsellingForAutismScreen();
        break;
      default:
      // Handle unknown text
        screen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counselling List')),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
          crossAxisSpacing: 10.0,
        ),
        itemCount: counsellings.length,
        itemBuilder: (context, index) {
          final counselling = counsellings[index];
          return
            InkWell(
              // onTap: () => _onCounsellingTap(context, counselling['text']!),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      assetImage: counselling['image'],
                      title: counselling['text'],
                      descHeading1: counselling['heading1'],
                      description1: counselling['description1'],
                      descHeading2: counselling['heading2'],
                      description2: counselling['description2'],
                      keyAreas: List<String>.from(counselling['keyAreas']),
                      benefits: List<String>.from(counselling['benefits']),
                    ),
                  ),
                );
              },
              child: ProductGridItem(
                imageUrl: counselling['image']!,
                title:counselling['text']!,
              ),
            );
        },
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  ProductGridItem({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageUrl,
            width: 150, // Adjust width as needed
            height: 106, // Adjust height as needed
            fit: BoxFit.cover,

          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
