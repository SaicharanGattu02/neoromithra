import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuromithra/Dashboard.dart';
import 'package:neuromithra/MainDashBoard.dart';
import 'package:neuromithra/Register.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:neuromithra/services/userapi.dart';
import 'ForgotPasswordScreen.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "You are logged in successfully",
            style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF32657B),
        ));
        PreferenceService()
            .saveString("token", loginResponse["access_token"] ?? "");
        PreferenceService().saveString("access_expiry_timestamp",
            (DateTime.now().millisecondsSinceEpoch ~/ 1000 + loginResponse["expires_in"]).toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainDashBoard()),
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
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  "assets/neuromitralogo.png",
                  height: 100,
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 38),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xFF1F2937),
                            fontFamily: "Inter",
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Email Address",
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontFamily: "Inter",
                          fontSize: 13,
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
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontFamily: "Inter",
                          fontSize: 13,
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
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            logIn();
                          }
                        },
                        child: Container(
                          width: width,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xff3EA4D2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: _loading
                                ? CircularProgressIndicator(
                                    color: Color(0xFFFFFFFF),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // To keep the row centered
                                    children: [
                                      Center(
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              28), // Space between text and icon
                                      Icon(
                                        Icons
                                            .arrow_forward, // Your preferred suffix icon
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up.',
                                  style: TextStyle(decoration: TextDecoration.underline,
                                    decorationColor: Color(0xff4949C9),
                                    color: Color(0xff4949C9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Register()),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(decoration: TextDecoration.underline,
                                decorationColor: Color(0xff4949C9).withOpacity(0.5),
                                color: Color(0xff4949C9),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            )),
                      ),
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
