import 'dart:async';

import 'package:flutter/material.dart';

class InactivityService {
  static final InactivityService _instance = InactivityService._internal();
  factory InactivityService() => _instance;
  InactivityService._internal();

  Timer? _inactivityTimer;
  late VoidCallback _onInactivityTimeout;

  void start(VoidCallback onTimeout, {Duration duration = const Duration(minutes: 2)}) {
    _onInactivityTimeout = onTimeout;
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(duration, _onInactivityTimeout);
  }

  void reset() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(minutes: 2), _onInactivityTimeout);
  }

  void stop() {
    _inactivityTimer?.cancel();
  }
}
