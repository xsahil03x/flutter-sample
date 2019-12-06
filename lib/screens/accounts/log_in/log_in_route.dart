import 'package:com_cingulo_sample/common/route.dart';
import 'package:flutter/material.dart';

import 'log_in_screen.dart';

class LogInRoute extends ARoute {
  static String _path = '/log-in';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => LogInScreen();
}
