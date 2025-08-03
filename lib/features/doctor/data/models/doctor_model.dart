class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final bool isOnline;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.isOnline,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map, String docId) {
    return DoctorModel(
      id: docId,
      name: map['name'] ?? '',
      specialization: map['specialization'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }
}
