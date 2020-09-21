import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

import 'preference_utils.dart';
import 'shared_fields.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static Future<AppLocalizations> load(Locale locale) {
    PreferenceUtils.setString(SharedFields.LANGUAGE, locale.languageCode);
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Bel-Dor',
      'splashImage':
          'assets/images/homemade_splash_image/homemade_logo_long_ar_white.png',
      'language': 'Language',
      'arabic': 'Arabic',
      'english': 'English',
    },
    'ar': {
      'title': 'Bel-Dor',
      'splashImage':
          'assets/images/homemade_splash_image/homemade_logo_long_ar_white.png',
      'language': 'اللغــة',
      'arabic': 'العربيـة',
      'english': 'اﻹنجليزيـة',
    },
  };

  String get language {
    return _localizedValues[locale.languageCode]['language'];
  }

  String get arabic {
    return _localizedValues[locale.languageCode]['arabic'];
  }

  String get english {
    return _localizedValues[locale.languageCode]['english'];
  }

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get splashImage {
    return _localizedValues[locale.languageCode]['splashImage'];
  }

  String get languageCode {
    return locale.languageCode;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', ''),
      Locale('ar', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
