import '../models/accounts/user_model.dart';

class CrashesService {
  static CrashesService get instance => CrashesService();
  factory CrashesService() => _singleton;
  static final CrashesService _singleton = CrashesService._init();

  CrashesService._init();

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
