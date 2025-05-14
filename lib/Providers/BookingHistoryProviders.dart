import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SuccessModel.dart';

import '../Model/BookingHistoryModel.dart';
import '../services/userapi.dart';

import 'package:flutter/foundation.dart';

class BookingHistoryProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isSubmitting = false;
  int _price = 800;
  List<BookingHistory> _bookingHistory = [];

  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;
  int get price => _price;
  List<BookingHistory> get bookingHistory => _bookingHistory;

  /// Updates price based on selected days
  void updatePriceByDays(int days, {int ratePerDay = 800}) {
    _price = days * ratePerDay;
    notifyListeners();
  }

  /// Fetches the user's booking history
  Future<void> getBookingHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Userapi.getBookingHistory();
      if (response != null && response.status == true) {
        _bookingHistory = response.bookingHistory ?? [];
      } else {
        _bookingHistory = [];
        if (kDebugMode) {
          print('No booking history or error in response');
        }
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error fetching booking history: $e');
        print(stacktrace);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Submits a new appointment booking
  Future<SuccessModel?> bookAppointment(Map<String, dynamic> data) async {
    _isSubmitting = true;
    notifyListeners();

    try {
      final response = await Userapi.bookAppointment(data);
      if (response != null && response.status == true) {
        return response;
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('Error booking appointment: $e');
        print(stacktrace);
      }
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }

    return null;
  }
}

