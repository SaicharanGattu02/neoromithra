import 'package:flutter/cupertino.dart';

import '../Model/BookingHistoryModel.dart';
import '../services/userapi.dart';

class BookingHistoryProviders with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  List <BookingHistory> _bookingHistory = [];
  bool get isLoading => _isLoading;
  String get error => _error;
  List<BookingHistory> get bookingHistory => _bookingHistory;

  Future<void> GetBookingHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Userapi.getBookingHistory();
      if (response != null && response.status == true) {
        _bookingHistory = response.bookingHistory ?? [];
      } else {
        // _error = response['error'] ?? 'Failed to fetch booking history';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
