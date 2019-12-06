import 'package:flutter/material.dart';

import '../../../services/l10n_service.dart';
import '../../../services/router_service.dart';
import '../../../widgets/buttons.dart';
import '../log_in/log_in_route.dart';
import 'sign_up_form.dart';
import 'sign_up_l10n.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SignUpL10n l10n = L10nService.of<SignUpL10n>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.title),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SignUpForm(),
              Container(height: 24),
              ButtonClear(
                text: l10n.logIn,
                onPressed: () => RouterService.instance.navigateTo(LogInRoute.buildPath()),
                themeData: Theme.of(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
