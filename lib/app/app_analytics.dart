import 'package:com_cingulo_sample/models/accounts/user_model.dart';

class AppAnalytics {
  static AppAnalytics get instance => AppAnalytics();
  static final AppAnalytics _singleton = AppAnalytics._init();
  factory AppAnalytics() => _singleton;

  AppAnalytics._init();

  void setUser(UserModel auth) {
    // TODO: identify user in the analytics service
  }

  void unsetUser() {
    // TODO: clear user in the analytics service
  }
}
