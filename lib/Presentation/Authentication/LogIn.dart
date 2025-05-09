import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../Providers/SignInProviders.dart';
import '../../services/Preferances.dart';
import '../../utils/Color_Constants.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  bool _isPasswordVisible = false;

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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String fcmToken = await PreferenceService().getString("fbstoken") ?? "";
      final Map<String, dynamic> data = {
        "username": _emailController.text,
        "password": _passwordController.text,
        "fcm_token": fcmToken,
      };
      Provider.of<SignInProviders>(context, listen: false).logIn(context, data);
    } else {
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return
    Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child:IconButton.filled(
                  icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
                  onPressed: () => context.pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: Color(0xFFECFAFA), // Filled color
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _buildSkipButton(),
              ),
              SizedBox(height: height * 0.06),
              _buildLogo(),
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: charcoal,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      _buildUsernameField(),
                      SizedBox(height: height * 0.03),
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
    return GestureDetector(
      onTap: () => context.pushReplacement('/main_dashBoard?initialIndex=0'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: primarycolor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: primarycolor,
            fontFamily: 'Poppins',
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
        height: 120,
        width: 120,
        fit: BoxFit.contain,
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
            fontFamily: 'Poppins',
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
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "Enter your username or email",
            hintStyle: TextStyle(
              color: neutral_gray.withOpacity(0.6),
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: neutral_gray,
              size: 24,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primarycolor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
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
            fontFamily: 'Poppins',
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
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "Enter your password",
            hintStyle: TextStyle(
              color: neutral_gray.withOpacity(0.6),
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
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
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primarycolor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
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
      height: 56,
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
                    fontFamily: 'Poppins',
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
            fontFamily: 'Poppins',
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
                fontFamily: 'Poppins',
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
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
