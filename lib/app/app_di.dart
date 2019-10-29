import 'package:com_cingulo_sample/data/accounts/accounts_repository.dart';
import 'package:com_cingulo_sample/data/api_client/dio_di.dart';
import 'package:com_cingulo_sample/data/auth/auth_repository.dart';
import 'package:com_cingulo_sample/data/core/core_repository.dart';
import 'package:com_cingulo_sample/data/todo/todo_repository.dart';
import 'package:inject/inject.dart';

import 'app_di.inject.dart' as $gid;

@Injector([DioDi])
abstract class AppDi {
  AuthRepository get authRepository;

  CoreRepository get coreRepository;

  AccountsRepository get accountsRepository;

  TodoRepository get todoRepository;

  static Future<AppDi> _instance;

  static void reset() => _instance = null;

  static Future<AppDi> instance() {
    final dioDi = DioDi();
    _instance ??= $gid.AppDi$Injector.create(dioDi);
    return _instance;
  }
}
