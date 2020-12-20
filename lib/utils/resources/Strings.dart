import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'ArbStrings.dart';
import 'EngStrings.dart';

class Strings {
  static bool english = true;

  static Future initiateLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    english = prefs.getBool("languagePreference");
    if (english == null) setLanguage(true);
  }

  static Future setLanguage(bool english) async {
    Strings.english = english;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("languagePreference", english);
  }

  static String waveERP() {
    return "Wave ERP";
  }

  static String search() {
    return english ? EngStrings.SEARCH : ArbStrings.SEARCH;
  }

  static String toDoList() {
    return english ? EngStrings.TO_DO_LIST : ArbStrings.TO_DO_LIST;
  }

  static String home() {
    return english ? EngStrings.HOME : ArbStrings.HOME;
  }

  static String intro() {
    return english ? EngStrings.INTRO : ArbStrings.INTRO;
  }

  static String comments() {
    return english ? EngStrings.COMMENTS : ArbStrings.COMMENTS;
  }

  static String pageName() {
    return english ? EngStrings.PAGE_NAME : ArbStrings.PAGE_NAME;
  }

  static String submitDate() {
    return english ? EngStrings.SUBMIT_DATE : ArbStrings.SUBMIT_DATE;
  }

  static String notes() {
    return english ? EngStrings.NOTES : ArbStrings.NOTES;
  }

  static String filter() {
    return english ? EngStrings.FILTER : ArbStrings.FILTER;
  }

  static String New() {
    return english ? EngStrings.NEW : ArbStrings.NEW;
  }

  static String earlier() {
    return english ? EngStrings.EARLIER : ArbStrings.EARLIER;
  }

  static String notifications() {
    return english ? EngStrings.NOTIFICATIONS : ArbStrings.NOTIFICATIONS;
  }

  static String itemNo() {
    return english ? EngStrings.ITEM_NO : ArbStrings.ITEM_NO;
  }

  static String itemName() {
    return english ? EngStrings.ITEM_NAME : ArbStrings.ITEM_NAME;
  }

  static String minStorageLimit() {
    return english
        ? EngStrings.MIN_STORAGE_LIMIT
        : ArbStrings.MIN_STORAGE_LIMIT;
  }

  static String balance() {
    return english ? EngStrings.BALANCE : ArbStrings.BALANCE;
  }

  static String delete() {
    return english ? EngStrings.DELETE : ArbStrings.DELETE;
  }

  static String menu() {
    return english ? EngStrings.MENU : ArbStrings.MENU;
  }

  static String leaves() {
    return english ? EngStrings.LEAVES : ArbStrings.LEAVES;
  }

  static String vacations() {
    return english ? EngStrings.VACATIONS : ArbStrings.VACATIONS;
  }

  static String suppliesRequest() {
    return english
        ? EngStrings.SUPPLIEAS_REQUEST
        : ArbStrings.SUPPLIEAS_REQUEST;
  }

  static String changeLanguage() {
    return english ? EngStrings.CHANGE_LANGUAGE : ArbStrings.CHANGE_LANGUAGE;
  }

  static String logOut() {
    return english ? EngStrings.LOG_OUT : ArbStrings.LOG_OUT;
  }

  static String save() {
    return english ? EngStrings.SAVE : ArbStrings.SAVE;
  }

  static String from() {
    return english ? EngStrings.FROM : ArbStrings.FROM;
  }

  static String to() {
    return english ? EngStrings.TO : ArbStrings.TO;
  }

  static String leaveDate() {
    return english ? EngStrings.LEAVE_DATE : ArbStrings.LEAVE_DATE;
  }

  static String balancesGroup() {
    return english ? EngStrings.BALANCES_GROUP : ArbStrings.BALANCES_GROUP;
  }

  static String fromDate() {
    return english ? EngStrings.FROM_DATE : ArbStrings.FROM_DATE;
  }

  static String toDate() {
    return english ? EngStrings.TO_DATE : ArbStrings.TO_DATE;
  }

  static String phoneNo() {
    return english ? EngStrings.PHONE_NO : ArbStrings.PHONE_NO;
  }

  static String reason() {
    return english ? EngStrings.REASON : ArbStrings.REASON;
  }

  static String requestType() {
    return english ? EngStrings.REQUEST_TYPE : ArbStrings.REQUEST_TYPE;
  }

  static String project() {
    return english ? EngStrings.PROJECT : ArbStrings.PROJECT;
  }

  static String causeOfTransaction() {
    return english
        ? EngStrings.CAUSE_OF_TRANSACTION
        : ArbStrings.CAUSE_OF_TRANSACTION;
  }

  static String voucherDescription() {
    return english
        ? EngStrings.VOUCHER_DESCRIPTION
        : ArbStrings.VOUCHER_DESCRIPTION;
  }

  static String dueDate() {
    return english ? EngStrings.DUE_DATE : ArbStrings.DUE_DATE;
  }

  static String searchItems() {
    return english ? EngStrings.SEARCH_ITEMS : ArbStrings.SEARCH_ITEMS;
  }

  static String add() {
    return english ? EngStrings.ADD : ArbStrings.ADD;
  }

  static String unselect() {
    return english ? EngStrings.UNSELECT : ArbStrings.UNSELECT;
  }

  static String itemsCard() {
    return english ? EngStrings.ITEMS_CARD : ArbStrings.ITEMS_CARD;
  }

  static String quantity() {
    return english ? EngStrings.QUANTITY : ArbStrings.QUANTITY;
  }

  static String select() {
    return english ? EngStrings.SELECT : ArbStrings.SELECT;
  }

  static String submit() {
    return english ? EngStrings.SUBMIT : ArbStrings.SUBMIT;
  }

  static String personalInformations() {
    return english
        ? EngStrings.PERSONAL_INFORMATIONS
        : ArbStrings.PERSONAL_INFORMATIONS;
  }

  static String shortName() {
    return english ? EngStrings.SHORT_NAME : ArbStrings.SHORT_NAME;
  }

  static String lastName() {
    return english ? EngStrings.LAST_NAME : ArbStrings.LAST_NAME;
  }

  static String gender() {
    return english ? EngStrings.GENDER : ArbStrings.GENDER;
  }

  static String nationality() {
    return english ? EngStrings.NATIONALITY : ArbStrings.NATIONALITY;
  }

  static String religion() {
    return english ? EngStrings.RELIGION : ArbStrings.RELIGION;
  }

  static String contacts() {
    return english ? EngStrings.CONTACTS : ArbStrings.CONTACTS;
  }

  static String email() {
    return english ? EngStrings.EMAIL : ArbStrings.EMAIL;
  }

  static String phone() {
    return english ? EngStrings.PHONE : ArbStrings.PHONE;
  }

  static String generalInformation() {
    return english
        ? EngStrings.GENERAL_INFORMATIONS
        : ArbStrings.GENERAL_INFORMATIONS;
  }

  static String contactClassification() {
    return english
        ? EngStrings.CONTACT_CLASSIFICATIONS
        : ArbStrings.CONTACT_CLASSIFICATIONS;
  }

  static String contactType() {
    return english ? EngStrings.CONTACT_TYPE : ArbStrings.CONTACT_TYPE;
  }

  static String mainContact() {
    return english ? EngStrings.MAIN_CONTACT : ArbStrings.MAIN_CONTACT;
  }

  static String classification() {
    return english ? EngStrings.CLASSIFICATION : ArbStrings.CLASSIFICATION;
  }

  static String contactMethod() {
    return english ? EngStrings.CONTACT_METHOD : ArbStrings.CONTACT_METHOD;
  }

  static String changePassword() {
    return english ? EngStrings.CHANGE_PASSWORD : ArbStrings.CHANGE_PASSWORD;
  }

  static String oldPassword() {
    return english ? EngStrings.OLD_PASSWORD : ArbStrings.OLD_PASSWORD;
  }

  static String newPassword() {
    return english ? EngStrings.NEW_PASSWORD : ArbStrings.NEW_PASSWORD;
  }

  static String newPasswordConfirmation() {
    return english
        ? EngStrings.NEW_PASSWORD_CONFIRMATION
        : ArbStrings.NEW_PASSWORD_CONFIRMATION;
  }

  static String username() {
    return english ? EngStrings.USERNAME : ArbStrings.USERNAME;
  }

  static String password() {
    return english ? EngStrings.PASSWORD : ArbStrings.PASSWORD;
  }

  static String keepMeloggedIn() {
    return english
        ? EngStrings.KEEP_ME_LOGGED_IN
        : ArbStrings.KEEP_ME_LOGGED_IN;
  }

  static String signIn() {
    return english ? EngStrings.SIGN_IN : ArbStrings.SIGN_IN;
  }

  static String accept() {
    return english ? EngStrings.ACCEPT : ArbStrings.ACCEPT;
  }

  static String reject() {
    return english ? EngStrings.REJECT : ArbStrings.REJECT;
  }

  static String profile() {
    return english ? EngStrings.PROFILE : ArbStrings.PROFILE;
  }

  static String detailsTitle() {
    return english ? EngStrings.DETAILS_TITLE : ArbStrings.DETAILS_TITLE;
  }

  static String noPasswordMatch() {
    return english
        ? EngStrings.NO_PASSWORD_MATCH
        : ArbStrings.NO_PASSWORD_MATCH;
  }

  //validations
  static String plsFrom() {
    return english ? EngStrings.PLS_FROM : ArbStrings.PLS_FROM;
  }

  static String plsTo() {
    return english ? EngStrings.PLS_TO : ArbStrings.PLS_TO;
  }

  static String plsLeaveDate() {
    return english ? EngStrings.PLS_LEAVE_DATE : ArbStrings.PLS_LEAVE_DATE;
  }

  static String plsBalanceGroup() {
    return english
        ? EngStrings.PLS_BALANCES_GROUP
        : ArbStrings.PLS_BALANCES_GROUP;
  }

  static String plsUserName() {
    return english ? EngStrings.PLS_USERNAME : ArbStrings.PLS_USERNAME;
  }

  static String plsPassword() {
    return english ? EngStrings.PLS_PASSWORD : ArbStrings.PLS_PASSWORD;
  }

  static String plsOldPassword() {
    return english ? EngStrings.PLS_OLD_PASSWORD : ArbStrings.PLS_OLD_PASSWORD;
  }

  static String plsNewPassword() {
    return english ? EngStrings.PLS_NEW_PASSWORD : ArbStrings.PLS_NEW_PASSWORD;
  }

  static String plsConfirmNewPassword() {
    return english
        ? EngStrings.PLS_NEW_PASSWORD_CONFIRMATION
        : ArbStrings.PLS_NEW_PASSWORD_CONFIRMATION;
  }

  static String plsFromDate() {
    return english ? EngStrings.PLS_FROM_DATE : ArbStrings.PLS_FROM_DATE;
  }

  static String plsToDate() {
    return english ? EngStrings.PLS_TO_DATE : ArbStrings.PLS_TO_DATE;
  }

  static String areYouSure() {
    return english ? EngStrings.ARE_U_SURE : ArbStrings.ARE_U_SURE;
  }

  static String plsValidDate() {
    return english ? EngStrings.PLS_VALID_DATE : ArbStrings.PLS_VALID_DATE;
  }

  static String verifyFromToTime() {
    return english ? EngStrings.VRFY_FROM_TO : ArbStrings.VRFY_FROM_TO;
  }

  static String verifyLeaveDate() {
    return english ? EngStrings.VRFY_LEAVE_DATE : ArbStrings.VRFY_LEAVE_DATE;
  }

  static String verifyFromToDate() {
    return english
        ? EngStrings.VRFY_FROM_TO_DATE
        : ArbStrings.VRFY_FROM_TO_DATE;
  }

  static String plsItemsCard() {
    return english ? EngStrings.PLS_ITEMS_CARD : ArbStrings.PLS_ITEMS_CARD;
  }

  static String plsRequestType() {
    return english ? EngStrings.PLS_REQUEST_TYPE : ArbStrings.PLS_REQUEST_TYPE;
  }

  static String plsProject() {
    return english ? EngStrings.PLS_PROJECT : ArbStrings.PLS_PROJECT;
  }

  static String plsCauseOfTransaction() {
    return english
        ? EngStrings.PLS_CAUSE_OF_TRANSACTION
        : ArbStrings.PLS_CAUSE_OF_TRANSACTION;
  }

  static String plsDueDate() {
    return english ? EngStrings.PLS_DUE_DATE : ArbStrings.PLS_DUE_DATE;
  }

  static String landingSearch() {
    return english ? EngStrings.LANDING_SEARCH : ArbStrings.LANDING_SEARCH;
  }

  static String plsValidProjectName() {
    return english
        ? EngStrings.PLS_VALID_PROJECT_NAME
        : ArbStrings.PLS_VALID_PROJECT_NAME;
  }

  static String plsValidUserNamePassword() {
    return english
        ? EngStrings.PLS_VALID_USERNAME_PASSWORD
        : ArbStrings.PLS_VALID_USERNAME_PASSWORD;
  }

  static String plsOneItem() {
    return english ? EngStrings.PLS_ONE_ITEM : ArbStrings.PLS_ONE_ITEM;
  }

  static String checkNet() {
    return english ? EngStrings.CHECK_NET : ArbStrings.CHECK_NET;
  }

  static String vacationBalanceGroupEndPoint() {
    return "GetEmployeeVacationsBalanceGroup";
  }

  static String leavesBalanceGroupEndPoint() {
    return "GetEmployeeLeavesBalanceGroup";
  }
}
