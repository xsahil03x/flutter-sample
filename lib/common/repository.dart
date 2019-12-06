import 'dart:async';

import 'package:flutter/widgets.dart';

import '../models/auth/auth_permission_model.dart';
import '../services/refresh_service.dart';
import 'dependency_injection.dart';
import 'disposable.dart';

abstract class ARepository with ADisposableMixin, ADependencyInjectionMixin {
  @protected
  Completer<void> _initialized = Completer<void>();
  Future<void> get initialized => _initialized.future;

  ARepository() {
    init();
  }

  @protected
  @mustCallSuper
  void init() {
    inject();
  }

  @override
  @mustCallSuper
  void diReady() async {
    disposableFunctions
      ..add(di.authRepository.permission$.listen(_onAuthPermission).cancel)
      ..add(RefreshService.instance.daily$.listen((_) => onRefreshDaily()).cancel);
    await di.authRepository.initialized;
    postInit();
  }

  @mustCallSuper
  void postInit() async {
    _initialized.complete();
  }

  void _onAuthPermission(AuthPermissionModel permission) {
    if (_initialized.isCompleted) {
      onAuthPermission(permission);
    }
  }

  @protected
  void onAuthPermission(AuthPermissionModel permission) {}

  @protected
  void onRefreshDaily() {}
}
