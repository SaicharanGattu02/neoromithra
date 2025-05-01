import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Providers/SignInProviders.dart';
import 'package:neuromithra/services/Preferances.dart';
import 'package:provider/provider.dart';
import '../utils/Color_Constants.dart';

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
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  Future<void> login() async {
    String fcmToken = await PreferenceService().getString("fbstoken") ?? "";
    final Map<String, dynamic> data = {
      "email": _emailController.text,
      "password": _passwordController.text,
      "fcm_token": fcmToken,
    };
    Provider.of<SignInProviders>(context, listen: false).logIn(context, data);
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
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 90,
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushReplacement('/main_dashBoard?initialIndex=${0}');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary, // Button background color
                          foregroundColor: primary, // Text color
                          elevation: 0, // Shadow elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          overlayColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "lexend"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                            login();
                          }
                        },
                        child: Consumer<SignInProviders>(
                          builder: (context, signIn, child) {
                            return Container(
                              width: width,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Color(0xff3EA4D2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: signIn.isLoading
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
                            );
                          },
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
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xff4949C9),
                                    color: Color(0xff4949C9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push('/register');
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
                              context.push('/forgot_password');
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color(0xff4949C9).withOpacity(0.5),
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
