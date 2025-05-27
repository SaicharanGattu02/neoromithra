import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Components/CustomSnackBar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../../Providers/SignInProviders.dart';
import '../../utils/Color_Constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  bool _isCodeSent = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = false;

  bool sendResetCode = false;
  bool resetPassword = false;

  String validateOTP = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body:
          Consumer<SignInProviders>(builder: (context, signInProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                SizedBox(height: 20),
                // Email Field
                if (!_isCodeSent) ...[
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Colors.black,
                      fontFamily: "general_sans",
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        height: 1.2,
                        color: Color(0xffAFAFAF),
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Color(0xffF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primarycolor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primarycolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: "general_sans",
                      ),
                      // Always visible email icon at the start
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 5), // Adjust padding
                        child: Icon(
                          Icons.email_outlined,
                          color: Color(0xff4B5563),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primarycolor,
                          foregroundColor: primarycolor,
                          disabledForegroundColor: primarycolor,
                          disabledBackgroundColor: primarycolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: signInProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                var res = await signInProvider
                                    .forgetPassword(_emailController.text);
                                if (res?.status == true) {
                                  setState(() {
                                    _isCodeSent = true;
                                  });
                                  CustomSnackBar.show(
                                      context, "${res?.message}");
                                } else {
                                  CustomSnackBar.show(
                                      context, "${res?.message}");
                                }
                              }
                            },
                      child: signInProvider.isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            )
                          : Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "general_sans",
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                ] else ...[
                  Text("Enter OTP ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "general_sans",
                          color: Colors.black,
                          fontSize: 17)),
                  SizedBox(
                    width: double.infinity,
                    child: PinCodeTextField(
                      autoUnfocus: true,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      blinkWhenObscuring: true,
                      autoFocus: true,
                      autoDismissKeyboard: false,
                      showCursor: true,
                      animationType: AnimationType.fade,
                      focusNode: _otpFocusNode,
                      hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                      controller: _otpController,
                      onTap: () {},
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 48,
                        fieldWidth: 48,
                        fieldOuterPadding: EdgeInsets.only(left: 0, right: 0),
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
                        fontFamily: "general_sans",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.black,
                      enableActiveFill: true,
                      keyboardType: TextInputType.numberWithOptions(),
                      textInputAction: (!kIsWeb && Platform.isAndroid)
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
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "general_sans",
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        height: 1.2,
                        color: Color(0xffAFAFAF),
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        height: 1.2,
                        color: Colors.black,
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Color(0xffF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primarycolor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primarycolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: "general_sans",
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "general_sans",
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        height: 1.2,
                        color: Color(0xffAFAFAF),
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        height: 1.2,
                        color: Colors.black,
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Color(0xffF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primarycolor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primarycolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: "general_sans",
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primarycolor,
                          foregroundColor: primarycolor,
                          disabledForegroundColor: primarycolor,
                          disabledBackgroundColor: primarycolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: signInProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                // Basic OTP length check
                                if (_otpController.text.trim().isEmpty ||
                                    _otpController.text.length < 6) {
                                  CustomSnackBar.show(context,
                                      "Please Enter a valid 6-digit OTP");
                                  return;
                                }
                                Map<String, dynamic> data = {
                                  "email": _emailController.text.trim(),
                                  "Otp": _otpController.text.trim(),
                                  "password": _confirmPasswordController.text,
                                };

                                var res =
                                    await signInProvider.forgetOTPVerify(data);

                                if (res?.status == true) {
                                  CustomSnackBar.show(
                                      context, "${res?.message}");
                                  context.pop();
                                } else {
                                  CustomSnackBar.show(
                                      context, "${res?.message}");
                                }
                              }
                            },
                      child: signInProvider.isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'RESET PASSWORD',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "general_sans",
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
