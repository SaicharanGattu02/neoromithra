import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../utils/Color_Constants.dart';
import '../CustomAppBar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isCodeSent = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool sendResetCode = false;
  bool resetPassword = false;

  Future<void> _sendResetCode() async {
    final response = await http.post(
      Uri.parse('https://admin.neuromitra.com/api/forgotpassword'),
      headers: {
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      },
      body: {'email': _emailController.text},
    );
    setState(() {
      if (response.statusCode == 200) {
        sendResetCode = false;
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 'code send') {
          setState(() {
            _isCodeSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Reset code sent to ${_emailController.text}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected response from server')),
          );
        }
      } else {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send reset code')),
          );
        }
        sendResetCode = false;
      }
    });
  }

  Future<void> _resetPassword() async {
    final response = await http.post(
      Uri.parse('https://admin.neuromitra.com/api/reset-password'),
      body: {
        'code': _codeController.text,
        'password': _passwordController.text,
      },
    );
    setState(() {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        debugPrint("_resetPassword responseBody: ${responseBody}");

        // Check for success message in the response body
        if (responseBody['message'] == 'Password updated successfully.') {
          context.pop();
          resetPassword = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset successfully')),
          );
          // Optionally, reset the form or navigate to a different screen
        } else {
          // Handle unexpected success response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Unexpected response: ${responseBody['message']}')),
          );
        }
      } else {
        resetPassword = false;
        // Assuming a 405 error indicates an invalid OTP
        final responseBody = jsonDecode(response.body);
        debugPrint("_resetPassword responseBody: ${responseBody}");

        if (responseBody['message'] == 'Invalid Otp') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid OTP. Please try again.')),
          );
        } else {
          // Handle other 405 errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Failed to reset password: ${responseBody['message']}')),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose of controllers
    _emailController.dispose();
    _codeController.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                      borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primarycolor, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: "general_sans",
                    ),
                    // Always visible email icon at the start
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(left: 10, right: 5), // Adjust padding
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
                // TextFormField(
                //   controller: _emailController,
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your email';
                //     }
                //     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                //       return 'Please enter a valid email address';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primarycolor,
                        foregroundColor: primarycolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (sendResetCode) {
                        } else {
                          setState(() {
                            sendResetCode = true;
                          });
                          _sendResetCode();
                        }
                      }
                    },
                    child: sendResetCode
                        ? CircularProgressIndicator(
                            color: Colors.white,
                      strokeWidth: 1,
                          )
                        : Text(
                            'Send Reset Code',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "general_sans",
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ] else ...[
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Code',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffF3F4F6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xff14B8A6)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffF3F4F6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xff14B8A6)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
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
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffF3F4F6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xff14B8A6)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primarycolor,
                        foregroundColor: primarycolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (resetPassword) {
                        } else {
                          setState(() {
                            resetPassword = true;
                          });
                          _resetPassword();
                        }
                      }
                    },
                    child: resetPassword
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Reset Password',
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
      ),
    );
  }
}
