import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medikiosk_app/app/app.dart';
import 'package:medikiosk_app/core/theme/theme_provider.dart';
import 'package:medikiosk_app/features/booking/data/local/booking_local_service.dart';
import 'package:medikiosk_app/features/booking/data/models/booking_model.dart';
import 'package:medikiosk_app/firebase_options.dart';
import 'package:provider/provider.dart';

final bookingLocalService = BookingLocalService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter(); 
  Hive.registerAdapter(BookingModelAdapter());
  await bookingLocalService.init();
  debugPrint("✅ Hive box opened successfully");

  final themeProvider = ThemeProvider();
  await themeProvider.initTheme(); // ✅ Wait for theme to load

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: App(bookingLocalService: bookingLocalService),
    ),
  );
}
