import 'dart:async';

import '../preference_utils.dart';
import '../shared_fields.dart';
import 'ar_strings.dart';
import 'en_strings.dart';

class AppStrings {
  static bool isEnglish = true;

  static void initiateLanguage() {
    isEnglish = PreferenceUtils.getBool(SharedFields.LANGUAGE, true);
  }

  static Future setLanguage(bool english) async {
    AppStrings.isEnglish = english;
    await PreferenceUtils.setBool(SharedFields.LANGUAGE, english);
  }

  static String get search {
    return isEnglish ? EngStrings.SEARCH : ArbStrings.SEARCH;
  }

  static String get selectAll {
    return isEnglish ? EngStrings.SELECT_ALL : ArbStrings.SELECT_ALL;
  }

  static String get ok {
    return isEnglish ? EngStrings.OK : ArbStrings.OK;
  }

  static String get cancel {
    return isEnglish ? EngStrings.CANCEL : ArbStrings.CANCEL;
  }

  static String get pleaseSelectOneOrMore {
    return isEnglish
        ? EngStrings.PLEASE_SELECT_ONE_OR_MORE
        : ArbStrings.PLEASE_SELECT_ONE_OR_MORE;
  }

  static String get ticketStates {
    return isEnglish ? EngStrings.TICKET_STATES : ArbStrings.TICKET_STATES;
  }

  static String get submit {
    return isEnglish ? EngStrings.SUBMIT : ArbStrings.SUBMIT;
  }

  static String get filtrationToShowTicketsHistory {
    return isEnglish
        ? EngStrings.FILTRATION_TO_SHOW_TICKETS_HISTORY
        : ArbStrings.FILTRATION_TO_SHOW_TICKETS_HISTORY;
  }

  static String get ticketDate {
    return isEnglish ? EngStrings.TICKET_DATE : ArbStrings.TICKET_DATE;
  }

  static String get ticketsHistory {
    return isEnglish ? EngStrings.TICKETS_HISTORY : ArbStrings.TICKETS_HISTORY;
  }

  static String get noWaitingTickets {
    return isEnglish
        ? EngStrings.NO_WAITING_TICKETS
        : ArbStrings.NO_WAITING_TICKETS;
  }

  static String get noClosedTickets {
    return isEnglish
        ? EngStrings.NO_CLOSED_TICKETS
        : ArbStrings.NO_CLOSED_TICKETS;
  }

  static String get noMissedTickets {
    return isEnglish
        ? EngStrings.NO_MISSED_TICKETS
        : ArbStrings.NO_MISSED_TICKETS;
  }

  static String get noHistoryTickets {
    return isEnglish
        ? EngStrings.NO_HISTORY_TICKETS
        : ArbStrings.NO_HISTORY_TICKETS;
  }

  static String get waitingTickets {
    return isEnglish ? EngStrings.WAITING_TICKETS : ArbStrings.WAITING_TICKETS;
  }

  static String get closedTickets {
    return isEnglish ? EngStrings.CLOSED_TICKETS : ArbStrings.CLOSED_TICKETS;
  }

  static String get missedTickets {
    return isEnglish ? EngStrings.MISSED_TICKETS : ArbStrings.MISSED_TICKETS;
  }

  static String get home {
    return isEnglish ? EngStrings.HOME : ArbStrings.HOME;
  }

  static String get login {
    return isEnglish ? EngStrings.LOGIN : ArbStrings.LOGIN;
  }

  static String get logout {
    return isEnglish ? EngStrings.LOGOUT : ArbStrings.LOGOUT;
  }

  static String get branches {
    return isEnglish ? EngStrings.BRANCHES : ArbStrings.BRANCHES;
  }

  static String get departments {
    return isEnglish ? EngStrings.DEPARTMENTS : ArbStrings.DEPARTMENTS;
  }

  static String get loginTitle {
    return isEnglish ? EngStrings.LOGIN_TITLE : ArbStrings.LOGIN_TITLE;
  }

  static String get loginSubtitle {
    return isEnglish ? EngStrings.LOGIN_SUBTITLE : ArbStrings.LOGIN_SUBTITLE;
  }

  static String get email {
    return isEnglish ? EngStrings.EMAIL : ArbStrings.EMAIL;
  }

  static String get enterValidEmail {
    return isEnglish
        ? EngStrings.ENTER_VALID_EMAIL
        : ArbStrings.ENTER_VALID_EMAIL;
  }

  static String get password {
    return isEnglish ? EngStrings.PASSWORD : ArbStrings.PASSWORD;
  }

