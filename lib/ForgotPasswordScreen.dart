import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CustomAppBar.dart';

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
        print("_resetPassword responseBody: ${responseBody}");

        // Check for success message in the response body
        if (responseBody['message'] == 'Password updated successfully.') {
          Navigator.pop(context);
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
        print("_resetPassword responseBody: ${responseBody}");

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
      appBar: CustomAppBar(
        title: 'Forgot Password',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
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
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
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
                        )
                      : Text(
                          'Send Reset Code',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Inter",
                            fontSize: 15,
                          ),
                        ),
                ),
              ] else ...[
                // Code and Password Fields
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Code',
                    border: OutlineInputBorder(),
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
                    border: OutlineInputBorder(),
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
                    border: OutlineInputBorder(),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
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
                            fontFamily: "Inter",
                            fontSize: 15,
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
