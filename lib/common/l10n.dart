import 'package:flutter/material.dart';

import '../services/l10n_service.dart';

abstract class AL10nDelegate<T> extends LocalizationsDelegate<T> {
  const AL10nDelegate();

  @override
  bool isSupported(Locale locale) => L10nService.isSupported(locale);

  @override
  bool shouldReload(LocalizationsDelegate<T> old) => false;
}
