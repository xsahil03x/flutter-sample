import 'package:dio/dio.dart';

import '../errors/bad_request_error.dart';

class BadRequestInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    options.queryParameters['platform'] = 'flutter';
    return options;
  }

  @override
  Future onError(DioError error) async {
    if (error.response != null) {
      if (error.response.statusCode == 400) {
        return BadRequestError(error.response.data);
      } else if (error.response.statusCode == 417) {
        return BadRequestError({});
      }
    }
    return null;
  }
}
