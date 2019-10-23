import 'package:com_cingulo_sample/app/app.dart';
import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  _setEnv();
  _setRoutes();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(App()));
}

void _setEnv() {
  Env.set(kReleaseMode || kProfileMode ? Env.prod : Env.dev);
}

void _setRoutes() {
  AppRouter.define();
}
