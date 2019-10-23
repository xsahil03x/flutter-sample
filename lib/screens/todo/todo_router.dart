import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/screens/todo/edit_task/edit_task_router.dart';
import 'package:com_cingulo_sample/screens/todo/todo_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class TodoRouter {
  static final String route = '/todo';

  static void define() {
    AppRouter.router.define(route, handler: Handler(handlerFunc: _handlerFunc));
    EditTaskRouter.define();
  }

  static void navigate(BuildContext context) {
    AppRouter.router.navigateTo(context, route, transition: TransitionType.fadeIn, clearStack: true);
  }

  static Widget _handlerFunc(BuildContext context, Map<String, dynamic> params) {
    return TodoScreen();
  }
}
