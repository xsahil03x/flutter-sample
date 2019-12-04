import 'package:com_cingulo_sample/common/route.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen.dart';

class SignUpRoute extends ARoute {
  static String _path = '/sign-up';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final bool clearStack = true;

  @override
  final TransitionType transition = TransitionType.fadeIn;

  @override
  Future<bool> hasPermission(Map<String, List<String>> params) async => true;

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => SignUpScreen();
}
