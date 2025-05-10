import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Providers/LogInWithMobileProvider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../services/Preferances.dart';
import '../../utils/Color_Constants.dart';
import '../../utils/media_query_helper.dart';


class Otp extends StatefulWidget {
  String mobile;
  Otp({super.key, required this.mobile});
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  bool _isOtpValid = false;
  String fbToken = "";

  @override
  void initState() {
    super.initState();
    // _loadTokens();
  }

  // Future<void> _loadTokens() async {
  //   print('Loading tokens...');
  //   fbToken = await PreferenceService().getString('fbstoken') ?? "";
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  String? _validateOtp(String otp) {
    if (otp.length < 4) {
      return 'Please enter a 4-digit OTP';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(otp)) {
      return 'OTP must contain only digits';
    }
    return null;
  }

  void _onOtpChanged(String otp) {
    bool isValid = _validateOtp(otp) == null;
    if (isValid) {
      _otpFocusNode.unfocus();
    }
    setState(() {
      _isOtpValid = isValid;
    });
  }

  Future<void> _verifyOtp() async {
    String fcmToken =  await PreferenceService().getString("fbstoken") ?? "";
    Map<String, dynamic> data = {
      "phone": widget.mobile,
      "otp": _otpController.text,
      "fcm_token": fcmToken,
    };
   Provider.of<LoginWithMobileProvider>(context,listen: false).VerifyOtp(context, data);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:
        SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Center(
                      child: Image.asset(
                        "assets/neuromitralogo.png",
                        width: SizeConfig.screenWidth * 0.35,
                        height: SizeConfig.screenHeight * 0.15,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'OTP Verification',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                            color: charcoal,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'lexend',
                          ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF2C2F33),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'lexend',
                        ),
                        children: [
                          TextSpan(
                            text: 'Enter the 4-digit code sent to your registered mobile ',
                          ),
                          TextSpan(
                            text: '+91 ${widget.mobile}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: IconButton(
                                onPressed: () {
                                  context.pushReplacement('/login_mobile', extra: widget.mobile);
                                },
                                icon: Image.asset("assets/edit1.png",scale: 35,),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '  Continue your journey!',
                            style: TextStyle(
                              color: primarycolor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    PinCodeTextField(
                      autoUnfocus: true,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      blinkWhenObscuring: true,
                      autoFocus: true,
                      autoDismissKeyboard: false,
                      showCursor: true,
                      animationType: AnimationType.fade,
                      focusNode: _otpFocusNode,
                      hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                      controller: _otpController,
                      onTap: () {},
                      onChanged: _onOtpChanged, // Handle OTP changes
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 48,
                        fieldWidth: 48,
                        fieldOuterPadding: EdgeInsets.only(left: 0, right: 3),
                        activeFillColor: Color(0xFFF4F4F4),
                        activeColor: Color(0xff110B0F),
                        selectedColor: Color(0xff110B0F),
                        selectedFillColor: Color(0xFFF4F4F4),
                        inactiveFillColor: Color(0xFFF4F4F4),
                        inactiveColor: Color(0xFFD2D2D2),
                        inactiveBorderWidth: 1,
                        selectedBorderWidth: 1.5,
                        activeBorderWidth: 1.5,
                      ),
                      textStyle: TextStyle(
                        fontFamily: "lexend",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.black,
                      enableActiveFill: true,
                      keyboardType: TextInputType.numberWithOptions(),
                      textInputAction: (Platform.isAndroid)
                          ? TextInputAction.none
                          : TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                      enablePinAutofill: true,
                      useExternalAutoFillGroup: true,
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),
                    SizedBox(height: 24),
                    Consumer<LoginWithMobileProvider>(builder: (context, value, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isOtpValid ? _verifyOtp : null,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: primarycolor,
                            disabledBackgroundColor: primarycolor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                4,
                              ), // Rounded corners
                            ), // Padding
                          ),
                          child:value.isLoading

                          ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        )
                            :
                        const Text(
                        'Verify OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )));
                    },

                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            )



    );
  }
}
