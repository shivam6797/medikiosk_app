import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/features/doctor/bloc/doctor_event.dart';
import 'package:medikiosk_app/features/doctor/bloc/doctor_state.dart';
import 'package:medikiosk_app/features/doctor/data/models/doctor_model.dart';
import 'package:medikiosk_app/features/doctor/data/repository/doctor_repository.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository doctorRepository;

  DoctorBloc({required this.doctorRepository}) : super(DoctorInitial()) {
    on<LoadDoctors>((event, emit) async {
      emit(DoctorLoading());
      await emit.forEach<List<DoctorModel>>(
        doctorRepository.getDoctorsStream(),
        onData: (doctors) => DoctorLoaded(doctors),
        onError: (error, stackTrace) => DoctorError(error.toString()),
      );
    });
  }
}
