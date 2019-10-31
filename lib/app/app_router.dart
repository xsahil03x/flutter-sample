import 'package:com_cingulo_sample/screens/accounts/log_in/log_in_route.dart';
import 'package:com_cingulo_sample/screens/accounts/sign_up/sign_up_route.dart';
import 'package:com_cingulo_sample/screens/settings/settings_route.dart';
import 'package:com_cingulo_sample/screens/splash/splash_route.dart';
import 'package:com_cingulo_sample/screens/todo/edit_task/edit_task_route.dart';
import 'package:com_cingulo_sample/screens/todo/todo/todo_route.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final Router _router = Router();
  static Route<dynamic> generator(RouteSettings routeSettings) => _router.generator(routeSettings);
  static void pop(BuildContext context) => _router.pop(context);

  static final List<AppRouteDefinition> routes = [
    SplashRoute(),
    SignUpRoute(),
    LogInRoute(),
    TodoRoute(),
    EditTaskRoute(),
    SettingsRoute(),
  ];

  static void define() {
    for (var route in routes) {
      _router.define(route.path, handler: Handler(handlerFunc: route.handlerFunc));
    }
  }

  static Future<dynamic> navigateTo(
    BuildContext context,
    String path, {
    bool replace,
    bool clearStack,
    TransitionType transition,
    Duration transitionDuration,
    RouteTransitionsBuilder transitionBuilder,
  }) async {
    final match = _router.match(path);
    if (match != null) {
      final route = routes.firstWhere((r) => r.path == match.route.route);
      final hasPermission = await route.hasPermission(match.parameters);
      if (hasPermission) {
        return _router.navigateTo(
          context,
          path,
          replace: replace ?? route.replace,
          clearStack: clearStack ?? route.clearStack,
          transition: transition ?? route.transition,
          transitionDuration: transitionDuration ?? route.transitionDuration,
          transitionBuilder: transitionBuilder ?? route.transitionBuilder,
        );
      }
    }
  }
}

abstract class AppRouteDefinition {
  String path;
  bool replace = false;
  bool clearStack = false;
  TransitionType transition;
  Duration transitionDuration = Duration(milliseconds: 250);
  RouteTransitionsBuilder transitionBuilder;
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params);
  Future<bool> hasPermission(Map<String, List<String>> params);
}
