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
  User _userData = User();
  bool _status = false;

  List<TherapiesList> _therapieslist = [];
  List<CounsellingsList> _counsellingslist = [];

  // Getters
  bool get isLoading => _isLoading;
  String get error => _error;
  String get quote => _quote;
  User get userData => _userData;
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

  Future<void> getData() async {
    _setLoading(true);
    try {
      await Future.wait([
        getProfileDetails(),
        getQuotes(),
        getTherapiesList(),
        getCounsellingsList()
      ]);
    } catch (e) {
      _setError("Failed to fetch initial data: $e");
    } finally {
      _setLoading(false);
    }
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
        await getProfileDetails();
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

  Future<void> getProfileDetails() async {
    try {
      String userId = await PreferenceService().getString('user_id') ?? "";
      final response = await Userapi.getProfileDetails(userId);
      if (response != null) {
        _userData = response.user ?? User();
        _status = response.healthFeedback?.status ?? false;
        PreferenceService().saveString("user_mobile", _userData.phone.toString());
      } else {
        _setError('Failed to fetch profile details');
      }
    } catch (e) {
      _setError('Profile fetch error: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getTherapiesList() async {
    try {
      final response = await Userapi.getTherapiesList();
      if (response?.status == true) {
        _therapieslist = response!.therapieslist ?? [];
      }
    } catch (e) {
      _setError('Failed to fetch therapies: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getCounsellingsList() async {
    try {
      final response = await Userapi.getCounsellingsList();
      if (response?.status == true) {
        _counsellingslist = response!.counsellingslist ?? [];
      }
    } catch (e) {
      _setError('Failed to fetch counsellings: $e');
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
