import 'package:com_cingulo_sample/app/app.dart';
import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/screens/splash/splash_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class SplashRouter {
  static final String route = '/splash';

  static void define() {
    AppRouter.router.define(route, handler: Handler(handlerFunc: _handlerFunc));
  }

  static void navigate([BuildContext context]) {
    if (context == null) {
      App.navigatorKey.currentState.pushNamedAndRemoveUntil(SplashRouter.route, (_) => false);
    } else {
      AppRouter.router.navigateTo(context, route, transition: TransitionType.fadeIn, clearStack: true);
    }
  }

  static Widget _handlerFunc(BuildContext context, Map<String, dynamic> params) {
    return SplashScreen();
  }
}
