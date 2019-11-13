import 'package:com_cingulo_sample/app/app_bloc.dart';
import 'package:com_cingulo_sample/common/bloc.dart';
import 'package:com_cingulo_sample/env.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBloc extends Bloc<SettingsBlocState> {
  SettingsBloc() : super(states$$: PublishSubject<SettingsBlocState>());

  @override
  void postInit() async {
    super.postInit();
    final packageInfo = await PackageInfo.fromPlatform();
    states$$.add(SettingsBlocLoaded(packageInfo.version));
  }

  void hiring() async {
    final url = Env.data.hiringUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void simulateExpiredAuthToken() {
    catchError(() async {
      await di.coreRepository.simulateAuthenticationFailed();
    });
  }

  void simulateInternalServerError() {
    catchError(() async {
      await di.coreRepository.simulateInternalServerError();
    });
  }

  void setLanguage(Locale locale) {
    AppBloc.instance.setLocale(locale);
    states$$?.add(SettingsBlocLocaleChanged());
  }

  void setThemeData(ThemeData themeData) {
    AppBloc.instance.setThemeData(themeData);
    states$$?.add(SettingsBlocLocaleChanged());
  }

  void logout() async {
    await di.accountsRepository.logOut();
    states$$?.add(SettingsBlocLoggedOut());
  }
}

abstract class SettingsBlocState extends BlocState {}

class SettingsBlocLoaded extends SettingsBlocState {
  String appVersion;

  SettingsBlocLoaded(this.appVersion);
}

class SettingsBlocLocaleChanged extends SettingsBlocState {}

class SettingsBlocLoggedOut extends SettingsBlocState {}
