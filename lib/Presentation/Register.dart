import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Presentation/LogIn.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';

import '../utils/Color_Constants.dart';

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
  TextEditingController _sosNumberController = TextEditingController();

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

  Future<void> Register() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String pwd = _passwordController.text;

    setState(() {
      _loading = true;
    });

    String? fcm_token = await FirebaseMessaging.instance.getToken();

    if (fcm_token != null && fcm_token.isNotEmpty) {
      final registerResponse = await Userapi.postRegister(
        name,
        email,
        pwd,
        _mobilenumberController.text,
        fcm_token,
        _sosNumberController.text
      );

      setState(() {
        _loading = false;
      });

      if (registerResponse != null && registerResponse.status==true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            registerResponse.message??"",
            style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF32657B),
        ));

        context.push('/login');
      } else {
        debugPrint("registerrr: ${registerResponse?.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            registerResponse?.message ?? "Registration failed",
            style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF32657B),
        ));
      }
    } else {
      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Failed to retrieve FCM token. Please try again.",
          style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF32657B),
      ));
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(
              child: Image.asset(
                "assets/neuromitralogo.png",
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        " Register ",
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontFamily: "Inter",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 11),
                    Text(
                      "Name",
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      cursorColor: Colors.black,
                      focusNode: _focusNodeName,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Your name",
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
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 5), // Adjust padding
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
                        fontFamily: "Inter",
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
                        fillColor: Color(0xffF3F4F6),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:   BorderSide(width: 1, color: Color(0xff14B8A6)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),

                        // Always visible email icon at the start
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 5), // Adjust padding
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
                        fontFamily: "Inter",
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
                        fillColor: Color(0xffF3F4F6),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:   BorderSide(width: 1, color: Color(0xff14B8A6)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),

                        // Lock icon at the start
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 5), // Adjust padding
                          child: Icon(
                            Icons.lock_outline, // Lock symbol
                            color: Color(0xff1E293B),
                          ),
                        ),

                        // Visibility toggle at the end
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
                        fontFamily: "Inter",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _mobilenumberController,
                      cursorColor: Colors.black,
                      focusNode: _focusNodemobile,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        hintText: "Enter your mobile number",
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
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xff14B8A6)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 5), // Adjust padding
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
                    SizedBox(height: 11),
              Text(
                "SoS Mobile Number",
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontFamily: "Inter",

                  fontSize: 13,
                  fontWeight: FontWeight.w400,


              ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _sosNumberController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        hintText: "Enter your SOS mobile number",
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
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 5), // Adjust padding
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

                    InkWell(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Register();
                        }
                      },
                      child: Container(
                        width: width,
                        height: 56,
                        decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _loading
                              ? CircularProgressIndicator(
                            color: Color(0xFFFFFFFF),
                          )
                              : Row(
                            mainAxisSize: MainAxisSize.min, // To keep the row centered
                            children: [
                              Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 28), // Space between text and icon
                              Icon(
                                Icons.arrow_forward, // Your preferred suffix icon
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        InkWell(
                          onTap: () {
                            context.push('/login');
                          },
                          child: Text(
                            ' Sign In',
                            style: TextStyle(
                              color:Color(0xff4949C9),
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
    );
  }
}
