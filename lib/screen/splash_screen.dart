import 'dart:async';

import 'package:bel_dor/screen/home_page_screen.dart';
import 'package:bel_dor/screen/login_screen.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/resources/LayoutUtils.dart';
import 'package:bel_dor/utils/resources/app_strings.dart';
import 'package:bel_dor/utils/shared_fields.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AppStrings.initiateLanguage();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                PreferenceUtils.getBool(SharedFields.IS_LOGGED_IN, false)
                    ? MyHomePage()
                    : LoginScreen()),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutUtils.wrapWithtinLayoutDirection(
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: AppColors.PRIMARY_DARK_COLOR,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Image(
              image: AssetImage("assets/images/beldoor_logo.png"),
            ),
          ),
        ),
      ),
    );
  }
}
