import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/core/theme/theme_provider.dart';
import 'package:medikiosk_app/features/auth/bloc/auth_bloc.dart';
import 'package:medikiosk_app/features/booking/bloc/booking_bloc.dart';
import 'package:medikiosk_app/features/booking/data/local/booking_local_service.dart';
import 'package:medikiosk_app/features/booking/data/repository/booking_repository.dart';
import 'package:medikiosk_app/features/doctor/bloc/doctor_bloc.dart';
import 'package:medikiosk_app/features/doctor/data/repository/doctor_repository.dart';
import 'package:provider/provider.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class App extends StatelessWidget {
  final BookingLocalService bookingLocalService;

  const App({super.key, required this.bookingLocalService});

  @override
  Widget build(BuildContext context) {
    debugPrint("✅ App started with BookingLocalService");

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<DoctorBloc>(create: (_) => DoctorBloc(doctorRepository: DoctorRepository())),
        BlocProvider<BookingBloc>(
          create: (_) {
            debugPrint("✅ BookingBloc created");
            return BookingBloc(repository: BookingRepository(bookingLocalService));
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MediKiosk',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
