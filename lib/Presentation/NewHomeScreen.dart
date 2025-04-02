import 'package:bounce/bounce.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/other_services.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:neuromithra/utils/CustomSnackBar.dart';
import 'package:neuromithra/utils/Shimmers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Logic/Location/location_cubit.dart';
import '../Logic/Location/location_state.dart';
import '../Model/ProfileDetailsModel.dart';
import '../TherapyScreens/DetailsScreen.dart';
import 'PaymentScreen.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    // Ensure token validity before making API requests
    await CheckHeaderValidity(); // Ensures token is valid or refreshed
    // Proceed with API calls regardless of token validity check
    await Future.wait([
      getProfileDetails(),
      getQuotes(),
    ]);

    setState(() {
      isLoading = false;
    });
  }

  String quote = '';
  Future<void> getQuotes() async {
    final res = await Userapi.getquotes();
    if (res?.quote != null) {
      setState(() {
        quote = res?.quote ?? '';
      });
    }
  }

  Future<void> postHealthFeedBack(String msg) async {
    final res = await Userapi.posthelathFeedback(msg);
    if (res?.status == true) {
      getProfileDetails();
      CustomSnackBar.show(context, res?.message ?? "Submitted Successfully");
    } else {
      CustomSnackBar.show(context, res?.message ?? "");
    }
  }

  User user_data = User();

  bool status = false;
  Future<void> getProfileDetails() async {
    String user_id = await PreferenceService().getString('user_id') ?? "";
    final Response = await Userapi.getprofiledetails(user_id);
    if (Response != null) {
      setState(() {
        user_data = Response.user ?? User();
        status = Response.healthFeedback?.status ?? false;
      });
    }
  }

  final List<Map<String, dynamic>> therapies = [
    {
      'image': 'assets/Therephy/speech_theraphy.jpg',
      'subtitle': 'Healing begins with self-compassion.',
      'text': 'Speech Therapy',
      'description':
          'Speech Therapy focuses on diagnosing and treating speech and language disorders to enhance a child’s ability to communicate. This therapy addresses various aspects of communication, including articulation, language comprehension, expressive language, and social communication, ensuring a comprehensive approach to speech and language development.',
      'keyAreas': [
        'Improved Articulation: Helps children produce clear speech sounds.',
        'Enhanced Language Comprehension: Develops understanding of spoken language.',
        'Strengthened Expressive Language: Supports expressing thoughts and emotions.',
        'Better Social Communication: Teaches essential interaction skills.'
      ],
      'benefits': [
        'Helps individuals with speech sound issues.',
        'Improves understanding and use of language.',
        'Enhances social communication skills.',
        'Supports those with speech-related disorders.'
      ]
    },
    {
      'image': 'assets/Therephy/occupational_theraphy.jpeg',
      'subtitle':
          "Helping Individuals Achieve Independence and Improve Daily Functioning.",
      'text': 'Occupational Therapy',
      'description':
          'Occupational Therapy focuses on helping children perform daily activities and tasks that are essential for their growth and development. This therapy addresses a range of skills, including fine motor skills, sensory processing, self-care tasks, and hand-eye coordination, to support overall functional independence and participation in daily life.',
      'keyAreas': [
        'Enhanced Fine Motor Skills: Develops the precise movements needed for activities such as writing, buttoning clothes, and using utensils.',
        'Improved Sensory Processing: Helps children manage and respond to sensory input effectively, promoting better focus and emotional regulation.',
        'Support for Self-Care Tasks: Assists in learning and performing essential self-care activities like dressing, grooming, and feeding.',
        'Better Hand-Eye Coordination: Improves the ability to coordinate visual input with hand movements, essential for many daily tasks.',
        'Increased Independence: Fosters the skills necessary for children to perform tasks independently, boosting their confidence and self-esteem.',
      ],
      'benefits': [
        'Have developmental delays or disabilities',
        'Experience difficulties with fine motor skills or hand-eye coordination',
        'Struggle with sensory processing issues',
        'Need support with self-care tasks and daily activities',
        'Need support with self-care tasks and daily activities',
        'Seek to improve their participation in school and other daily environments',
      ]
    },
    {
      'image': 'assets/Therephy/physical_theraphy.jpeg',
      'text': "Restoring Mobility and Improving Quality of Life.",
      'subtitle':
          "Empowering Movement and Enhancing Well-being for a Fuller Life.",
      'description':
          'Physical Therapy is a therapeutic approach focused on enhancing physical function, strength, and mobility through various techniques and exercises. This therapy aims to address and treat musculoskeletal, neurological, and developmental issues that impact an individual’s ability to perform daily activities and enjoy a fulfilling life.',
      'keyAreas': [
        'Improved Mobility: Enhances range of motion and movement abilities, allowing for greater independence in daily activities.',
        'Increased Strength: Builds muscle strength and endurance to support overall physical health and functionality.',
        'Enhanced Balance and Coordination: Helps improve balance and coordination, reducing the risk of falls and injuries.',
        'Pain Relief: Provides techniques and exercises to alleviate pain and discomfort associated with physical conditions or injuries.',
        'Rehabilitation Support: Assists in recovering from surgeries, injuries, or physical conditions by promoting optimal healing and function.'
      ],
      'benefits': [
        'Are recovering from injuries or surgeries.',
        'Experience chronic pain or discomfort.',
        'Have difficulty with movement, strength, or balance.',
        'Are dealing with musculoskeletal or neurological conditions.',
        'Seek to improve overall physical health and functionality.'
      ]
    },
  ];

  final List<Map<String, dynamic>> counsellings = [
    {
      'image': 'assets/Counciling/relationship_counsiling.jpeg',
      'text': 'Relationship Counselling',
      'subtitle': "Strengthening Bonds and Fostering Healthy Communication.",
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
      'text': "Promoting Positive Change and Emotional Well-being.",
      'subtitle': "Fostering Growth, Resilience, and Mental Wellness.",
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
      'subtitle':
          "Supporting Healing and Emotional Recovery Through Compassionate Guidance.",
      'heading1': '"Supporting Healing and Helping You Navigate Loss."',
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
    }
  ];

  void _showSOSConfirmationDialog(BuildContext context, loc) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents accidental dismissal
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Text(
                "Confirm SOS Call",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to make an SOS call? This action cannot be undone.",
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Epi",
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("No",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: "Epi",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _makeSOSCall(loc);
              },
              icon: Icon(Icons.call, color: Colors.white),
              label: Text(
                "Yes",
                style: TextStyle(
                    fontFamily: "Epi",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _makeSOSCall(loc) async {
    try {
      var res = await Userapi.makeSOSCallApi(loc);
      setState(() {
        if (res != null && res.isNotEmpty) {
        } else {
          print('No message received from the API');
        }
      });
    } catch (e) {
      debugPrint("${e.toString()}");
    }
  }

  void launchWhatsApp() async {
    String url = "https://wa.me/+91 8885320115}"; // WhatsApp API URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  void payment() async {
    try {
      var res = await Userapi.makePayment();

      if (res != null && res['success'] == true) {
        String paymentUrl = res['payment_url'];
        _launchURL(paymentUrl);
      } else {
        debugPrint("Payment failed: ${res?['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    int hour = DateTime.now().hour;
    String greeting;

    if (hour >= 0 && hour < 12) {
      greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return isLoading
        ? _shimmers(context)
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/neuromitralogo.png',
                      fit: BoxFit.contain,
                      scale: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          style: TextStyle(
                              color: Color(0xff371B34),
                              fontSize: 14,
                              fontFamily: 'Epi'),
                        ),
                        Text(
                          '${user_data.name?[0].toUpperCase()}${user_data.name?.substring(1)}',
                          style: TextStyle(
                            color: Color(0xff371B34),
                            fontSize: 14,
                            fontFamily: 'Epi',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                  String loc = '';
                  if (state is LocationLoaded) {
                    loc = state.locationName;
                  }
                  return InkResponse(
                    onTap: () {
                      _showSOSConfirmationDialog(context, loc);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Lottie.asset(
                        'assets/animations/sos.json',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 18),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: Color(0xff3EA4D2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${quote}",
                        style: TextStyle(
                            color: Color(0xffFBFBFB),
                            fontFamily: 'Epi',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                    if (status == false) ...[
                      Text(
                        'How are you feeling today ?',
                        style: TextStyle(
                            color: Color(0xffF371B34),
                            fontFamily: 'Epi',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            spacing: 10,
                            children: [
                              Bounce(
                                scaleFactor: 1.5,
                                onTap: () {
                                  postHealthFeedBack('Happy');
                                },
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: Color(0xffEF5DA8),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Image.asset('assets/smile.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Happy',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff828282),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Epi',
                                ),
                              )
                            ],
                          ),
                          Column(
                            spacing: 10,
                            children: [
                              Bounce(
                                scaleFactor: 1.5,
                                onTap: () {
                                  postHealthFeedBack('Calm');
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: Color(0xffAEAFF7),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Image.asset('assets/calm.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Calm',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff828282),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Epi',
                                ),
                              )
                            ],
                          ),
                          Column(
                            spacing: 10,
                            children: [
                              Bounce(
                                scaleFactor: 1.5,
                                onTap: () {
                                  postHealthFeedBack('Angry');
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: Color(0xffEA6D33),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Image.asset('assets/angry.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Angry',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff828282),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Epi',
                                ),
                              )
                            ],
                          ),
                          Column(
                            spacing: 10,
                            children: [
                              Bounce(
                                scaleFactor: 1.5,
                                onTap: () {
                                  postHealthFeedBack('Sad');
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: Color(0xffC3F2A6),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Image.asset('assets/smile.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Sad',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff828282),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Epi',
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                    Text(
                      'Therapies',
                      style: TextStyle(
                        color: Color(0xff0D0D0D),
                        fontFamily: 'Epi',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: h * 0.25,
                        onPageChanged: (index, reason) {
                          setState(() {
                            // currentIndex = index;
                          });
                        },
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        scrollDirection: Axis.horizontal,
                        pauseAutoPlayOnTouch: true,
                        aspectRatio: 1,
                      ),
                      items: therapies.map((item) {
                        return InkResponse(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return DetailsScreen(
                                    assetImage: item['image'] ??
                                        'assets/default_image.png', // Fallback for image
                                    title: item['text'] ??
                                        'No Title', // Fallback for text
                                    descHeading1:
                                        "", // You can add your own heading here
                                    description1: item['description'] ??
                                        'No Description', // Fallback for description
                                    descHeading2: "", // Fallback for heading
                                    description2:
                                        "", // Fallback for description
                                    keyAreas: List<String>.from(
                                        item['keyAreas'] ??
                                            []), // Fallback for keyAreas
                                    benefits: List<String>.from(
                                        item['benefits'] ??
                                            []), // Fallback for benefits
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/theraphybg.png',
                                    width: w,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 20),
                                    width: w * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['text'] ?? 'No Title',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Epi',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          item['subtitle'] ??
                                              'No Subtitle', // Fallback for subtitle
                                          style: TextStyle(
                                              color: Color(0xffDEDEDE),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Epi',
                                              fontSize: 10),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          spacing: 5,
                                          children: [
                                            Text(
                                              'Consult Now',
                                              style: TextStyle(
                                                  color: Color(0xffffffff),
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Epi',
                                                  fontSize: 16),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xffffffff),
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }).toList(),
                    ),
                    Text(
                      'Counselling',
                      style: TextStyle(
                        color: Color(0xff0D0D0D),
                        fontFamily: 'Epi',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: h * 0.25,
                        onPageChanged: (index, reason) {
                          setState(() {
                            // currentIndex = index;
                          });
                        },
                        enableInfiniteScroll: true,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        scrollDirection: Axis.horizontal,
                        pauseAutoPlayOnTouch: true,
                        aspectRatio: 1,
                      ),
                      items: counsellings.map((item) {
                        return InkResponse(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return DetailsScreen(
                                    assetImage: item['image'] ??
                                        'assets/default_image.png', // Fallback for image
                                    title: item['text'] ??
                                        'No Title', // Fallback for text
                                    descHeading1: item['heading1'] ??
                                        'No Heading', // Fallback for heading
                                    description1: item['description1'] ??
                                        'No Description', // Fallback for description
                                    descHeading2: item['heading2'] ??
                                        'No Heading', // Fallback for heading
                                    description2: item['description2'] ??
                                        'No Description', // Fallback for description
                                    keyAreas: List<String>.from(
                                        item['keyAreas'] ??
                                            []), // Handle null with empty list
                                    benefits: List<String>.from(
                                        item['benefits'] ??
                                            []), // Handle null with empty list
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/councilingbg.png',
                                    width: w,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                    width: w * 0.55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['text'] ?? 'No Title',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Epi',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          textAlign: TextAlign.start,
                                          item['subtitle'] ?? 'No Subtitle',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Epi',
                                              fontSize: 10),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          spacing: 5,
                                          children: [
                                            Text(
                                              'Consult Now',
                                              style: TextStyle(
                                                  color: Color(0xff3F414E),
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Epi',
                                                  fontSize: 16),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xff3F414E),
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: CircleBorder(),
              elevation: 2, // Adds shadow
              onPressed: () {
                launchWhatsApp();
                // // payment();
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentScreen()));
              },
              backgroundColor: Colors.blue,
              child: Image.asset("assets/whatsapp.png"),
            ),
          );
  }

  Widget _shimmers(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                shimmerCircle(35, context),
                SizedBox(
                  width: 10,
                ),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shimmerText(120, 12, context),
                    shimmerText(140, 12, context),
                  ],
                ),
              ],
            ),
          ),
          actions: [],
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerContainer(w, 80, context),
                SizedBox(
                  height: 8,
                ),
                shimmerText(120, 12, context),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 10,
                      children: [
                        shimmerContainer(60, 60, context),
                        shimmerText(40, 12, context),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        shimmerContainer(60, 60, context),
                        shimmerText(40, 12, context),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        shimmerContainer(60, 60, context),
                        shimmerText(40, 12, context),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        shimmerContainer(60, 60, context),
                        shimmerText(40, 12, context),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                shimmerText(120, 12, context),
                CarouselSlider(
                  options: CarouselOptions(
                    height: h * 0.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        // currentIndex = index;
                      });
                    },
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 1,
                  ),
                  items: therapies.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Stack(
                        children: [
                          shimmerContainer(w, 150, context),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            width: w * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                shimmerText(80, 12, context),
                                shimmerText(150, 12, context),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    shimmerText(80, 12, context),
                                    shimmerRectangle(20, context)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                shimmerText(120, 12, context),
                CarouselSlider(
                  options: CarouselOptions(
                    height: h * 0.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        // currentIndex = index;
                      });
                    },
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 1,
                  ),
                  items: counsellings.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Stack(
                        children: [
                          shimmerContainer(w, 150, context),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            width: w * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                shimmerText(80, 12, context),
                                shimmerText(150, 12, context),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  spacing: 5,
                                  children: [
                                    shimmerText(80, 12, context),
                                    shimmerRectangle(20, context)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
