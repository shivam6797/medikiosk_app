import 'package:flutter/material.dart';
import 'package:medikiosk_app/features/auth/presentation/login_screen.dart';
import 'package:medikiosk_app/features/auth/presentation/splash_screen.dart';
import 'package:medikiosk_app/features/booking/presentation/booking_screen.dart';
import 'package:medikiosk_app/features/booking/presentation/my_appoinment_screen.dart';
import 'package:medikiosk_app/features/booking/presentation/slot_selection_screen.dart';
import 'package:medikiosk_app/features/doctor/presentation/doctor_status_screen.dart';
import 'package:medikiosk_app/features/home/presentation/home_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const doctorStatus = '/doctor-status';
  static const booking = '/booking';
  static const slotSelection = '/slot-selection';
  static const myAppointmentsScreen = '/my-appointments';


  static final routes = <String, WidgetBuilder>{
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    home: (_) => const HomeScreen(),
    doctorStatus: (_) => const DoctorStatusScreen(),
    booking: (_) => const BookingScreen(),
    slotSelection: (_) => const SlotSelectionScreen(),
    myAppointmentsScreen: (_) => const MyAppointmentsScreen(),

  };
}
