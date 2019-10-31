import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:flutter/material.dart';

import 'log_in_screen.dart';

class LogInRoute extends AppRouteDefinition {
  static String _path = '/log-in';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  Future<bool> hasPermission(Map<String, List<String>> params) async => true;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => LogInScreen();
}
