import 'package:com_cingulo_sample/app/app_l10n.dart';
import 'package:dio/dio.dart';

class LanguageInterceptor extends Interceptor {
  LanguageInterceptor();

  @override
  Future onRequest(RequestOptions options) async {
    final acceptLanguage = AppL10n.instance.getCurrentLocale().toString().replaceAll('_', '-');
    options.headers['Accept-Language'] = acceptLanguage;
    return options;
  }

  @override
  Future onError(DioError error) async {
    return null;
  }
}
