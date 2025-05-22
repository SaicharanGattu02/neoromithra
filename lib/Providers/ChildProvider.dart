import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SuccessModel.dart';
import '../Model/ChildListModel.dart';
import '../services/userapi.dart';
import 'package:flutter/foundation.dart';

class ChildProvider extends ChangeNotifier {
  List<ChildData> _childDataList = [];
  List<ChildData> _childDetails = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ChildData> get childDataList => _childDataList;
  List<ChildData> get childDetails => _childDetails;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getChildDetails(String id) async {
    _setLoading(true);
    try {
      final response = await Userapi.getChildDetails(id);
      if (response != null && response.childData != null) {
        _childDetails = response.childData?.children??[];
      }
    } catch (e) {
      debugPrint('Error fetching child details: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getChildList() async {
    _setLoading(true);
    try {
      final response = await Userapi.getChildList();
      if (response != null && response.childData != null) {
        _childDataList = response.childData?.children??[];
      }
    } catch (e) {
      debugPrint('Error fetching child list: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<SuccessModel?> addChild(Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      final response = await Userapi.addChild(data);
      return response?.status == true ? response : null;
    } catch (e) {
      debugPrint('Error adding child: $e');
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<SuccessModel?> editChild(Map<String, dynamic> data, String id) async {
    _setLoading(true);
    try {
      final response = await Userapi.editChild(data, id);
      return response?.status == true ? response : null;
    } catch (e) {
      debugPrint('Error editing child: $e');
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<SuccessModel?> deleteChild(String id) async {
    _setLoading(true);
    try {
      final response = await Userapi.deleteChild(id);
      return response?.status == true ? response : null;
    } catch (e) {
      debugPrint('Error deleting child: $e');
    } finally {
      _setLoading(false);
    }
    return null;
  }
}

