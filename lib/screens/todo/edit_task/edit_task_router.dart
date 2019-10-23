import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/screens/todo/edit_task/edit_task_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class EditTaskRouter {
  static final String route = '/todo/task/:id';

  static void define() {
    AppRouter.router.define(route, handler: Handler(handlerFunc: _handlerFunc));
  }

  static void navigate(BuildContext context, String id) {
    final path = route.replaceFirst(':id', id);
    AppRouter.router.navigateTo(context, path, transition: TransitionType.native);
  }

  static Widget _handlerFunc(BuildContext context, Map<String, dynamic> params) {
    return EditTaskScreen(params['id'][0]);
  }
}
