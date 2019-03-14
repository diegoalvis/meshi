import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    /* English text resources */
    'en': {
      'title': 'Hello World',
      'log_in_with': 'Log in with',
    },

    /* Spanish text resources */
    'es': {
      'title': 'Hola Mundo',
      'log_in_with': 'Ingresa con',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get logInWith {
    return _localizedValues[locale.languageCode]['log_in_with'];
  }
}
