import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:com_cingulo_sample/common/route.dart';
import 'package:com_cingulo_sample/screens/todo/todo/todo_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class TodoRoute extends ARoute {
  static String _path = '/todo/todo';
  static String buildPath() => _path;

  @override
  String get path => _path;

  @override
  final bool clearStack = true;

  @override
  final TransitionType transition = TransitionType.fadeIn;

  @override
  Future<bool> hasPermission(Map<String, List<String>> params) async {
    final di = await AppDi.instance;
    final permission = await di.authRepository.getPermission();
    return permission.isAuthenticated;
  }

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => TodoScreen();
}
