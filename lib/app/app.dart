import 'package:flutter/material.dart';

import '../env.dart';
import '../screens/splash/splash_screen.dart';
import '../services/l10n_service.dart';
import '../services/refresh_service.dart';
import '../services/router_service.dart';
import 'app_bloc.dart';

class App extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState>(
      stream: AppBloc.instance.states$,
      initialData: AppBloc.initialState,
      builder: (context, snapshot) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Flutter',
          debugShowCheckedModeBanner: Env.data.debugShowCheckedModeBanner,
          debugShowMaterialGrid: Env.data.debugShowMaterialGrid,
          localizationsDelegates: L10nService.delegates,
          supportedLocales: L10nService.locales,
          locale: snapshot.data.locale,
          theme: snapshot.data.themeData,
          onGenerateRoute: RouterService.instance.generator,
          builder: (context, widget) {
            WidgetsBinding.instance.addObserver(RefreshService.instance);
            return widget;
          },
          home: SplashScreen(),
        );
      },
    );
  }
}
