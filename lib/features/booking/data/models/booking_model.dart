import 'package:hive/hive.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 0)
class BookingModel extends HiveObject {
  @HiveField(0)
  final String doctorId;

  @HiveField(1)
  final String doctorName;

  @HiveField(2)
  final String specialization;

  @HiveField(3)
  final DateTime slotTime;

  @HiveField(4)
  final String patientName;

  BookingModel({
    required this.doctorId,
    required this.doctorName,
    required this.specialization,
    required this.slotTime,
    required this.patientName,
  });
}
