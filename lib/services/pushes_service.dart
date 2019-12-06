import 'package:com_cingulo_sample/models/accounts/user_model.dart';

class PushesService {
  static PushesService get instance => PushesService();
  factory PushesService() => _singleton;
  static final PushesService _singleton = PushesService._init();

  PushesService._init();

  void setUser(UserModel user) {
    // TODO: identify user in the pushes service
  }

  void unsetUser() {
    // TODO: clear user in the pushes service
  }
}
