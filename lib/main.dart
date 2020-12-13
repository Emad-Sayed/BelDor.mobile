import 'package:bel_dor/screen/splash_screen.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/app_localization.dart';
import 'utils/preference_utils.dart';
import 'utils/shared_fields.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>().restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: PreferenceUtils.init(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return KeyedSubtree(
              key: key,
              child: MaterialApp(
                locale: Locale(
                    PreferenceUtils.getString(SharedFields.LANGUAGE, "en")),
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context).title,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.delegate.supportedLocales,
                theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  // Define the default brightness and colors.
                  primaryColor: AppColors.PRIMARY_COLOR,
                  unselectedWidgetColor: AppColors.PRIMARY_COLOR,
                  accentColor: AppColors.ACCENT_COLOR,
                  primaryColorDark: AppColors.PRIMARY_DARK_COLOR,
                ),
                home: SplashScreen(),
              ));
        } else
          return Container(
            decoration: BoxDecoration(
                color: Color(0xff26362E),
                image: DecorationImage(
                    image: AssetImage("assets/images/pattern.png"),
                    fit: BoxFit.fitHeight)),
          );
      },
    );
  }
}
