import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/ReviewListModel.dart';
import '../Providers/HomeProviders.dart';
import '../utils/Color_Constants.dart';
import '../utils/constants.dart';
import '../utils/spinkits.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String serviceName;
  final String serviceID;
  const ServiceDetailsScreen(
      {super.key, required this.serviceName, required this.serviceID});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  bool showFocus = true;
  @override
  void initState() {
    super.initState();
    // GetReviewsList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProviders>(context, listen: false)
          .getServiceDetails(widget.serviceID);
    });
  }

  List<Review> reviews = [];
  // Future<void> GetReviewsList() async {
  //   final response = await Userapi.getReviewList();
  //   if (response != null) {
  //     setState(() {
  //       reviews = response.review ?? [];
  //     });
  //   }
  // }

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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer<HomeProviders>(
        builder: (context, homeProviders, child) {
          if (homeProviders.isLoading) {
            return _buildShimmerLoading(w, h);
          }
          if (homeProviders.therapyDetails.isEmpty) {
            return _buildErrorState('No therapy data available');
          }
          final data = homeProviders.therapyDetails[0];
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: h * 0.12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderImage(data.image ??"", w, h),
                    const SizedBox(height: 10),
                    _buildPrice(data.amount.toString(), w),
                    _buildDescription(
                        data.description ?? 'No description available'),
                    _buildTabs(data),
                    _buildTabContent(data),
                    // Uncomment and enhance reviews section
                    // _buildReviewsSection(context),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, h),
    );
  }

  // Description display
  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: 10,
      ),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          fontFamily: "Inter",
          color: Colors.black87,
        ),
      ),
    );
  }

  // Tabs for Key Areas of Focus and Benefits
  Widget _buildTabs(dynamic data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          if (data.keyAreaFocus?.isNotEmpty ?? false) ...[
            _tabButton("Key Areas of Focus", showFocus, () {
              setState(() {
                showFocus = true;
              });
            }),
            const SizedBox(width: 20),
          ],
          if (data.benefits?.isNotEmpty ?? false) ...[
            _tabButton("Benefits", !showFocus, () {
              setState(() {
                showFocus = false;
              });
            }),
          ],
        ],
      ),
    );
  }

  // Tab content display with animation
  Widget _buildTabContent(dynamic data) {
    return AnimatedCrossFade(
      firstChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Text(
          data.keyAreaFocus ?? "No key areas of focus available",
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            fontFamily: "Inter",
            color: Colors.black87,
          ),
        ),
      ),
      secondChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Text(
          data.benefits ?? "No benefits available",
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            fontFamily: "Inter",
            color: Colors.black87,
          ),
        ),
      ),
      crossFadeState: showFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Bottom navigation bar with Call Us and Book Now buttons
  Widget _buildBottomNavigationBar(BuildContext context, double h) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            _bottomButton(
              "Call Us",
              primarycolor,
                  () => _launchCall("8885320115"),
            ),
            const SizedBox(width: 12),
            _bottomButton(
              "Book Now",
              primarycolor,
                  () {
                context.push(
                  '/book_appointment',
                  extra: {'pagesource': widget.serviceName},
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tab button widget
  Widget _tabButton(String text, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? primarycolor : Colors.black54,
          fontSize: 18,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
          decorationColor: isActive ? primarycolor : Colors.black54,
        ),
      ),
    );
  }

  // Bottom button widget
  Widget _bottomButton(String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }


  // AppBar widget
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.serviceName,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
          color: primarycolor,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton.filled(
        icon: const Icon(Icons.arrow_back, color: primarycolor),
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(
          backgroundColor: Color(0xFFECFAFA),
        ),
      ),
    );
  }

  // Shimmer loading effect
  Widget _buildShimmerLoading(double w, double h) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w,
              height: h * 0.3,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Container(
                width: 150,
                height: 20,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: 10,
              ),
              child: Container(
                width: w * 0.8,
                height: 100,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Error state widget
  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 50),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Header image with gradient overlay
  Widget _buildHeaderImage(String imageUrl, double w, double h) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: w,
          height: h * 0.3,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 150.0,
            height: 106.0,
            color: Colors.grey[300],
            child: Center(child: spinkits.getSpinningLinespinkit()),
          ),
        ),
        Container(
          width: w,
          height: h * 0.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.3), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }

  // Price display
  Widget _buildPrice(String amount, double w) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding),
      child: Text(
        "Price: ₹$amount /-",
        style:  TextStyle(
          fontSize: 18,
          color: primarycolor,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
      ),
    );
  }
}
