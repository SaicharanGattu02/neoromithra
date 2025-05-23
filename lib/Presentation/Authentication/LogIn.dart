import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Components/CustomSnackBar.dart';
import 'package:neuromithra/services/AuthService.dart';
import 'package:provider/provider.dart';
import '../../Providers/SignInProviders.dart';
import '../../services/Preferances.dart';
import '../../utils/Color_Constants.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String fcmToken = await PreferenceService().getString("fbstoken") ?? "iaeuhfipeurghekg";
      final Map<String, dynamic> data = {
        "username": _emailController.text,
        "password": _passwordController.text,
        "fcm_token": fcmToken,
      };
      var res = await Provider.of<SignInProviders>(context, listen: false).logInWithUsername(data);
      if(res?.status ==true){
       AuthService.saveTokens(res?.accessToken??"", res?.refreshToken??"", res?.expiresIn??0);
       context.go("/main_dashBoard?initialIndex=0");
      }else{
        CustomSnackBar.show(context, "${res?.message}");
      }
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filled(
              icon: Icon(Icons.arrow_back, color: primarycolor),
              onPressed: () => context.pop(),
              style: IconButton.styleFrom(
                backgroundColor: Color(0xFFECFAFA),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: _buildSkipButton(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: width * 0.06),
            _buildLogo(),
            SizedBox(height: width * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style:TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: "general_sans",
                      )
                    ),
                    SizedBox(height: height * 0.03),
                    _buildUsernameField(),
                    SizedBox(height: height * 0.01),
                    _buildPasswordField(),
                    SizedBox(height: height * 0.04),
                    _buildSignInButton(),
                    SizedBox(height: height * 0.03),
                    _buildSignUpLink(),
                    SizedBox(height: height * 0.02),
                    _buildForgotPasswordLink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: () =>
            context.pushReplacement('/main_dashBoard?initialIndex=0'),
        style: OutlinedButton.styleFrom(
          foregroundColor: primarycolor,
          side: BorderSide(color: primarycolor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: ClipOval(
        child: Image.asset(
          "assets/applogo.jpeg",
          height: 120,
          width: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Username",
          style: TextStyle(
            color: charcoal,
            fontSize: 16,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          cursorColor: charcoal,
          focusNode: _focusNodeEmail,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: charcoal,
            fontFamily: "general_sans",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "Enter your username or email",
            hintStyle: TextStyle(
              color: neutral_gray.withOpacity(0.6),
              fontFamily: "general_sans",
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16,),
            prefixIcon: Icon(
              Icons.person_outline,
              color: neutral_gray,
              size: 24,
            ),
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
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username or email';
            }
            if (value.contains('@')) {
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            } else {
              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'Please enter a valid 10-digit mobile number';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
            color: charcoal,
            fontSize: 16,
            fontFamily: "general_sans",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          cursorColor: charcoal,
          focusNode: _focusNodePassword,
          obscureText: !_isPasswordVisible,
          style: const TextStyle(
            color: charcoal,
            fontFamily: "general_sans",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "Enter your password",
            hintStyle: TextStyle(
              color: neutral_gray.withOpacity(0.6),
              fontFamily: "general_sans",
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16,),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: neutral_gray,
              size: 24,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: neutral_gray,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primarycolor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primarycolor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontFamily: "general_sans",
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: login,
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
        child: Consumer<SignInProviders>(
          builder: (context, signIn, child) {
            return signIn.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "general_sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(
            fontSize: 14,
            color: neutral_gray,
            fontFamily: "general_sans",
          ),
          children: [
            TextSpan(
              text: 'Sign Up',
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
                  context.push('/register');
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          context.push('/forgot_password');
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 14,
            color: primarycolor,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationColor: primarycolor.withOpacity(0.5),
            fontFamily: "general_sans",
          ),
        ),
      ),
    );
  }
}
