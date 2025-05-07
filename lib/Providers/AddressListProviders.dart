import 'package:flutter/material.dart';
import '../Model/AddressListModel.dart';
import '../services/userapi.dart';

class AddressListProvider with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  List<Address> _addresses = [];
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
  Future<bool> addAddress(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final res = await Userapi.addAddressApi(data);
      if (res != null && res.status == true) {
        await getAddressList();
        return true;
      } else {
        _error = res?.message ?? 'An error occurred. Please try again.';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> EditAddress(Map<String, dynamic> data,id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final res = await Userapi.editAddressApi(data,id);
      if (res != null && res.status == true) {
        await getAddressList();
        return true;
      } else {
        _error = res?.message ?? 'An error occurred. Please try again.';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
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