  static String get enterValidPassword {
    return isEnglish
        ? EngStrings.ENTER_VALID_PASSWORD
        : ArbStrings.ENTER_VALID_PASSWORD;
  }

  static String get forgetPassword {
    return isEnglish ? EngStrings.FORGET_PASSWORD : ArbStrings.FORGET_PASSWORD;
  }

  static String get conditionTitle {
    return isEnglish ? EngStrings.CONDITION_TITLE : ArbStrings.CONDITION_TITLE;
  }

  static String get termsAndConditions {
    return isEnglish
        ? EngStrings.TERMS_AND_CONDITIONS
        : ArbStrings.TERMS_AND_CONDITIONS;
  }

  static String get termsAndConditionValidation {
    return isEnglish
        ? EngStrings.TERMS_AND_CONDITION_VALIDATION
        : ArbStrings.TERMS_AND_CONDITION_VALIDATION;
  }

  static String get signIn {
    return isEnglish ? EngStrings.SIGN_IN : ArbStrings.SIGN_IN;
  }

  static String get dontHaveAccount {
    return isEnglish
        ? EngStrings.DONT_HAVE_ACCOUNT
        : ArbStrings.DONT_HAVE_ACCOUNT;
  }

  static String get signUp {
    return isEnglish ? EngStrings.SIGN_UP : ArbStrings.SIGN_UP;
  }

  static String get signUpTitle {
    return isEnglish ? EngStrings.SIGN_UP_TITLE : ArbStrings.SIGN_UP_TITLE;
  }

  static String get signUpSubtitle {
    return isEnglish
        ? EngStrings.SIGN_UP_SUBTITLE
        : ArbStrings.SIGN_UP_SUBTITLE;
  }

  static String get username {
    return isEnglish ? EngStrings.USERNAME : ArbStrings.USERNAME;
  }

  static String get enterValidUsername {
    return isEnglish
        ? EngStrings.ENTER_VALID_USERNAME
        : ArbStrings.ENTER_VALID_USERNAME;
  }

  static String get phone {
    return isEnglish ? EngStrings.PHONE : ArbStrings.PHONE;
  }

  static String get enterValidPhone {
    return isEnglish
        ? EngStrings.ENTER_VALID_PHONE
        : ArbStrings.ENTER_VALID_PHONE;
  }

  static String get passwordsNotIdentical {
    return isEnglish
        ? EngStrings.PASSWORDS_NOT_IDENTICAL
        : ArbStrings.PASSWORDS_NOT_IDENTICAL;
  }

  static String get confirmPassword {
    return isEnglish
        ? EngStrings.CONFIRM_PASSWORD
        : ArbStrings.CONFIRM_PASSWORD;
  }

  static String get enterValidConfirmPassword {
    return isEnglish
        ? EngStrings.ENTER_VALID_CONFIRM_PASSWORD
        : ArbStrings.ENTER_VALID_CONFIRM_PASSWORD;
  }

  static String get haveAnAccount {
    return isEnglish ? EngStrings.HAVE_AN_ACCOUNT : ArbStrings.HAVE_AN_ACCOUNT;
  }

  static String get generateTicket {
    return isEnglish
        ? EngStrings.GENERATE_A_TICKET
        : ArbStrings.GENERATE_A_TICKET;
  }

  static String get branch {
    return isEnglish ? EngStrings.BRANCH : ArbStrings.BRANCH;
  }

  static String get department {
    return isEnglish ? EngStrings.DEPARTMENT : ArbStrings.DEPARTMENT;
  }

  static String get ticketState {
    return isEnglish ? EngStrings.TICKET_STATE : ArbStrings.TICKET_STATE;
  }

  static String get yourCode {
    return isEnglish ? EngStrings.YOUR_CODE : ArbStrings.YOUR_CODE;
  }

  static String get currentNumber {
    return isEnglish ? EngStrings.CURRENT_NUMBER : ArbStrings.CURRENT_NUMBER;
  }

  static String get welcome {
    return isEnglish ? EngStrings.WELCOME : ArbStrings.WELCOME;
  }

  static String get language {
    return isEnglish ? EngStrings.LANGUAGE : ArbStrings.LANGUAGE;
  }

  static String get arabic {
    return isEnglish ? EngStrings.ARABIC : ArbStrings.ARABIC;
  }

  static String get english {
    return isEnglish ? EngStrings.ENGLISH : ArbStrings.ENGLISH;
  }
}
