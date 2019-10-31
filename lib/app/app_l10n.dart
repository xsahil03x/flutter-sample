import 'package:com_cingulo_sample/common/l10n.dart';
import 'package:com_cingulo_sample/errors/erros_l10n.dart';
import 'package:com_cingulo_sample/screens/accounts/log_in/log_in_l10n.dart';
import 'package:com_cingulo_sample/screens/accounts/sign_up/sign_up_l10n.dart';
import 'package:com_cingulo_sample/screens/settings/settings_l10n.dart';
import 'package:com_cingulo_sample/screens/todo/add_task/add_task_l10n.dart';
import 'package:com_cingulo_sample/screens/todo/edit_task/edit_task_l10n.dart';
import 'package:com_cingulo_sample/screens/todo/todo/todo_l10n.dart';
import 'package:com_cingulo_sample/widgets/widgets_l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

enum _LKeys {
  title,
}

class AppL10n {
  static final Map<String, Map<_LKeys, String>> _localizedValues = {
    L10n.enUS.toString(): {
      _LKeys.title: "Cíngulo Flutter Sample",
    },
    L10n.ptBR.toString(): {
      _LKeys.title: "Exemplo em Flutter do Cíngulo",
    },
  };

  String get title => _localizedValues[locale.toString()][_LKeys.title];

  final Locale locale;

  AppL10n(this.locale);

  static T of<T>(BuildContext context) {
    return Localizations.of<T>(context, T);
  }

  static final List<LocalizationsDelegate<dynamic>> delegates = [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _AppL10nDelegate(),
    LogInL10n.delegate,
    SignUpL10n.delegate,
    ErrorsL10n.delegate,
    SettingsL10n.delegate,
    TodoL10n.delegate,
    AddTaskL10n.delegate,
    EditTaskL10n.delegate,
    WidgetsL10n.delegate,
  ];
}

class _AppL10nDelegate extends L10nDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(AppL10n(locale));
  }
}
