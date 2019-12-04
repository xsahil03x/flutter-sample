import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

class AppRefresh extends WidgetsBindingObserver {
  static AppRefresh get instance => AppRefresh();
  static final AppRefresh _singleton = AppRefresh._init();
  factory AppRefresh() => _singleton;

  // Emits an event once a day.
  PublishSubject<void> _daily$$ = PublishSubject<void>();
  Stream<void> get daily$ => _daily$$.stream;

  String _lastDailyEmitted;

  AppRefresh._init() {
    _lastDailyEmitted = _getDate();
  }

  String _getDate() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  void _dailyEvent() async {
    final today = _getDate();
    if (_lastDailyEmitted != today) {
      _lastDailyEmitted = today;
      _daily$$.add(null);
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        _dailyEvent();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.suspending:
    }
  }
}
