import 'package:flutter/material.dart';
import 'package:neuromithra/Model/SuccessModel.dart';
import '../Model/AddressDetailsResponse.dart';
import '../Model/AddressListModel.dart';
import '../services/userapi.dart';

import 'package:flutter/foundation.dart';

class AddressListProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Address> _addresses = [];
  AddressDetails? _addressDetails;

  bool get isLoading => _isLoading;
  List<Address> get addresses => List.unmodifiable(_addresses); // prevents external modification
  AddressDetails? get addressesDetails => _addressDetails; // prevents external modification

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getAddressList() async {
    _setLoading(true);
    try {
      final response = await Userapi.getAddressList();
      if (response?.status == true) {
        _addresses = response?.data ?? [];
      } else {
        debugPrint("Failed to fetch addresses");
        _addresses = [];
      }
    } catch (e) {
      debugPrint("Exception in getAddressList: $e");
      _addresses = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getAddressDetails(id) async {
    print("id:   ergseljgsl;gmlsekgmslkegmsel; ${id}");
    _setLoading(true);
    try {
      final response = await Userapi.getAddressDetails(id);
      if (response?.status == true) {
        _addressDetails = response?.data;
      } else {
        debugPrint("Failed to fetch addresses");
        _addressDetails = response?.data;
      }
    } catch (e) {
      debugPrint("Exception in getAddressDetails: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<SuccessModel?> addAddress(Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      final res = await Userapi.addAddressApi(data);
      if (res?.status == true) {
        await getAddressList();
        return res;
      } else {
        debugPrint("Add address failed: ${res?.message}");
        return res;
      }
    } catch (e) {
      debugPrint("Exception in addAddress: $e");
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<SuccessModel?> editAddress(Map<String, dynamic> data, dynamic id) async {
    _setLoading(true);
    try {
      final res = await Userapi.editAddressApi(data, id);
      if (res?.status == true) {
        await getAddressList();
        return res;
      } else {
        debugPrint("Edit address failed: ${res?.message}");
        return res;
      }
    } catch (e) {
      debugPrint("Exception in editAddress: $e");
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<SuccessModel?> deleteAddress(int id) async {
    _setLoading(true);
    try {
      final res = await Userapi.deleteAddressApi(id);
      if (res?.status == true) {
        await getAddressList();
        return res;
      } else {
        debugPrint("deleteAddress address failed: ${res?.message}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception in deleteAddress: $e");
      return null;
    } finally {
      _setLoading(false);
    }
  }
}

