import 'package:inject/inject.dart';

import '../../app/app_di.dart';
import '../../models/accounts/log_in_model.dart';
import '../../models/accounts/sign_up_model.dart';
import '../../models/accounts/user_model.dart';
import '../../services/analytics_service.dart';
import '../../services/pushes_service.dart';
import '../auth/auth_repository.dart';
import '../auth/mapper/auth_token_mapper.dart';
import '../auth/responses/auth_token_response.dart';
import 'accounts_api.dart';
import 'mappers/log_in_mapper.dart';
import 'mappers/sign_up_mapper.dart';

class AccountsRepository {
  final AccountsApi _accountsApi;
  final AuthRepository _authRepository;

  @provide
  AccountsRepository(this._accountsApi, this._authRepository);

  Future<void> logIn(LogInModel logInModel) async {
    final request = LogInMapper.modelToRequest(logInModel);
    final response = await _accountsApi.logIn(request, LogInMapper.badRequestToModelError);
    await _onAuthTokensResponse(response);
  }

  Future<void> signUp(SignUpModel signUpModel) async {
    final request = SignUpMapper.modelToRequest(signUpModel);
    final response = await _accountsApi.signUp(request, SignUpMapper.badRequestToModelError);
    await _onAuthTokensResponse(response);
  }

  Future<void> logOut() async {
    await _authRepository.deleteToken();
    AppDi.reset();
  }

  Future<UserModel> getUser() async {
    // TODO
    return UserModel();
  }

  Future<void> _onAuthTokensResponse(AuthTokenResponse response) async {
    final authToken = AuthTokenMapper.responseToModel(response);
    await _authRepository.saveToken(authToken); // Will call onAuthPermission()
    final user = await getUser();
    AnalyticsService.instance.setUser(user);
    PushesService.instance.setUser(user);
  }
}
