import 'package:flutter/cupertino.dart';

import '../Components/CustomSnackBar.dart';
import '../Model/ProfileDetailsModel.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class HomeProviders with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  String _quote = '';
  bool _status = false;

  // Getters
  bool get isLoading => _isLoading;
  String get error => _error;
  String get quote => _quote;

  bool get status => _status;



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

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
