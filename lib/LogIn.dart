import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuromithra/Dashboard.dart';
import 'package:neuromithra/Register.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }


  Future<void> logIn() async {
    String email = _emailController.text;
    String pwd = _passwordController.text;
    setState(() {
      _loading = true;
    });

    String fcmToken = await PreferenceService().getString("fbstoken") ?? "";
    final loginResponse = await Userapi.postLogin(email, pwd, fcmToken);

    if (loginResponse != null) {
      if (loginResponse.containsKey("access_token")) {
        // Successful login
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "You are logged in successfully",
            style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF32657B),
        ));
        PreferenceService().saveString("token", loginResponse["access_token"] ?? "");
        PreferenceService().saveString("access_expiry_timestamp", loginResponse["expires_in"].toString() ?? "");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else if (loginResponse.containsKey("error")) {
        // Handle unauthorized or error response
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            loginResponse["error"],
            style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF32657B),
        ));
      } else {
        // Handle other unexpected responses
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "An unexpected error occurred. Please try again.",
            style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF32657B),
        ));
      }
    } else {
      // Login request failed
      print("Login failed.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Login request failed. Please try again.",
          style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF32657B),
      ));
    }

    setState(() {
      _loading = false;
    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return false;


      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.3,
                width: width,
                child: Center(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 150,
                    width: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's Login to Your Account",
                        style: TextStyle(
                          color: Color(0xFF32657B),
                          fontFamily: "Inter",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0xFF32657B),
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        focusNode: _focusNodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0,
                            height: 1.2,
                            color: Color(0xffAFAFAF),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffCDE2FB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffCDE2FB)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }

                          // return null;

                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xFF32657B),
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        cursorColor: Colors.black,
                        focusNode: _focusNodePassword,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0,
                            height: 1.2,
                            color: Color(0xffAFAFAF),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffCDE2FB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffCDE2FB)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
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
                      SizedBox(height: height * 0.1),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            logIn();
                          }
                        },
                        child: Container(
                          width: width,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: _loading
                                ? CircularProgressIndicator(
                              color: Color(0xFFFFFFFF),
                            )
                                : Text(
                              "Log In",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Create an account?'),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          ' Register',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
