import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/app/app_routes.dart';
import 'package:medikiosk_app/core/widget/inactivity_wrapper.dart';
import 'package:medikiosk_app/features/booking/bloc/booking_bloc.dart';
import 'package:medikiosk_app/features/booking/bloc/booking_event.dart';
import 'package:medikiosk_app/features/booking/data/models/booking_model.dart';
import 'package:medikiosk_app/features/doctor/data/models/doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlotSelectionScreen extends StatefulWidget {
  const SlotSelectionScreen({super.key});

  @override
  State<SlotSelectionScreen> createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends State<SlotSelectionScreen> {
  late DoctorModel doctor;
  bool isDoctorLoaded = false;
  int? selectedSlotIndex;

  final List<String> availableSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:30 PM",
    "2:00 PM",
    "3:30 PM",
    "5:00 PM",
    "6:30 PM",
  ];

  DateTime parseSlotTime(String timeString) {
    final now = DateTime.now();
    final parts = timeString.split(" ");
    final hourMin = parts[0].split(":");
    int hour = int.parse(hourMin[0]);
    int minute = int.parse(hourMin[1]);
    final isPM = parts[1] == "PM";

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isDoctorLoaded) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is DoctorModel) {
        doctor = args;
        isDoctorLoaded = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return InactivityWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Select Slot for ${doctor.name}'),
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: theme.primaryColor.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: theme.primaryColor,
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
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                "Available Slots",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: availableSlots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final slot = availableSlots[index];
                    final isSelected = selectedSlotIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSlotIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.primaryColor
                              : theme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? theme.primaryColor
                                : theme.dividerColor,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          slot,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : theme.textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: selectedSlotIndex == null
                    ? null
                    : () async {
                        final selectedSlot = availableSlots[selectedSlotIndex!];
                        final parsedTime = parseSlotTime(selectedSlot);

                        final prefs = await SharedPreferences.getInstance();
                        final username =
                            prefs.getString('username') ?? 'Unknown User';

                        final booking = BookingModel(
                          doctorId: doctor.id,
                          doctorName: doctor.name,
                          specialization: doctor.specialization,
                          slotTime: parsedTime,
                          patientName: username,
                        );

                        debugPrint(
                          "📥 Booking Added: ${booking.doctorName}, ${booking.slotTime}",
                        );

                        context.read<BookingBloc>().add(AddBooking(booking));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Slot "$selectedSlot" booked successfully!',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.myAppointmentsScreen,
                          );
                        });
                      },
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
