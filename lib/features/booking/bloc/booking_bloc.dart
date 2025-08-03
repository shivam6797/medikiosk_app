import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/features/booking/data/repository/booking_repository.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;

  BookingBloc({required this.repository}) : super(BookingInitial()) {
    on<LoadBookings>((event, emit) {
      debugPrint("📦 BookingBloc: LoadBookings triggered");
      emit(BookingLoading());

      final bookings = repository.getAllBookings();
      debugPrint("📦 BookingBloc: Loaded ${bookings.length} bookings");
      emit(BookingLoaded(bookings));
    });

    on<AddBooking>((event, emit) async {
      debugPrint("➕ BookingBloc: AddBooking for ${event.booking.doctorName}");
      await repository.addBooking(event.booking);

      final bookings = repository.getAllBookings();
      debugPrint("📦 BookingBloc: Total bookings after add: ${bookings.length}");
      emit(BookingLoaded(bookings));
    });

    on<DeleteBooking>((event, emit) async {
      debugPrint("🗑️ BookingBloc: DeleteBooking at index ${event.index}");
      await repository.deleteBooking(event.index);

      final bookings = repository.getAllBookings();
      emit(BookingLoaded(bookings));
    });

    on<ClearBookings>((event, emit) async {
      debugPrint("🧹 BookingBloc: ClearBookings triggered");
      await repository.clearBookings();

      final bookings = repository.getAllBookings();
      emit(BookingLoaded(bookings));
    });
  }
}
