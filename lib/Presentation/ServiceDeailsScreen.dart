import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/Shimmers.dart';
import '../Model/ReviewListModel.dart';
import '../Providers/AddressListProviders.dart';
import '../Providers/HomeProviders.dart';
import '../services/AuthService.dart';
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
    GetDetails();
  }

  GetDetails() async {
    final bool guest = await AuthService.isGuest;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProviders>(context, listen: false).getServiceDetails(widget.serviceID);
      if (!guest) {
        Provider.of<AddressListProvider>(context, listen: false).getAddressList();
      }
    });
  }

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
      appBar: AppBar(
        title: Text(
          widget.serviceName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
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
            backgroundColor: const Color(0xFFECFAFA),
          ),
        ),
      ),
      body: Consumer<HomeProviders>(
        builder: (context, homeProviders, child) {
          if (homeProviders.isLoading) {
            return _buildShimmerLoading(w, h);
          }
          if (homeProviders.serviceDetails?.name==null) {
            return _buildErrorState('No therapy data available');
          }
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: h * 0.12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderImage(homeProviders.serviceDetails?.service_pic_url ?? "", w, h),
                    const SizedBox(height: 12),
                    _buildPrice(homeProviders.serviceDetails?.amount.toString()??"", w),
                    _buildDescription(
                        homeProviders.serviceDetails?.description ?? 'No description available'),
                    _buildTabs(homeProviders.serviceDetails),
                    const SizedBox(height: 10),
                    _buildTabContent(homeProviders.serviceDetails),
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

  Widget _buildShimmerLoading(double w, double h) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerContainer(w, h * 0.3, context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: shimmerText(120, 20, context),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: shimmerText(w * 0.85, 90, context),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                shimmerText(100, 24, context),
                const SizedBox(width: 16),
                shimmerText(80, 24, context),
              ],
            ),
          )
        ],
      ),
    );
  }

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
              fontFamily: "general_sans",
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(String imageUrl, double w, double h) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: w,
          height: h * 0.3,
          fit: BoxFit.cover,
          placeholder: (context, url) => shimmerContainer(w, h * 0.3, context),
          errorWidget: (context, url, error) => Container(
            width: w,
            height: h * 0.3,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.red),
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

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.serviceName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "general_sans",
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
          backgroundColor: const Color(0xFFECFAFA),
        ),
      ),
    );
  }

  Widget _buildPrice(String amount, double w) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Price: ₹$amount /-",
        style: const TextStyle(
          fontSize: 18,
          color: primarycolor,
          fontWeight: FontWeight.w600,
          fontFamily: "general_sans",
        ),
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Html(
        data: description,
        style: {
          "body": Style(
            fontSize: FontSize(16),
            fontFamily:'general_sans',
            color: Colors.black87,
          ),
        },
      ),
    );
  }


  Widget _buildTabs(dynamic data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          if (data.keyAreaFocus?.isNotEmpty ?? false) ...[
            _tabButton("Key Areas of Focus", showFocus, () {
              setState(() => showFocus = true);
            }),
            const SizedBox(width: 20),
          ],
          if (data.benefits?.isNotEmpty ?? false) ...[
            _tabButton("Benefits", !showFocus, () {
              setState(() => showFocus = false);
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildTabContent(dynamic data) {
    return AnimatedCrossFade(
      firstChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Html(
          data:data.keyAreaFocus ?? "No key areas of focus available",
          style: {
            "body": Style(
              fontSize: FontSize(16),
              fontFamily:'general_sans',
              color: Colors.black87,
            ),
          },
        ),
      ),
      secondChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Html(
          data:data.benefits ?? "No key areas of focus available",
          style: {
            "body": Style(
              fontSize: FontSize(16),
              fontFamily:'general_sans',
              color: Colors.black87,
            ),
          },
        ),
      ),
      crossFadeState:
          showFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _tabButton(String text, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? primarycolor : Colors.black54,
          fontSize: 18,
          fontFamily: "general_sans",
          fontWeight: FontWeight.w600,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
          decorationColor: primarycolor,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, double h) {
    var address_provider = Provider.of<AddressListProvider>(context, listen: false);
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
                "Call Us", primarycolor, () => _launchCall("8885320115")),
            const SizedBox(width: 12),
            Consumer<HomeProviders>(
              builder: (context, provider, child) {
                final details = provider.serviceDetails;
                String appointmentMode = "online";
                if (details != null && details.type == "Therapy") {
                  if (details.name == "Speech Therapy") {
                    appointmentMode = "both";
                  } else {
                    appointmentMode = "offline";
                  }
                }
                final uri = '/book_appointment1?serviceID=${widget.serviceID}&appointmentMode=$appointmentMode&price=${details?.amount.toString()}';
                return _bottomButton("Book Now", primarycolor, () async {
                  final guest = await AuthService.isGuest;
                  if (guest) {
                    context.push('/login_with_mobile');
                  } else if(address_provider.addresses.isEmpty) {
                    context.push("/address_list");
                  }else{
                    context.push(uri);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(String text, Color color, VoidCallback onTap) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "general_sans",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
