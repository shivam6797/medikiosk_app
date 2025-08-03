import 'package:equatable/equatable.dart';
import '../data/models/booking_model.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBookings extends BookingEvent {}

class AddBooking extends BookingEvent {
  final BookingModel booking;

  AddBooking(this.booking);

  @override
  List<Object?> get props => [booking];
}

class DeleteBooking extends BookingEvent {
  final int index;

  DeleteBooking(this.index);

  @override
  List<Object?> get props => [index];
}

class ClearBookings extends BookingEvent {}
