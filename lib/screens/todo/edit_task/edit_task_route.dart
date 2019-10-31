import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/screens/todo/edit_task/edit_task_screen.dart';
import 'package:flutter/material.dart';

class EditTaskRoute extends AppRouteDefinition {
  static String _path = '/todo/task/:id';
  static String buildPath(String id) => _path.replaceFirst(':id', id);

  @override
  String get path => _path;

  @override
  Future<bool> hasPermission(Map<String, List<String>> params) async {
    final di = await AppDi.instance();
    final permission = await di.authRepository.getPermission();
    return permission.isAuthenticated;
  }

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) => EditTaskScreen(params['id'][0]);
}
