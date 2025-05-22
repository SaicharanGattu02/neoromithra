import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Components/CustomSnackBar.dart';
import 'package:neuromithra/Model/SignInModel.dart';
import 'package:neuromithra/Model/SuccessModel.dart';
import '../Presentation/MainDashBoard.dart';
import '../services/AuthService.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class SignInProviders with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<SignInModel?> logInWithUsername(Map<String, dynamic> data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await Userapi.loginWithUsername(data);
      if (response?.status == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint("Login error: $e");
      _errorMessage = "Something went wrong. Please try again.";
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<SuccessModel?> logInWithMobile(Map<String, dynamic> data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await Userapi.loginWithMobile(data);
      if (response?.status == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint("Login error: $e");
      _errorMessage = "Something went wrong. Please try again.";
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<SignInModel?> verifyOtp(Map<String, dynamic> data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await Userapi.verifyOtp(data);
      if (response?.status == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint("Login error: $e");
      _errorMessage = "Something went wrong. Please try again.";
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

