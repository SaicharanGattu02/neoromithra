import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  final List<BannerItem> banners = [
    BannerItem(
      image: 'https://via.placeholder.com/400x200',
      url: 'https://example.com/category/1',
    ),
    BannerItem(
      image: 'https://via.placeholder.com/400x200',
      url: 'https://example.com/diagnostic/2',
    ),
    BannerItem(
      image: 'https://via.placeholder.com/400x200',
      url: 'https://example.com/category/3',
    ),
  ];

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
    return Scaffold(appBar: AppBar(
      leadingWidth: 0,
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
                  'Sarina!',
                  style: TextStyle(
                      color: Color(0xff371B34),
                      fontSize: 14,
                      fontFamily: 'Epi',
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.notifications_active_sharp),
        )
      ],
    ),
      body:    SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 18),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xff3EA4D2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  'It is better to conquer yourself than to win a thousand battles',
                  style: TextStyle(
                      color: Color(0xffFBFBFB),
                      fontFamily: 'Epi',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
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
                      Container(
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
                      Container(
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
                      Container(
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
                      Container(
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
                items: banners.map((item) {
                  return InkResponse(
                      onTap: () {},
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
                            Container(margin: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                              width: w * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Speech Therapy',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Epi',
                                        fontSize: 20),
                                  ),
                                  Text(
                                    textAlign: TextAlign.start,
                                    'Healing begins with self-compassion.',
                                    style: TextStyle(
                                        color: Color(0xffDEDEDE),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Epi',
                                        fontSize: 12),
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
                      )
                  );
                }).toList(),
              ), SizedBox(
                height: 10,
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
                items: banners.map((item) {
                  return InkResponse(
                      onTap: () {},
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
                            Container(margin: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                              width: w * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Group Counselling',
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Epi',
                                        fontSize: 20),
                                  ),
                                  Text(
                                    textAlign: TextAlign.start,
                                    'Healing begins with self-compassion.',
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Epi',
                                        fontSize: 12),
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
                      )
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class BannerItem {
  final String? image;
  final String? url;

  BannerItem({this.image, this.url});
}
