import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/disposable.dart';
import '../../errors/error_handler.dart';
import '../../models/auth/auth_permission_model.dart';
import '../../models/auth/auth_token_model.dart';
import '../../services/analytics_service.dart';
import '../../services/pushes_service.dart';
import 'auth_api.dart';
import 'mapper/auth_token_mapper.dart';

/*
 * This is the only repository that must not extend Repository because
 * Repository uses it for onAuthPermission and onRefreshDaily.
 */
class AuthRepository with ADisposeMixin {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String _authTokenKey = 'AuthRepository.authToken';
  final AuthApi _authApi;

  Completer<void> _initialized = Completer<void>();
  Future<void> get initialized => _initialized.future;

  BehaviorSubject<AuthPermissionModel> _permission$$ = BehaviorSubject<AuthPermissionModel>();
  Stream<AuthPermissionModel> get permission$ => _permission$$.stream;

  @provide
  @singleton
  AuthRepository(this._authApi) {
    disposableFunctions.add(_permission$$.close);
    init();
  }

  void init() async {
    await refresh();
    _initialized.complete();
  }

  Future<AuthPermissionModel> refresh() async {
    final current = await getPermission();
    if (current.isAuthenticated) {
      await _refreshToken();
    } else {
      await _refreshPermission();
    }
    final refreshed = await getPermission();
    return refreshed;
  }

  Future<void> _refreshToken() async {
    final oldToken = await getToken();
    final request = AuthTokenMapper.modelToRequest(oldToken);
    try {
      final response = await _authApi.refreshToken(request, AuthTokenMapper.badRequestToModelError);
      final newToken = AuthTokenMapper.responseToModel(response);
      await saveToken(newToken); // Will call _refreshPermission()
    } catch (error, stackTrace) {
      ErrorHandler.instance.handle(error, stackTrace: stackTrace);
    }
  }

  Future<void> _refreshPermission() async {
    final oldPermission = _permission$$.value;
    final newPermission = await getPermission();
    if (oldPermission != newPermission) {
      _permission$$.add(newPermission);
    }
  }

  Future<AuthPermissionModel> getPermission() async {
    final isAuthenticated = await _storage.read(key: _authTokenKey) != null;
    return AuthPermissionModel(isAuthenticated);
  }

  Future<AuthTokenModel> getToken() async {
    final token = await _storage.read(key: _authTokenKey);
    final authTokenModel = AuthTokenMapper.stringToModel(token);
    return authTokenModel;
  }

  Future<void> saveToken(AuthTokenModel authTokenModel) async {
    await _storage.write(key: _authTokenKey, value: authTokenModel.token);
    await _refreshPermission();
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _authTokenKey);
    await _refreshPermission();
    AnalyticsService.instance.unsetUser();
    PushesService.instance.unsetUser();
  }
}
