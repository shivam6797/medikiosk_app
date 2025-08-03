import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:hive/hive.dart';
import '../models/booking_model.dart';

class BookingLocalService {
  static const _boxName = 'bookingBox';

  Future<void> init() async {
    debugPrint("📦 BookingLocalService init started...");
    await Hive.openBox<BookingModel>(_boxName);
    debugPrint("📦 Hive box '$_boxName' opened");
  }

  Future<void> addBooking(BookingModel booking) async {
    final box = Hive.box<BookingModel>(_boxName);
    await box.add(booking);
    debugPrint("✅ Booking added: ${booking.doctorName}, Slot: ${booking.slotTime}");
  }

  List<BookingModel> getAllBookings() {
    final box = Hive.box<BookingModel>(_boxName);
    final bookings = box.values.toList();
    debugPrint("📋 Fetched bookings count: ${bookings.length}");
    return bookings;
  }

  Future<void> deleteBooking(int index) async {
    final box = Hive.box<BookingModel>(_boxName);
    await box.deleteAt(index);
    debugPrint("🗑️ Booking deleted at index: $index");
  }

  Future<void> clearAllBookings() async {
    final box = Hive.box<BookingModel>(_boxName);
    await box.clear();
    debugPrint("🧹 All bookings cleared");
  }
}
