import 'dart:ui';

import 'package:bel_dor/screen/branches_screen.dart';
import 'package:bel_dor/screen/home_page_screen.dart';
import 'package:bel_dor/screen/login_screen.dart';
import 'package:bel_dor/screen/tickets_history_filter.dart';
import 'package:bel_dor/utils/resources/app_strings.dart';
import 'package:bel_dor/utils/resources/refresh_screen.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../preference_utils.dart';
import '../shared_fields.dart';
import 'drawer_model.dart';

class MyDrawer extends StatefulWidget {
  final int drawerIndex;
  final RefreshScreen refreshScreen;

  MyDrawer(this.drawerIndex, this.refreshScreen);

  @override
  _MyDrawerState createState() => _MyDrawerState(drawerIndex);
}

class _MyDrawerState extends State<MyDrawer> {
  String chosenLanguage;
  int selectedMenuItemId;
  final int drawerIndex;

  _MyDrawerState(this.drawerIndex);

  @override
  void initState() {
    selectedMenuItemId = drawerIndex;
    super.initState();
  }

  Widget _getHeader() {
    var user =
        JwtDecoder.decode(PreferenceUtils.getString(SharedFields.TOKEN, ""));
    return Row(
      children: [
        user != null
            ? ClipOval(
                child: CachedNetworkImage(
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.fitWidth,
                  imageUrl: "",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    radius: 40,
                  ),
                ),
              )
            : CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
                radius: 40,
                onBackgroundImageError: (exception, stackTrace) {},
              ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                child: Text(
                  user != null ? user['Name'] : AppStrings.welcome,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: AppColors.ACCENT_COLOR),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0),
                child: Row(
                  children: [
                    Text(
                      AppStrings.yourCode,
                      style: TextStyle(
                          fontSize: 16.0, color: AppColors.ACCENT_COLOR),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      user["Id"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppColors.ACCENT_COLOR),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<DrawerModel> _drawerData = [
      DrawerModel(
          drawerTitle: AppStrings.home,
          drawerIcon: Icons.home,
          navigateTo: MyHomePage()),
      DrawerModel(
          drawerTitle: AppStrings.login,
          drawerIcon: Icons.chevron_right,
          navigateTo: LoginScreen()),
      DrawerModel(
          drawerTitle: AppStrings.branches,
          drawerIcon: Icons.category,
          navigateTo: BranchesScreen()),
      DrawerModel(
          drawerTitle: AppStrings.ticketsHistory,
          drawerIcon: Icons.history,
          navigateTo: TicketsHistoryFilter()),
      DrawerModel(
          drawerTitle: AppStrings.logout,
          drawerIcon: Icons.chevron_left,
          navigateTo: null),
    ];
    bool isLoggedIn = PreferenceUtils.getBool(SharedFields.IS_LOGGED_IN, false);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: AppColors.DRAWER_BODY_COLOR,
        child: Column(
          // Important: Remove any padding from the ListView.
          children: <Widget>[
            DrawerHeader(
              child: _getHeader(),
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_DARK_COLOR,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: _drawerData.length,
                  itemBuilder: (context, index) {
                    print(index);
                    if (isLoggedIn && index == 1)
                      return Container();
                    else if (!isLoggedIn && index == 2)
                      return Container();
                    else if (!isLoggedIn && index == 3)
                      return Container();
                    else if (!isLoggedIn && index == 4)
                      return Container();
                    else
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: selectedMenuItemId == index
                              ? AppColors.PRIMARY_DARK_COLOR
                              : Colors.transparent,
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: ListTile(
                          title: Text(
                            _drawerData[index].drawerTitle,
                            style: TextStyle(
                                color: selectedMenuItemId == index
                                    ? AppColors.PRIMARY_COLOR
                                    : Colors.white),
                          ),
                          leading: Icon(
                            _drawerData[index].drawerIcon,
                            color: selectedMenuItemId == index
                                ? AppColors.PRIMARY_COLOR
                                : Colors.white,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            if (index == _drawerData.length - 1) {
                              PreferenceUtils.setBool(
                                  SharedFields.IS_LOGGED_IN, false);
                              PreferenceUtils.setString(SharedFields.TOKEN, "");
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginScreen()),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        _drawerData[index].navigateTo),
                              );
                            }
                          },
                        ),
                      );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppStrings.language,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.PRIMARY_COLOR),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Center(
                      child: FlutterSwitch(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 45,
                        activeTextColor: AppColors.PRIMARY_DARK_COLOR,
                        activeToggleColor: AppColors.PRIMARY_DARK_COLOR,
                        activeColor: AppColors.ACCENT_COLOR,
                        inactiveColor: AppColors.ACCENT_COLOR,
                        inactiveTextColor: AppColors.PRIMARY_DARK_COLOR,
                        inactiveToggleColor: Colors.grey,
                        valueFontSize: 20.0,
                        activeTextFontWeight: FontWeight.bold,
                        inactiveTextFontWeight: FontWeight.bold,
                        showOnOff: true,
                        toggleSize: 30.0,
                        value: AppStrings.isEnglish,
                        activeText: AppStrings.english,
                        inactiveText: AppStrings.arabic,
                        borderRadius: 30.0,
                        padding: 8,
                        onToggle: (value) {
                          setState(() {
                            AppStrings.setLanguage(value);
                          });
                          widget.refreshScreen.loadPage();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Card(
// elevation: 3.0,
// child: DropdownButtonHideUnderline(
// child: DropdownButton<String>(
// value: chosenLanguage,
// items: <String>[AppStrings.english, AppStrings.arabic]
// .map((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(
// value,
// style: TextStyle(color: AppColors.PRIMARY_COLOR),
// textAlign: TextAlign.center,
// ),
// );
// }).toList(),
// onChanged: (newValue) {
// setState(() {
// // chosenLanguage = newValue;
// if (newValue == AppStrings.english) {
// AppStrings.setLanguage(true);
// chosenLanguage = AppStrings.english;
// } else if (newValue == AppStrings.arabic) {
// AppStrings.setLanguage(false);
// chosenLanguage = AppStrings.arabic;
// }
// });
// widget.refreshScreen.loadPage();
// Navigator.pop(context);
// },
// ),
// ),
// ),
