import 'dart:async';

import 'package:bel_dor/screen/home_page_screen.dart';
import 'package:bel_dor/screen/login_screen.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/shared_fields.dart';
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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 90.0, vertical: 20.0),
                child: Image(
                  image: AssetImage("assets/images/splash_image.png"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Image(
                    image: AssetImage("assets/images/splash_star.png"),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
