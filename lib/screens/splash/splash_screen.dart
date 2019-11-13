import 'package:com_cingulo_sample/app/app_router.dart';
import 'package:com_cingulo_sample/common/widget.dart';
import 'package:com_cingulo_sample/screens/accounts/sign_up/sign_up_route.dart';
import 'package:com_cingulo_sample/screens/splash/splash_bloc.dart';
import 'package:com_cingulo_sample/screens/todo/todo/todo_route.dart';
import 'package:com_cingulo_sample/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends StatefulWB<SplashScreen, SplashBloc> {
  @override
  final SplashBloc bloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    bloc.states$.listen(_onData);
  }

  void _onData(SplashBlocState state) {
    if (state is SplashBlocAuthenticated) {
      AppRouter.instance.navigateTo(context, TodoRoute.buildPath());
    } else if (state is SplashBlocUnauthenticated) {
      AppRouter.instance.navigateTo(context, SignUpRoute.buildPath());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loading(),
    );
  }
}
