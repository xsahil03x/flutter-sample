import 'package:dio/dio.dart';

import '../../../services/l10n_service.dart';

class LanguageInterceptor extends Interceptor {
  LanguageInterceptor();

  @override
  Future onRequest(RequestOptions options) async {
    final acceptLanguage = L10nService.instance.getCurrentLocale().toString().replaceAll('_', '-');
    options.headers['Accept-Language'] = acceptLanguage;
    return options;
  }

  @override
  Future onError(DioError error) async {
    return null;
  }
}
