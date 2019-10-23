import 'package:com_cingulo_sample/screens/accounts/log_in/log_in_router.dart';
import 'package:com_cingulo_sample/screens/accounts/sign_up/sign_up_router.dart';

class AccountsRouter {
  static void define() {
    LogInRouter.define();
    SignUpRouter.define();
  }
}
