import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SuccessModel.dart';

import '../Model/AppointmentsModel.dart';
import '../Model/PhonepeDetails.dart';
import '../Model/SessionFeedbackModel.dart';
import '../Model/SessionsModel.dart';
import '../services/userapi.dart';

import 'package:flutter/foundation.dart';

class BookingHistoryProvider with ChangeNotifier {
  // Core State
  bool _isLoading = false;
  bool _isSubmitting = false;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  // Pagination tracking
  int _currentPage = 1;

  // Core Data
  int _price = 800;
  List<Appointments> _appointments = [];
  List<Sessions> _sessions = [];
  List<SessionFeedback> _sessionFeedback = [];
  List<PhonepeKeys> _phonpekeys = [];

  // Getters
  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;
  bool get isFetchingMore => _isFetchingMore;
  bool get hasMore => _hasMore;
  int get price => _price;
  List<Appointments> get appointments => _appointments;
  List<Sessions> get sessions => _sessions;
  List<SessionFeedback> get sessionFeedback => _sessionFeedback;
  List<PhonepeKeys> get phonpekeys => _phonpekeys;

  /// 🧮 Update price based on selected days
  void updatePriceByDays(int days, {int ratePerDay = 800}) {
    _price = days * ratePerDay;
    notifyListeners();
  }

  /// 📖 Fetch initial booking history (page 1)
  Future<void> getBookingHistory() async {
    _isLoading = true;
    _currentPage = 1;
    _hasMore = true;
    _appointments = [];
    notifyListeners();

    try {
      final response = await Userapi.getBookingHistory(_currentPage);
      if (response != null && response.status == true) {
        _appointments = response.data?.appointments ?? [];
        final total = response.data?.total ?? 0;
        final perPage = response.data?.perPage ?? _appointments.length;

        _hasMore = _appointments.length < total;
        if (_hasMore) _currentPage++;
      } else {
        _appointments = [];
        _hasMore = false;
        debugPrint('No booking history or error in response');
      }
    } catch (e) {
      debugPrint('Error fetching booking history: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 📜 Fetch more booking history (pagination)
  Future<void> loadMoreBookingHistory() async {
    if (!_hasMore || _isFetchingMore) return;

    _isFetchingMore = true;
    notifyListeners();

    try {
      final response = await Userapi.getBookingHistory(_currentPage);
      if (response != null && response.status == true) {
        final newAppointments = response.data?.appointments ?? [];
        _appointments.addAll(newAppointments);

        final total = response.data?.total ?? 0;
        final perPage = response.data?.perPage ?? newAppointments.length;
        _hasMore = _appointments.length < total;

        if (_hasMore) _currentPage++;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      debugPrint('Error loading more history: $e');
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  /// 🧾 Fetch sessions by assigned ID
  Future<void> getSessionsByID(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Userapi.getSessionsById(id);
      if (response != null && response.status == true) {
        _sessions = response.sessions ?? [];
      } else {
        _sessions = [];
        debugPrint('No sessions or error in response');
      }
    } catch (e) {
      debugPrint('Error fetching sessions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPhonepeDetails() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Userapi.getPhonepeDetails();
      if (response != null && response.status == true) {
        _phonpekeys = response.phonpekeys ?? [];
      } else {
        _phonpekeys = [];
        debugPrint('No _phonpekeys or error in response');
      }
    } catch (e) {
      debugPrint('Error fetching _phonpekeys: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ⭐ Fetch feedback for a session
  Future<void> getSessionFeedback(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Userapi.getSessionTracking(id);
      if (response != null && response.status == true) {
        _sessionFeedback = response.sessionFeedback ?? [];
      } else {
        _sessionFeedback = [];
        debugPrint('No session feedback or error in response');
      }
    } catch (e) {
      debugPrint('Error fetching session feedback: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 📝 Submit appointment booking
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> data) async {
    _isSubmitting = true;
    notifyListeners();

    try {
      final response = await Userapi.bookAppointment(data);
      if (response != null && response.status == true) {
        return response;
      }
    } catch (e) {
      debugPrint('Error booking appointment: $e');
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }

    return null;
  }
}

