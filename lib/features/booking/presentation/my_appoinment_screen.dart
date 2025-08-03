import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/core/widget/inactivity_wrapper.dart';
import 'package:medikiosk_app/features/booking/bloc/booking_bloc.dart';
import 'package:medikiosk_app/features/booking/bloc/booking_event.dart';
import 'package:medikiosk_app/features/booking/bloc/booking_state.dart';
import 'package:medikiosk_app/features/booking/data/models/booking_model.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(LoadBookings());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InactivityWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('My Appointments'),
          centerTitle: true,
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingLoaded) {
              final bookings = state.bookings;

              if (bookings.isEmpty) {
                return Center(
                  child: Text(
                    'You have no appointments yet.',
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: bookings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return AppointmentCard(booking: booking);
                },
              );
            } else if (state is BookingError) {
              return Center(
                child: Text(
                  state.message,
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}


class AppointmentCard extends StatelessWidget {
  final BookingModel booking;

  const AppointmentCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final formattedTime = DateFormat('hh:mm a').format(booking.slotTime);
    final formattedDate = DateFormat('dd MMM yyyy').format(booking.slotTime);

    return Card(
      elevation: 3,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Profile icon
            CircleAvatar(
              radius: 28,
              backgroundColor: theme.primaryColor.withOpacity(0.15),
              child: Icon(
                Icons.person_outline,
                color: theme.primaryColor,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            // 📋 Details section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.doctorName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Patient: ${booking.patientName}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: theme.iconTheme.color?.withOpacity(0.6)),
                      const SizedBox(width: 4),
                      Text(
                        '$formattedTime | $formattedDate',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🗑️ Delete icon
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                final bookingBloc = context.read<BookingBloc>();
                final index = bookingBloc.repository.getAllBookings().indexOf(booking);
                bookingBloc.add(DeleteBooking(index));
              },
            ),
          ],
        ),
      ),
    );
  }
}

