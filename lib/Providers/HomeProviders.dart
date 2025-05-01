import 'package:flutter/cupertino.dart';

import '../Components/CustomSnackBar.dart';
import '../Model/ProfileDetailsModel.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class HomeProviders with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  String _quote = '';
  User _userData = User();
  bool _status = false;

  // Getters
  bool get isLoading => _isLoading;
  String get error => _error;
  String get quote => _quote;
  User get userData => _userData;
  bool get status => _status;

  Future<void> getData() async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.wait([
        getProfileDetails(),
        getQuotes(),
      ]);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getQuotes() async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await Userapi.getQuotes();
      if (res?.quote != null) {
        _quote = res?.quote ?? "";
      } else {
        _error = 'No quote received';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> postHealthFeedBack(String msg, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await Userapi.postHealthFeedback(msg);
      if (res?.status == true) {
        await getProfileDetails();
        CustomSnackBar.show(context, res?.message ?? "Submitted Successfully");
      } else {
        CustomSnackBar.show(context, res?.message ?? "Submission Failed");
      }
    } catch (e) {
      _error = e.toString();
      CustomSnackBar.show(context, "An error occurred");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProfileDetails() async {
    _isLoading = true;
    notifyListeners();
    try {
      String userId = await PreferenceService().getString('user_id') ?? "";
      final response = await Userapi.getProfileDetails(userId);
      if (response != null) {
        _userData = response.user ?? User();
        _status = response.healthFeedback?.status ?? false;
        PreferenceService().saveString("user_mobile", _userData.phone.toString() ?? "");
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

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
