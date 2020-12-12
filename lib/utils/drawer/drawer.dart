import 'dart:ui';

import 'package:bel_dor/main.dart';
import 'package:bel_dor/screen/branches_screen.dart';
import 'package:bel_dor/screen/home_page_screen.dart';
import 'package:bel_dor/screen/login_screen.dart';
import 'package:bel_dor/screen/tickets_history_filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../app_localization.dart';
import '../preference_utils.dart';
import '../shared_fields.dart';
import 'drawer_model.dart';

class MyDrawer extends StatefulWidget {
  final int drawerIndex;

  MyDrawer(this.drawerIndex);

  @override
  _MyDrawerState createState() => _MyDrawerState(drawerIndex);
}

class _MyDrawerState extends State<MyDrawer> {
  String chosenCountry;
  String chosenLanguage;
  int selectedMenuItemId;
  final int drawerIndex;

  _MyDrawerState(this.drawerIndex);

  @override
  void initState() {
    setState(() {
      chosenCountry = PreferenceUtils.getString(SharedFields.COUNTRY, "");
    });
    selectedMenuItemId = drawerIndex;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (AppLocalizations.of(context).languageCode == "en")
      chosenLanguage = AppLocalizations.of(context).english;
    else if (AppLocalizations.of(context).languageCode == "ar")
      chosenLanguage = AppLocalizations.of(context).arabic;

    super.didChangeDependencies();
  }

  Widget _getHeader() {
    var user =
        JwtDecoder.decode(PreferenceUtils.getString(SharedFields.TOKEN, ""));
    ;
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
                  user != null
                      ? user['Name']
                      : AppLocalizations
                      .of(context)
                      .welcome,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).yourCode,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      user["Id"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
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
          drawerTitle: AppLocalizations.of(context).home,
          drawerIcon: Icons.home,
          navigateTo: MyHomePage()),
      DrawerModel(
          drawerTitle: AppLocalizations
              .of(context)
              .login,
          drawerIcon: Icons.chevron_right,
          navigateTo: LoginScreen()),
      DrawerModel(
          drawerTitle: AppLocalizations
              .of(context)
              .branches,
          drawerIcon: Icons.category,
          navigateTo: BranchesScreen()),
      DrawerModel(
          drawerTitle: AppLocalizations
              .of(context)
              .ticketsHistory,
          drawerIcon: Icons.history,
          navigateTo: TicketsHistoryFilter()),
      DrawerModel(
          drawerTitle: AppLocalizations
              .of(context)
              .logout,
          drawerIcon: Icons.chevron_left,
          navigateTo: null),
    ];
    bool isLoggedIn = PreferenceUtils.getBool(SharedFields.IS_LOGGED_IN, false);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        // Important: Remove any padding from the ListView.
        children: <Widget>[
          DrawerHeader(
            child: _getHeader(),
            decoration: BoxDecoration(
              color: Colors.black54,
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
                            ? Colors.black26
                            : Colors.transparent,
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      child: ListTile(
                        title: Text(
                          _drawerData[index].drawerTitle,
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: Icon(
                          _drawerData[index].drawerIcon,
                          color: Colors.black,
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
            alignment: AlignmentDirectional.bottomStart,
            child: ListTile(
              dense: false,
              title: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: chosenLanguage,
                  items: <String>[
                    AppLocalizations.of(context).english,
                    AppLocalizations.of(context).arabic
                  ].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      chosenLanguage = newValue;
                      if (newValue == AppLocalizations.of(context).english) {
                        PreferenceUtils.setString(SharedFields.LANGUAGE, 'en');
                      } else if (newValue ==
                          AppLocalizations.of(context).arabic) {
                        PreferenceUtils.setString(SharedFields.LANGUAGE, 'ar');
                      }
                      MyApp.restartApp(context);
                    });
                  },
                ),
              ),
              leading: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context).language,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
