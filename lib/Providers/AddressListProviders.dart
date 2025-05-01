import 'package:flutter/material.dart';
import '../Model/AddressListModel.dart';
import '../services/userapi.dart';

class AddressListProvider with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  List<Address> _addresses = [];

  // Getters
  bool get isLoading => _isLoading;
  String get error => _error;
  List<Address> get addresses => _addresses;

  Future<void> getAddressList() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await Userapi.getAddressList();
      if (response != null && response.status == true) {
        _addresses = response.address ?? [];
      } else {
        // _error = response?.message ?? 'Failed to fetch addresses';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = '';
    notifyListeners();
  }
}