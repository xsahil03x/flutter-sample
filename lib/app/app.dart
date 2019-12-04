import 'package:com_cingulo_sample/app/app_l10n.dart';
import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/env.dart';
import 'package:com_cingulo_sample/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'app_bloc.dart';
import 'app_refresh.dart';

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
          localizationsDelegates: AppL10n.delegates,
          supportedLocales: AppL10n.locales,
          locale: snapshot.data.locale,
          theme: snapshot.data.themeData,
          onGenerateRoute: AppRouter.instance.generator,
          builder: (context, widget) {
            WidgetsBinding.instance.addObserver(AppRefresh.instance);
            return widget;
          },
          home: SplashScreen(),
        );
      },
    );
  }
}
