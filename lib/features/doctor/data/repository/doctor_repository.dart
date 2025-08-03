import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medikiosk_app/features/doctor/data/models/doctor_model.dart';

class DoctorRepository {
  final _doctorCollection = FirebaseFirestore.instance.collection('doctor_status');

  Stream<List<DoctorModel>> getDoctorsStream() {
    return _doctorCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DoctorModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
