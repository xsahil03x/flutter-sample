import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/widget.dart';
import '../../services/l10n_service.dart';
import '../../services/router_service.dart';
import '../../themes/sample_theme_dark.dart';
import '../../themes/sample_theme_light.dart';
import '../splash/splash_route.dart';
import 'settings_bloc.dart';
import 'settings_l10n.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends AStatefulWBL<SettingsScreen, SettingsBloc, SettingsL10n> {
  @override
  final SettingsBloc bloc = SettingsBloc();
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    bloc.states$.listen(_onData);
  }

  void _onData(SettingsBlocState state) {
    if (state is SettingsBlocLoaded) {
      setState(() => _appVersion = state.appVersion);
    } else if (state is SettingsBlocLocaleChanged || state is SettingsBlocLoggedOut) {
      RouterService.instance.navigateTo(SplashRoute.buildPath());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.title),
      ),
      body: ListView(
        children: <Widget>[
          _item(l10n.hiring, bloc.hiring),
          _item(l10n.simulateExpiredAuthToken, bloc.simulateExpiredAuthToken),
          _item(l10n.simulateInternalServerError, bloc.simulateInternalServerError),
          _item(l10n.languageEnUs, () => bloc.setLanguage(L10nService.enUS)),
          _item(l10n.languagePtBr, () => bloc.setLanguage(L10nService.ptBR)),
          _item(l10n.themeLight, () => bloc.setThemeData(SampleThemeLight.themeData)),
          _item(l10n.themeDark, () => bloc.setThemeData(SampleThemeDark.themeData)),
          _item(l10n.logout, bloc.logout),
          _version(),
        ],
      ),
    );
  }

  Widget _item(String text, Function() onTap) {
    return Card(
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          title: Text(text),
        ),
      ),
    );
  }

  Widget _version() {
    // Just to show some L10n interpolation.
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        l10n.version(_appVersion),
        textAlign: TextAlign.center,
      ),
    );
  }
}
