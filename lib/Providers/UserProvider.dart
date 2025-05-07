import 'package:flutter/cupertino.dart';

import '../Components/CustomSnackBar.dart';
import '../Model/ProfileDetailsModel.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class UserProviders with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  Users _userData = Users();
  bool _status = false;

  bool get isLoading => _isLoading;
  String get error => _error;
  Users get userData => _userData;
  bool get status => _status;

  Future<void> getProfileDetails() async {
    _isLoading = true;
    notifyListeners();
    try {
      String userId = await PreferenceService().getString('user_id') ?? "";
      final response = await Userapi.getProfileDetails(userId);
      if (response != null) {
        _userData = response.user ?? Users();
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

  Future<void> updateProfileDetails(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await Userapi.postProfileDetails(data);
      if (result != null && result.containsKey("message")) {
        print("Success: ${result["message"]}");
      } else if (result != null && result.containsKey("error")) {
        print("Error: ${result["error"]}");
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
