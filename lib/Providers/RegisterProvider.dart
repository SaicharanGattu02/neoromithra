import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Components/CustomSnackBar.dart';

import '../services/userapi.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> Register(BuildContext context, data) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final registerResponse = await Userapi.postRegister(data);
      if (registerResponse != null && registerResponse.status == true) {
        CustomSnackBar.show(
          context,
          registerResponse.message ?? "",
        );
        context.push('/login');
      } else {
        CustomSnackBar.show(
          context,
          registerResponse?.message ?? "Registration failed",
        );
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      if (context.mounted) {
        CustomSnackBar.show(
          context,
          _errorMessage!,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
