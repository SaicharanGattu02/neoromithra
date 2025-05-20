import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Presentation/Authentication/LogIn.dart';
import 'package:neuromithra/Providers/RegisterProvider.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomSnackBar.dart';
import '../../services/AuthService.dart';
import '../../utils/Color_Constants.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobilenumberController = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodemobile = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeName.dispose();
    _focusNodemobile.dispose();
    super.dispose();
  }

  Future<void> RegisterApi() async {
    String fcmToken = await PreferenceService().getString("fbstoken") ?? "";
    Map<String, dynamic> data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "contact": _mobilenumberController.text,
      "fcm_token": fcmToken,
    };
    var res = await Provider.of<RegisterProvider>(context, listen: false).register(data);
    if(res?.status ==true){
      AuthService.saveTokens(res?.accessToken??"", res?.refreshToken??"", res?.expiresIn??0);
      context.go("/main_dashBoard?initialIndex=0");
    }else{
      CustomSnackBar.show(context,"${res?.message}");
    }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: ClipOval(
              child: Image.asset(
                "assets/applogo.jpeg",
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Text(
              "Register",
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontFamily: "general_sans",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 11),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontFamily: "general_sans",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.black,
                      focusNode: _focusNodeName,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        hintText: "Enter Your name",
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Normal border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Focused border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontFamily: "general_sans",
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 5), // Adjust padding
                          child: Icon(
                            Icons.account_circle_outlined,
                            color: Color(0xff1E293B),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                      },
                    ),
                    SizedBox(height: 11),
                    Text(
                      "Email Address",
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontFamily: "general_sans",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      focusNode: _focusNodeEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Normal border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Focused border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
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
                            color: Color(0xff1E293B),
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
                    SizedBox(height: 11),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontFamily: "general_sans",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      focusNode: _focusNodePassword,
                      obscureText: !_isPasswordVisible,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        hintText: "Enter Your Password",
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Normal border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Focused border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontFamily: "general_sans",
                        ),
                        // Lock icon at the start
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 5), // Adjust padding
                          child: Icon(
                            Icons.lock_outline, // Lock symbol
                            color: Color(0xff1E293B),
                          ),
                        ),

                        // Visibility toggle at the end
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xffAFAFAF),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 11),
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontFamily: "general_sans",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _mobilenumberController,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "general_sans",
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.black,
                      focusNode: _focusNodemobile,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        hintText: "Enter your mobile number",
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Normal border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ), // Focused border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontFamily: "general_sans",
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 5), // Adjust padding
                          child: Icon(
                            Icons.phone, // Lock symbol
                            color: Color(0xff1E293B),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Consumer<RegisterProvider>(
                      builder: (context, register, child) {
                        return SizedBox(
                          width: width,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primarycolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                if(!register.isLoading){
                                  RegisterApi();
                                }
                              }
                            },
                            child: register.isLoading
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "general_sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 28),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "general_sans",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.push('/login');
                          },
                          child: Text(
                            ' Sign In',
                            style: TextStyle(
                              color: Color(0xff4949C9),
                              fontFamily: "general_sans",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
