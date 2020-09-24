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
      'title': 'Bel-Door',
      'splashImage':
          'assets/images/homemade_splash_image/homemade_logo_long_ar_white.png',
      'language': 'Language',
      'arabic': 'Arabic',
      'english': 'English',
      'generateTicket': 'Generate A Ticket',
      'branch': 'Branch:',
      'department': 'Department:',
      'ticketState': 'Ticket State:',
      'yourCode': 'Your Code:',
      'currentNumber': 'Current Number:',
      'welcome': 'Welcome',
      'loginTitle': 'Let\'s Sign You In',
      'loginSubtitle': 'Welcome Back, you\'ve been missed',
      'email': 'Email',
      'enterValidEmail': 'Please Enter Email',
      'password': 'Password',
      'enterValidPassword': 'Please Enter password',
      'forgetPassword': 'Forgot Password ?',
      'conditionTitle': 'By Creating an account, you agree to our',
      'termsAndConditions': 'Terms and Conditions',
      'termsAndConditionValidation': 'Please accept our terms',
      'signIn': 'Sign In',
      'dontHaveAccount': 'Don\'t have an account ?',
      'signUp': 'Sign Up',
      'signUpTitle': 'Getting Started',
      'signUpSubtitle': 'Create a new account',
      'username': 'Username',
      'enterValidUsername': 'Please Enter Username',
      'phone': 'Phone',
      'enterValidPhone': 'Please Enter Phone',
      'passwordsNotIdentical': 'passwords are not identical',
      'confirmPassword': 'Confirm Password',
      'enterValidConfirmPassword': 'Please Enter Confirmation Password',
      'haveAnAccount': 'Have an Account',
      'home': 'Home',
      'login': 'Login',
      'logout': 'Logout',
      'branches': 'Branches',
      'waitingTickets': 'Waiting Tickets',
      'closedTickets': 'Closed Tickets',
      'missedTickets': 'Missed Tickets',
      'noWaitingTickets': 'No Waiting Tickets Available Today',
      'noClosedTickets': 'No Closed Tickets Available Today',
      'noMissedTickets': 'No Missed Tickets Available Today'
    },
    'ar': {
      'title': 'Bel-Door',
      'splashImage':
          'assets/images/homemade_splash_image/homemade_logo_long_ar_white.png',
      'language': 'اللغــة',
      'arabic': 'العربيـة',
      'english': 'اﻹنجليزيـة',
      'generateTicket': 'تــذكـرة جـديــدة',
      'branch': 'الفــرع:',
      'department': 'الـقســم:',
      'ticketState': 'حـالـة التـذكـرة:',
      'yourCode': 'الكـود الخـاص بــك:',
      'currentNumber': 'الـرقــم الحــالـى:',
      'welcome': 'أهــلا بــك',
      'loginTitle': 'هـيـا بـنا نسـجـل دخــول',
      'loginSubtitle': 'أهـــلا بـــك مـن جـديـد افـتـقـدنـاك',
      'email': 'الحسـاب',
      'enterValidEmail': 'أدخـل الحسـاب',
      'password': 'كلمـة المرور',
      'enterValidPassword': 'أدخـل كلمـة المرور',
      'forgetPassword': 'نسـيت كلـمة المـرور ؟',
      'conditionTitle': 'من خلال إنشاء حساب ، فإنك توافق على',
      'termsAndConditions': 'الأحكام والشروط',
      'termsAndConditionValidation': 'يجب الموافقـة علـى الأحكام والشروط',
      'signIn': 'تـسجيـل دخــول',
      'dontHaveAccount': 'لـيس لديـك حسـاب ؟',
      'signUp': 'مـستخـدم جديـد',
      'signUpTitle': 'دعـنا نـبـدأ',
      'signUpSubtitle': 'تـسـجيــل مـستـخـدم جـديــد',
      'username': 'اســم المستـخـدم',
      'enterValidUsername': 'أدخـل اســم المستـخـدم',
      'phone': 'التـليـفـون',
      'enterValidPhone': 'أدخـل التـليـفـون',
      'passwordsNotIdentical': 'كـلمـات المـرور غيـر متطبقتـان',
      'confirmPassword': 'تـأكيـد كـلمـة المـرور',
      'enterValidConfirmPassword': 'أدخـل تـأكـيد كـلمـة المـرور',
      'haveAnAccount': 'لــديـــك حســـاب',
      'home': 'الرئيـسيـة',
      'login': 'تـسجيـل الدخــول',
      'logout': 'تـسجيـل خــروج',
      'branches': 'الفــروع',
      'waitingTickets': 'تذاكر الانتظار',
      'closedTickets': 'تذاكر مغلقة',
      'missedTickets': 'تذاكر فائتة',
      'noWaitingTickets': 'لا توجد تذاكر انتظار متاحة اليوم',
      'noClosedTickets': 'لا توجد تذاكر مغلقة متاحة اليوم',
      'noMissedTickets': 'لا توجد تذاكر فائتة متاحة اليوم'
    },
  };

  String get noWaitingTickets {
    return _localizedValues[locale.languageCode]['noWaitingTickets'];
  }

  String get noClosedTickets {
    return _localizedValues[locale.languageCode]['noClosedTickets'];
  }

  String get noMissedTickets {
    return _localizedValues[locale.languageCode]['noMissedTickets'];
  }

  String get waitingTickets {
    return _localizedValues[locale.languageCode]['waitingTickets'];
  }

  String get closedTickets {
    return _localizedValues[locale.languageCode]['closedTickets'];
  }

  String get missedTickets {
    return _localizedValues[locale.languageCode]['missedTickets'];
  }

  String get home {
    return _localizedValues[locale.languageCode]['home'];
  }

  String get login {
    return _localizedValues[locale.languageCode]['login'];
  }

  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  String get branches {
    return _localizedValues[locale.languageCode]['branches'];
  }

  String get loginTitle {
    return _localizedValues[locale.languageCode]['loginTitle'];
  }

  String get loginSubtitle {
    return _localizedValues[locale.languageCode]['loginSubtitle'];
  }

  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }

  String get enterValidEmail {
    return _localizedValues[locale.languageCode]['enterValidEmail'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get enterValidPassword {
    return _localizedValues[locale.languageCode]['enterValidPassword'];
  }

  String get forgetPassword {
    return _localizedValues[locale.languageCode]['forgetPassword'];
  }

  String get conditionTitle {
    return _localizedValues[locale.languageCode]['conditionTitle'];
  }

  String get termsAndConditions {
    return _localizedValues[locale.languageCode]['termsAndConditions'];
  }

  String get termsAndConditionValidation {
    return _localizedValues[locale.languageCode]['termsAndConditionValidation'];
  }

  String get signIn {
    return _localizedValues[locale.languageCode]['signIn'];
  }

  String get dontHaveAccount {
    return _localizedValues[locale.languageCode]['dontHaveAccount'];
  }

  String get signUp {
    return _localizedValues[locale.languageCode]['signUp'];
  }

  String get signUpTitle {
    return _localizedValues[locale.languageCode]['signUpTitle'];
  }

  String get signUpSubtitle {
    return _localizedValues[locale.languageCode]['signUpSubtitle'];
  }

  String get username {
    return _localizedValues[locale.languageCode]['username'];
  }

  String get enterValidUsername {
    return _localizedValues[locale.languageCode]['enterValidUsername'];
  }

  String get phone {
    return _localizedValues[locale.languageCode]['phone'];
  }

  String get enterValidPhone {
    return _localizedValues[locale.languageCode]['enterValidPhone'];
  }

  String get passwordsNotIdentical {
    return _localizedValues[locale.languageCode]['passwordsNotIdentical'];
  }

  String get confirmPassword {
    return _localizedValues[locale.languageCode]['confirmPassword'];
  }

  String get enterValidConfirmPassword {
    return _localizedValues[locale.languageCode]['enterValidConfirmPassword'];
  }

  String get haveAnAccount {
    return _localizedValues[locale.languageCode]['haveAnAccount'];
  }

  String get generateTicket {
    return _localizedValues[locale.languageCode]['generateTicket'];
  }

  String get branch {
    return _localizedValues[locale.languageCode]['branch'];
  }

  String get department {
    return _localizedValues[locale.languageCode]['department'];
  }

  String get ticketState {
    return _localizedValues[locale.languageCode]['ticketState'];
  }

  String get yourCode {
    return _localizedValues[locale.languageCode]['yourCode'];
  }

  String get currentNumber {
    return _localizedValues[locale.languageCode]['currentNumber'];
  }

  String get welcome {
    return _localizedValues[locale.languageCode]['welcome'];
  }

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
