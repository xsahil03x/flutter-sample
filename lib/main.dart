import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/app_router.dart';
import 'env.dart';

void main() {
  Env.set(kReleaseMode || kProfileMode ? Env.prod : Env.dev);
  AppRouter();
  runApp(App());
}
