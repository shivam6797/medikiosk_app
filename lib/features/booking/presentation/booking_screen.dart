import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/app/app_routes.dart';
import 'package:medikiosk_app/core/widget/inactivity_wrapper.dart';
import 'package:medikiosk_app/features/doctor/bloc/doctor_bloc.dart';
import 'package:medikiosk_app/features/doctor/bloc/doctor_event.dart';
import 'package:medikiosk_app/features/doctor/bloc/doctor_state.dart';
import 'package:medikiosk_app/features/doctor/data/models/doctor_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorBloc>().add(LoadDoctors());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InactivityWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Book Appointment'),
          // backgroundColor: theme.primaryColor,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<DoctorBloc, DoctorState>(
            builder: (context, state) {
              if (state is DoctorLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DoctorLoaded) {
                final onlineDoctors = state.doctors
                    .where((doc) => doc.isOnline)
                    .toList();

                if (onlineDoctors.isEmpty) {
                  return Center(
                    child: Text(
                      'No doctors available now.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: onlineDoctors.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doctor = onlineDoctors[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.slotSelection,
                          arguments: doctor,
                        );
                      },
                      child: DoctorCard(doctor: doctor),
                    );
                  },
                );
              } else if (state is DoctorError) {
                return Center(
                  child: Text(state.message, style: theme.textTheme.bodyMedium),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: doctor.isOnline ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: doctor.isOnline
                    ? theme.primaryColor.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                child: Icon(
                  Icons.person_outline,
                  size: 28,
                  color: doctor.isOnline ? theme.primaryColor : Colors.red,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialization,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: doctor.isOnline ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: doctor.isOnline
                        ? Colors.green.withOpacity(0.15)
                        : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    doctor.isOnline ? 'Available Now' : 'Currently Offline',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: doctor.isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
