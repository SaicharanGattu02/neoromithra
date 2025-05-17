import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SuccessModel.dart';
import '../Components/CustomSnackBar.dart';
import '../Model/CounsellingsListModel.dart';
import '../Model/ProfileDetailsModel.dart';
import '../Model/ServiceDetailsModel.dart';
import '../Model/TherapiesListModel.dart';
import '../Model/UpcomingAppointmentsModel.dart';
import '../services/Preferances.dart';
import '../services/userapi.dart';

class HomeProviders with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  String _quote = '';
  bool _status = false;

  List<TherapiesList> _therapieslist = [];
  ServiceModel? _serviceDetails;
  List<CounsellingsList> _counsellingslist = [];
  List<UpcomingAppointments> _upcomingAppointments=[];

  // Getters
  bool get isLoading => _isLoading;
  String get error => _error;
  String get quote => _quote;
  bool get status => _status;
  List<TherapiesList> get therapieslist => _therapieslist;
  ServiceModel? get serviceDetails => _serviceDetails;
  List<CounsellingsList> get counsellingslist => _counsellingslist;
  List<UpcomingAppointments> get upcomingAppointments=> _upcomingAppointments;

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

  Future<SuccessModel?> postHealthFeedBack(String msg) async {
    _setLoading(true);
    try {
      final res = await Userapi.postHealthFeedback(msg);
      if (res?.status == true) {
        return res;
      }else{
        return res;
      }
    } catch (e) {
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<void> getTherapiesList() async {
    _setLoading(true);
    try {
      final response = await Userapi.getTherapiesList();
      if (response?.status == true) {
        _therapieslist = response?.data?.therapiesList ?? [];
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to fetch therapies: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getUpcomingAppointment() async {
    _setLoading(true);
    try {
      final response = await Userapi.getUpcomingAppointment();
      if (response?.status == true) {
        _upcomingAppointments = response?.upcomingAppointments ?? [];
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to fetch appointment: $e');
    } finally {
      _setLoading(false);
    }
  }



  Future<void> getServiceDetails(String id) async {
    _setLoading(true);
    try {
      final response = await Userapi.getServiceDetails(id);
      if (response != null) {
        _serviceDetails = response;
        notifyListeners();
      } else {
        _setError('No data found');
      }
    } catch (e) {
      _setError('Failed to fetch service details: $e');
    } finally {
      _setLoading(false);
    }
  }


  Future<void> getCounsellingsList() async {
    _setLoading(true);
    try {
      final response = await Userapi.getCounsellingsList();
      if (response?.status == true) {
        _counsellingslist = response?.data?.counsellingsList ?? [];
        notifyListeners();
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
