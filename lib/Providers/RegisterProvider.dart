import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SignInModel.dart';
import '../Model/SuccessModel.dart';
import '../services/userapi.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<SignInModel?> register(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      final registerResponse = await Userapi.postRegister(data);
      if (registerResponse != null && registerResponse.status == true) {
        return registerResponse;
      } else {
        return registerResponse;
      }
    } catch (e) {
      debugPrint("Register error: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

