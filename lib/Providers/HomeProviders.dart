import 'package:flutter/cupertino.dart';
import '../Components/CustomSnackBar.dart';
import '../Model/CounsellingsListModel.dart';
import '../Model/ProfileDetailsModel.dart';
import '../Model/TherapiesListModel.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class HomeProviders with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  String _quote = '';
  bool _status = false;

  List<TherapiesList> _therapieslist = [];
  List<CounsellingsList> _counsellingslist = [];

  // Getters
  bool get isLoading => _isLoading;
  String get error => _error;
  String get quote => _quote;
  bool get status => _status;
  List<TherapiesList> get therapieslist => _therapieslist;
  List<CounsellingsList> get counsellingslist => _counsellingslist;

  /// Set loading state and notify
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Set error message and notify
  void _setError(String message) {
    _error = message;
    notifyListeners();
  }


  Future<void> getQuotes() async {
    try {
      final res = await Userapi.getQuotes();
      if (res?.quote != null) {
        _quote = res!.quote!;
      } else {
        _setError('No quote received');
      }
    } catch (e) {
      _setError('Error fetching quote: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> postHealthFeedBack(String msg, BuildContext context) async {
    _setLoading(true);
    try {
      final res = await Userapi.postHealthFeedback(msg);
      final message = res?.message ?? "Unknown error";
      if (res?.status == true) {
        CustomSnackBar.show(context, message);
      } else {
        CustomSnackBar.show(context, message);
      }
    } catch (e) {
      _setError('Feedback submission error: $e');
      CustomSnackBar.show(context, "An error occurred");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getTherapiesList() async {
    _setLoading(true);
    try {
      final response = await Userapi.getTherapiesList();
      if (response?.status == true) {
        _therapieslist = response?.therapieslist ?? [];
      }
    } catch (e) {
      _setError('Failed to fetch therapies: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getCounsellingsList() async {
    _setLoading(true);
    try {
      final response = await Userapi.getCounsellingsList();
      if (response?.status == true) {
        _counsellingslist = response?.counsellingslist ?? [];
      }
    } catch (e) {
      _setError('Failed to fetch counsellings: $e');
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
