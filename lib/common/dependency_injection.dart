import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:flutter/material.dart';

/*
 * Classes using DependencyInjectionMixin must call 
 * inject() in the constructor.
 */
abstract class ADependencyInjectionMixin {
  @protected
  @visibleForTesting
  AppDi di;

  @protected
  @visibleForTesting
  Future<void> inject() async {
    di = await AppDi.instance;
    diReady();
  }

  @protected
  @visibleForTesting
  void diReady() {}
}
