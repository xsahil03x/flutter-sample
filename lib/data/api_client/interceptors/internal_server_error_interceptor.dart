import 'package:dio/dio.dart';

import '../errors/internal_server_error.dart';

class InternalServerErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError error) async {
    if (error.response != null) {
      if (error.response.statusCode >= 500 && error.response.statusCode < 600) {
        return InternalServerError();
      }
    }
    return null;
  }
}
