import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

@module
class DioDi {
  @provide
  Dio dio() => Dio();
}
