import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsRoute extends AppRouteDefinition {
  static String _path = '/settings';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  Future<bool> hasPermission(Map<String, List<String>> params) async {
    final di = await AppDi.instance();
    final permission = await di.authRepository.getPermission();
    return permission.isAuthenticated;
  }

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => SettingsScreen();
}
