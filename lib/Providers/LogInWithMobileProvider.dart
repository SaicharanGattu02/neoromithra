import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Components/CustomSnackBar.dart';
import '../services/AuthService.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class LoginWithMobileProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<bool> LogInWithMobileProvider(BuildContext context, data) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final registerResponse = await Userapi.postLoginWithMobile(data);
      if (registerResponse != null && registerResponse.status == true) {
        CustomSnackBar.show(
          context,
          registerResponse.message ?? "",
        );
        return true;
      } else {
        CustomSnackBar.show(
          context,
          registerResponse?.message ?? "Registration failed",
        );
        return false;
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      if (context.mounted) {
        CustomSnackBar.show(
          context,
          _errorMessage!,
        );
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> VerifyOtp(BuildContext context, data) async {
    print('Data:${data}');
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final loginResponse = await Userapi.verifyOtp(data);
      if (loginResponse != null) {
        if (loginResponse.containsKey("access_token")) {
          await _handleSuccessfulLogin(loginResponse);
          if (context.mounted) {
            CustomSnackBar.show(
              context,
              "You are logged in successfully",
            );
            context.pushReplacement('/main_dashBoard?initialIndex=${0}');
          }
        } else if (loginResponse.containsKey("error")) {
          _errorMessage = loginResponse["error"];
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _errorMessage!,
                  style:
                      TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
                ),
                duration: Duration(seconds: 1),
                backgroundColor: Color(0xFF32657B),
              ),
            );
          }
        } else {
          if (context.mounted) {
            CustomSnackBar.show(
              context,
              "An unexpected error occurred. Please try again.",
            );
          }
        }
      } else {
        _errorMessage = "Login request failed. Please try again.";
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _errorMessage!,
                style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Color(0xFF32657B),
            ),
          );
        }
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _errorMessage!,
              style: TextStyle(color: Color(0xFFFFFFFF), fontFamily: "Inter"),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xFF32657B),
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _handleSuccessfulLogin(
      Map<String, dynamic> loginResponse) async {
    PreferenceService()
        .saveString("token", loginResponse["access_token"] ?? "");
    final expiryTimestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000 +
            loginResponse["expires_in"])
        .toString();
    PreferenceService().saveString("access_expiry_timestamp", expiryTimestamp);

    await AuthService.saveTokens(
      loginResponse["access_token"],
      loginResponse["access_token"],
      DateTime.now().millisecondsSinceEpoch ~/ 1000 +
          int.parse(loginResponse["expires_in"].toString()),
    );
  }
}
