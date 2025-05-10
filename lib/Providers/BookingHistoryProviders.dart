import 'package:flutter/cupertino.dart';
import 'package:neuromithra/Model/SuccessModel.dart';

import '../Model/BookingHistoryModel.dart';
import '../services/userapi.dart';

class BookingHistoryProviders with ChangeNotifier {
  bool _isLoading = false;
  List <BookingHistory> _bookingHistory = [];
  bool get isLoading => _isLoading;
  List<BookingHistory> get bookingHistory => _bookingHistory;

  int price = 800;

  void updatePriceByDays(int days, {int ratePerDay = 800}) {
    price = days * ratePerDay;
    notifyListeners();
  }


  Future<void> GetBookingHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Userapi.getBookingHistory();
      if (response != null && response.status == true) {
        _bookingHistory = response.bookingHistory ?? [];
      } else {
      }
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<SuccessModel?> CreateBooking(Map<String,dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Userapi.createBooking(data);
      if (response != null && response.status == true) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
