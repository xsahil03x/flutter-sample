import 'dart:io';

import 'package:com_cingulo_sample/errors/erros_l10n.dart';
import 'package:com_cingulo_sample/screens/accounts/log_in/log_in_l10n.dart';
import 'package:com_cingulo_sample/screens/accounts/sign_up/sign_up_l10n.dart';
import 'package:com_cingulo_sample/screens/settings/settings_l10n.dart';
import 'package:com_cingulo_sample/screens/todo/add_task/add_task_l10n.dart';
import 'package:com_cingulo_sample/screens/todo/edit_task/edit_task_l10n.dart';
import 'package:com_cingulo_sample/screens/todo/todo/todo_l10n.dart';
import 'package:com_cingulo_sample/widgets/widgets_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10nService {
  static L10nService get instance => L10nService();
  factory L10nService() => _singleton;
  static final L10nService _singleton = L10nService._init();

  static T of<T>(BuildContext context) => Localizations.of<T>(context, T);

  static final List<LocalizationsDelegate<dynamic>> delegates = [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    LogInL10n.delegate,
    SignUpL10n.delegate,
    ErrorsL10n.delegate,
    SettingsL10n.delegate,
    TodoL10n.delegate,
    AddTaskL10n.delegate,
    EditTaskL10n.delegate,
    WidgetsL10n.delegate,
  ];

  static const Locale enUS = Locale.fromSubtags(languageCode: 'en', countryCode: 'US');
  static const Locale ptBR = Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR');
  static const List<Locale> locales = [enUS, ptBR];
  static const Locale defaultLocale = enUS;
  static bool isSupported(Locale locale) => locales.contains(locale);

  L10nService._init();

  Locale getCurrentLocale() {
    final platformLocale = getPlatformLocale();
    if (isSupported(platformLocale)) {
      return platformLocale;
    }
    for (var i = 0; i < locales.length; i++) {
      if (platformLocale.languageCode == locales[i].languageCode) {
        return locales[i];
      }
    }
    return defaultLocale;
  }

  Locale getPlatformLocale() {
    String localeString = Platform.localeName;
    localeString ??= '${defaultLocale.languageCode}-${defaultLocale.countryCode}';

    List<String> codes = localeString.split('-');
    if (codes.length == 1) {
      codes = localeString.split('_');
    }

    if (codes.length == 2) {
      return Locale(codes[0], codes[1]);
    } else if (codes.length == 1) {
      return Locale(codes[0]);
    } else {
      return defaultLocale;
    }
  }
}
