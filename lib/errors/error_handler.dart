import 'package:flutter/material.dart';

import '../app/app_di.dart';
import '../screens/splash/splash_route.dart';
import '../services/crashes_service.dart';
import '../services/l10n_service.dart';
import '../services/router_service.dart';
import '../widgets/dialogs.dart';
import 'api_error.dart';
import 'erros_l10n.dart';
import 'model_error.dart';
import 'unauthenticated_error.dart';

class ErrorHandler {
  static ErrorHandler get instance => ErrorHandler();
  static final ErrorHandler _singleton = ErrorHandler._init();
  factory ErrorHandler() => _singleton;

  ErrorHandler._init();

  void handle(Object error, {StackTrace stackTrace, BuildContext context}) async {
    if (error is UnauthenticatedError) {
      final di = await AppDi.instance;
      await di.accountsRepository.logOut();
      await RouterService.instance.navigateTo(SplashRoute.buildPath());
    } else if (error is ModelError && error.generic != null && context != null) {
      DialogAlert.show(context, error.generic);
    } else if (error is ApiError && context != null) {
      final l10n = L10nService.of<ErrorsL10n>(context);
      DialogAlert.show(context, l10n.apiError);
    } else {
      CrashesService.instance.nonFatalError(error, stackTrace, context: 'ErrorHandler.handle.else');
    }
  }
}
