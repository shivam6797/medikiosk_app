import 'package:flutter/material.dart';
import 'package:medikiosk_app/core/utils/inactivity_service.dart';
import 'package:medikiosk_app/features/lock/presentation/lock_screen.dart';

class InactivityWrapper extends StatefulWidget {
  final Widget child;

  const InactivityWrapper({required this.child, super.key});

  @override
  State<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends State<InactivityWrapper> {
  final _inactivityService = InactivityService();

  @override
  void initState() {
    super.initState();
    _inactivityService.start(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LockScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _inactivityService.reset(),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _inactivityService.stop();
    super.dispose();
  }
}
