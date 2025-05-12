import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../Providers/LogInWithMobileProvider.dart';
import '../../utils/Color_Constants.dart';
import '../../utils/media_query_helper.dart';

class LoginWithMobile extends StatefulWidget {
  final String? mobile;
  const LoginWithMobile({this.mobile, Key? key}) : super(key: key);

  @override
  State<LoginWithMobile> createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mobileController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  String _phoneError = '';
  bool _isPhoneValid = false;
  bool _showError = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticIn),
    );
    _validatePhoneNumber(_mobileController.text, updateUI: false);
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        setState(() {
          _showError = true;
          if (_phoneError.isNotEmpty) _animationController.forward(from: 0);
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _mobileController.dispose();
    _phoneFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String value, {bool updateUI = true}) {
    if (value.isEmpty) {
      if (updateUI) {
        setState(() {
          _phoneError = 'Phone number is required';
          _isPhoneValid = false;
        });
      }
      return _phoneError;
    }
    if (value.length < 10) {
      if (updateUI) {
        setState(() {
          _phoneError = 'Please enter a valid 10-digit phone number';
          _isPhoneValid = false;
        });
      }
      return _phoneError;
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      if (updateUI) {
        setState(() {
          _phoneError =
              'Phone number must start with 6-9 and contain only digits';
          _isPhoneValid = false;
        });
      }
      return _phoneError;
    }
    if (updateUI) {
      setState(() {
        _phoneError = '';
        _isPhoneValid = true;
      });
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    setState(() {
      _showError = true;
    });
    final validationResult = _validatePhoneNumber(_mobileController.text);
    if (validationResult == null) {
      _phoneFocusNode.unfocus();
      Map<String, dynamic> data = {"phone": _mobileController.text};
      final res = await Provider.of<LoginWithMobileProvider>(context, listen: false)
          .LogInWithMobileProvider(context, data);
      if (res == true) {
        context.push('/otp?mobile=${_mobileController.text}');
      }
    } else {
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<LoginWithMobileProvider>(
          builder: (context, numProvider, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.06,
                vertical: SizeConfig.screenHeight * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildSkipButton(),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  _buildLogo(),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  _buildHeader(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildPhoneInput(),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  _buildContinueButton(numProvider),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  _buildSignInLink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: () => context.pushReplacement('/main_dashBoard?initialIndex=${0}'),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: primarycolor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: primarycolor,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        "assets/neuromitralogo.png",
        width: SizeConfig.screenWidth * 0.4,
        height: SizeConfig.screenHeight * 0.18,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login with Mobile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
          )
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        Text(
          'Enter your phone number to continue',
          style: TextStyle(
            color: neutral_gray,
            fontSize: 16,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            color: charcoal,
            fontSize: 16,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        TextFormField(
          controller: _mobileController,
          cursorColor: Colors.black,
          focusNode: _phoneFocusNode,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: const TextStyle(
            color: charcoal,
            fontFamily: "general_sans",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Container(padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '+91',
                    style: TextStyle(
                      color: charcoal,
                      fontFamily: "general_sans",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 24,
                    color: light_gray,
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            hintText: 'Enter 10-digit mobile number',
            hintStyle: TextStyle(
              color: neutral_gray.withOpacity(0.6),
              fontFamily: "general_sans",
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: primarycolor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          onFieldSubmitted: (_) => _handleSubmit(),
          onChanged: (value) {
            _debounceTimer?.cancel();
            _debounceTimer = Timer(const Duration(milliseconds: 300), () {
              _validatePhoneNumber(value);
            });
          },
        ),
        if (_showError && _phoneError.isNotEmpty)
          AnimatedBuilder(
            animation: _shakeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_shakeAnimation.value, 0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Semantics(
                    label: _phoneError,
                    child: Text(
                      _phoneError,
                      style: const TextStyle(
                        fontFamily: "general_sans",
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildContinueButton(LoginWithMobileProvider numProvider) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:
            _isPhoneValid && !numProvider.isLoading ? _handleSubmit : null,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: primarycolor,
          disabledBackgroundColor: primarycolor.withOpacity(0.4),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: primarycolor.withOpacity(0.3),
        ),
        child: numProvider.isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "general_sans",
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: 'Have an account? ',
            style: TextStyle(
              fontSize: 14,
              color: neutral_gray,
              fontFamily: "general_sans",
            ),
            children: [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  fontSize: 14,
                  color: primarycolor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: primarycolor,
                  fontFamily: "general_sans",
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.push('/login');
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
