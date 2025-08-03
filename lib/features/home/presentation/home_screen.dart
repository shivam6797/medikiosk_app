import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/app/app_routes.dart';
import 'package:medikiosk_app/core/constants/app_strings.dart';
import 'package:medikiosk_app/core/theme/theme_provider.dart';
import 'package:medikiosk_app/core/widget/inactivity_wrapper.dart';
import 'package:medikiosk_app/features/auth/bloc/auth_bloc.dart';
import 'package:medikiosk_app/features/auth/bloc/auth_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    startKioskMode();
  }

  Future<void> startKioskMode() async {
    const platform = MethodChannel('com.medikiosk.kiosk');
    try {
      final result = await platform.invokeMethod('startKioskMode');
      debugPrint("✅ Kiosk Mode Result: $result");
    } on PlatformException catch (e) {
      debugPrint("❌ Failed to start kiosk mode: '${e.message}'");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return InactivityWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppStrings.appName),
          actions: [
            IconButton(
              icon: Icon(
                context.watch<ThemeProvider>().isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: theme.appBarTheme.foregroundColor,
              ),
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),
            IconButton(
              icon: Icon(Icons.logout, color: theme.appBarTheme.foregroundColor),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width < 500 ? width : 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Admin 👋',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose an option to continue',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Book quick appointments or check doctor availability\nwith just a tap — simple and secure.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 30),
                  HomeCardButton(
                    icon: Icons.calendar_month,
                    label: AppStrings.bookAppointment,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.booking);
                    },
                  ),
                  const SizedBox(height: 20),
                  HomeCardButton(
                    icon: Icons.medical_services_rounded,
                    label: AppStrings.doctorStatus,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.doctorStatus);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeCardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HomeCardButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white, // ✅ clean color
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: theme.primaryColor.withOpacity(0.15),
                child: Icon(icon, color: theme.primaryColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: theme.hintColor),
            ],
          ),
        ),
      ),
    );
  }
}
