import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'env.dart';
import 'services/router_service.dart';

void main() {
  Env.set(kReleaseMode || kProfileMode ? Env.prod : Env.dev);
  RouterService();
  runApp(App());
}
