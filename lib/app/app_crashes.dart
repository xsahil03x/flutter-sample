import '../models/accounts/user_model.dart';

class AppCrashes {
  static AppCrashes get instance => AppCrashes();
  factory AppCrashes() => _singleton;
  static final AppCrashes _singleton = AppCrashes._init();

  AppCrashes._init();

  void setUser(UserModel user) {
    // TODO: identify user in the crash service
  }

  void unsetUser() {
    // TODO: clear user in the crash service
  }

  void nonFatalError(dynamic exception, StackTrace stack, {dynamic context = ''}) {
    // TODO: log fatal error in the crash service
  }

  void log(String message) {
    // TODO: log non fatal error in the crash service
  }
}
