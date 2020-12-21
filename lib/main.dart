import 'package:bel_dor/screen/splash_screen.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/resources/en_strings.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/preference_utils.dart';

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
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (BuildContext context) =>
                    EngStrings.TITLE,
                localizationsDelegates: [
                  // AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', ''),
                  const Locale('ar', ''),
                ],
                theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  // Define the default brightness and colors.
                  primaryColor: AppColors.PRIMARY_DARK_COLOR,
                  unselectedWidgetColor: AppColors.PRIMARY_COLOR,
                  accentColor: AppColors.ACCENT_COLOR,
                  primaryColorDark: AppColors.PRIMARY_DARK_COLOR,
                ),
                home: SplashScreen(),
              ));
        } else
          return BackgroundWidget();
      },
    );
  }
}
