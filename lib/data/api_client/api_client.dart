import 'package:com_cingulo_sample/data/api_client/errors/bad_request_error.dart';
import 'package:com_cingulo_sample/data/api_client/errors/unauthorized_error.dart';
import 'package:com_cingulo_sample/data/api_client/interceptors/auth_interceptor.dart';
import 'package:com_cingulo_sample/data/api_client/interceptors/bad_request_interceptor.dart';
import 'package:com_cingulo_sample/data/api_client/interceptors/internal_server_error_interceptor.dart';
import 'package:com_cingulo_sample/data/api_client/interceptors/language_interceptor.dart';
import 'package:com_cingulo_sample/data/api_client/interceptors/unauthorized_interceptor.dart';
import 'package:com_cingulo_sample/env.dart';
import 'package:com_cingulo_sample/errors/api_error.dart';
import 'package:com_cingulo_sample/errors/unauthenticated_error.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

class ApiClient {
  final Dio _dio;

  @provide
  @singleton
  ApiClient(this._dio) {
    _dio.options.baseUrl = Env.data.apiBaseUrl;
    _dio.options.connectTimeout = Duration(minutes: 3).inMilliseconds;
    _dio.options.receiveTimeout = Duration(minutes: 3).inMilliseconds;
    _dio.interceptors.add(LanguageInterceptor());
    _dio.interceptors.add(InternalServerErrorInterceptor());
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(UnauthorizedInterceptor());
    _dio.interceptors.add(BadRequestInterceptor());
    if (Env.data.debugApiClient) {
      _dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
    }
  }

  post(String path, dynamic data, Function badRequestToModelError) async {
    try {
      return await _dio.post(path, data: data);
    } on BadRequestError catch (error) {
      throw badRequestToModelError(error);
    } on UnauthorizedError {
      throw UnauthenticatedError();
    } on DioError {
      throw ApiError();
    }
    // You may also want to do some special treatment for InternalServerError
  }

  put(String path, dynamic data, Function badRequestToModelError) async {
    try {
      return await _dio.put(path, data: data);
    } on BadRequestError catch (error) {
      throw badRequestToModelError(error);
    } on UnauthorizedError {
      throw UnauthenticatedError();
    } on DioError {
      throw ApiError();
    }
    // You may also want to do some special treatment for InternalServerError
  }

  delete(String path) async {
    try {
      return await _dio.delete(path);
    } on UnauthorizedError {
      throw UnauthenticatedError();
    } on DioError {
      throw ApiError();
    }
    // You may also want to do some special treatment for InternalServerError
  }

  get(String path) async {
    try {
      return await _dio.get(path);
    } on UnauthorizedError {
      throw UnauthenticatedError();
    } on DioError {
      throw ApiError();
    }
    // You may also want to do some special treatment for InternalServerError
  }
}
