import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:medikiosk_app/features/booking/data/local/booking_local_service.dart';
import 'package:medikiosk_app/features/booking/data/models/booking_model.dart';

class BookingRepository {
  final BookingLocalService _localService;

  BookingRepository(this._localService);

  Future<void> addBooking(BookingModel booking) async {
    debugPrint("📥 Repository: Adding booking for ${booking.doctorName}");
    await _localService.addBooking(booking);
  }

  List<BookingModel> getAllBookings() {
    final bookings = _localService.getAllBookings();
    debugPrint("📤 Repository: Total bookings fetched: ${bookings.length}");
    return bookings;
  }

  Future<void> deleteBooking(int index) async {
    debugPrint("🗑️ Repository: Deleting booking at index $index");
    await _localService.deleteBooking(index);
  }

  Future<void> clearBookings() async {
    debugPrint("🧹 Repository: Clearing all bookings");
    await _localService.clearAllBookings();
  }
}
