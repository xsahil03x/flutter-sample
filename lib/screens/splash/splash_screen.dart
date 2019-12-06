import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/widget.dart';
import '../../services/router_service.dart';
import '../../widgets/loaders.dart';
import '../accounts/sign_up/sign_up_route.dart';
import '../todo/todo/todo_route.dart';
import 'splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends AStatefulWB<SplashScreen, SplashBloc> {
  @override
  final SplashBloc bloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    bloc.states$.listen(_onData);
  }

  void _onData(SplashBlocState state) {
    if (state is SplashBlocAuthenticated) {
      RouterService.instance.navigateTo(TodoRoute.buildPath());
    } else if (state is SplashBlocUnauthenticated) {
      RouterService.instance.navigateTo(SignUpRoute.buildPath());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loading(),
    );
  }
}
