import 'package:com_cingulo_sample/app/app_analytics.dart';
import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:com_cingulo_sample/app/app_pushes.dart';
import 'package:com_cingulo_sample/data/accounts/accounts_api.dart';
import 'package:com_cingulo_sample/data/accounts/mappers/log_in_mapper.dart';
import 'package:com_cingulo_sample/data/accounts/mappers/sign_up_mapper.dart';
import 'package:com_cingulo_sample/data/auth/auth_repository.dart';
import 'package:com_cingulo_sample/data/auth/mapper/auth_token_mapper.dart';
import 'package:com_cingulo_sample/data/auth/responses/auth_token_response.dart';
import 'package:com_cingulo_sample/models/accounts/log_in_model.dart';
import 'package:com_cingulo_sample/models/accounts/sign_up_model.dart';
import 'package:com_cingulo_sample/models/accounts/user_model.dart';
import 'package:inject/inject.dart';

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
    AppAnalytics.instance.setUser(user);
    AppPushes.instance.setUser(user);
  }
}
