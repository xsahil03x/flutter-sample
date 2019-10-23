import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'sign_up_screen.dart';

class SignUpRouter {
  static final String route = '/sign-up';

  static void define() {
    AppRouter.router.define(route, handler: Handler(handlerFunc: _handlerFunc));
  }

  static void navigate(BuildContext context) {
    AppRouter.router.navigateTo(context, route, transition: TransitionType.fadeIn, clearStack: true);
  }

  static Widget _handlerFunc(BuildContext context, Map<String, dynamic> params) {
    return SignUpScreen();
  }
}
