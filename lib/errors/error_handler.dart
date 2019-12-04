import 'package:com_cingulo_sample/app/app_l10n.dart';
import 'package:com_cingulo_sample/errors/api_error.dart';
import 'package:flutter/material.dart';

import '../app/app_crashes.dart';
import '../app/app_di.dart';
import '../app/app_router.dart';
import '../screens/splash/splash_route.dart';
import '../widgets/dialogs.dart';
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
      await AppRouter.instance.navigateTo(SplashRoute.buildPath());
    } else if (error is ModelError && error.generic != null && context != null) {
      DialogAlert.show(context, error.generic);
    } else if (error is ApiError && context != null) {
      final l10n = AppL10n.of<ErrorsL10n>(context);
      DialogAlert.show(context, l10n.apiError);
    } else {
      AppCrashes.instance.nonFatalError(error, stackTrace, context: 'ErrorHandler.handle.else');
    }
  }
}
