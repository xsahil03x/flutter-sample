import 'package:flutter/material.dart';

import '../app/app_l10n.dart';

abstract class AL10nDelegate<T> extends LocalizationsDelegate<T> {
  const AL10nDelegate();

  @override
  bool isSupported(Locale locale) => AppL10n.isSupported(locale);

  @override
  bool shouldReload(LocalizationsDelegate<T> old) => false;
}
