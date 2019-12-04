import 'package:com_cingulo_sample/models/accounts/user_model.dart';

class AppPushes {
  static AppPushes get instance => AppPushes();
  factory AppPushes() => _singleton;
  static final AppPushes _singleton = AppPushes._init();

  AppPushes._init();

  void setUser(UserModel user) {
    // TODO: identify user in the pushes service
  }

  void unsetUser() {
    // TODO: clear user in the pushes service
  }
}
