import 'package:com_cingulo_sample/screens/accounts/accounts_router.dart';
import 'package:com_cingulo_sample/screens/settings/settings_router.dart';
import 'package:com_cingulo_sample/screens/splash/splash_router.dart';
import 'package:com_cingulo_sample/screens/todo/todo_router.dart';
import 'package:fluro/fluro.dart';

class AppRouter {
  static final router = Router();

  static void define() {
    AccountsRouter.define();
    SettingsRouter.define();
    SplashRouter.define();
    TodoRouter.define();
  }
}
