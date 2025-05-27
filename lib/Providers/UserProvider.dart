import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SuccessModel.dart';

import '../Components/CustomSnackBar.dart';
import '../Model/ProfileDetailsModel.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class UserProviders with ChangeNotifier {
  bool _isLoading = false;
  bool _isSaving = false;
  String _error = '';
  User _userData = User();
  HealthFeedback _healthFeedback = HealthFeedback();
  bool _status = false;

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String get error => _error;
  User get userData => _userData;
  HealthFeedback get healthFeedback => _healthFeedback;
  bool get status => _status;

  Future<void> getProfileDetails() async {
    _isLoading = true;
    notifyListeners();
    try {
      String userId = await PreferenceService().getString('user_id') ?? "";
      final response = await Userapi.getProfileDetails(userId);
      if (response != null) {
        _userData = response.user ?? User();
        _healthFeedback = response.healthFeedback ?? HealthFeedback();
        _status = response.status ?? false;
        PreferenceService()
            .saveString("user_mobile", _userData.contact.toString() ?? "");
      } else {
        _error = 'Failed to fetch profile details';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<SuccessModel?> updateProfileDetails(FormData formData) async {
    _isSaving = true;
    notifyListeners();
    try {
      final result = await Userapi.updateProfileDetails(formData);
      if (result?.status == true) {
        getProfileDetails();
        return result;
      } else {
        return null;
      }
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
