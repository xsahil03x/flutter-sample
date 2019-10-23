import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'log_in_screen.dart';

class LogInRouter {
  static final String route = '/log-in';

  static void define() {
    AppRouter.router.define(route, handler: Handler(handlerFunc: _handlerFunc));
  }

  static void navigate(BuildContext context) {
    AppRouter.router.navigateTo(context, route, transition: TransitionType.native);
  }

  static Widget _handlerFunc(BuildContext context, Map<String, dynamic> params) {
    return LogInScreen();
  }
}
