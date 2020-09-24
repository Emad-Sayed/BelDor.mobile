import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/home_page_screen.dart';
import 'package:bel_dor/screen/signup_screen.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/shared_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false,
      isPassword = true,
      termsAccepted = false,
      showError = false;

  String errorText = "";

  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailCont.dispose();
    passwordCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            key: mainKey,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/splash_image.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Image.asset('assets/images/signIn_star.png'))
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    AppLocalizations.of(context).loginTitle,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).loginSubtitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color(0xFF757575),
                    ),
                  ),
                  SizedBox(
                    height: showError ? 8.0 : 16.0,
                  ),
                  Visibility(
                    visible: showError,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          errorText,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        leading: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).email,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          TextFormField(
                            key: emailKey,
                            controller: emailCont,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).enterValidEmail;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                size: 30,
                                color: Color(0xFF757575),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF757575)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(AppLocalizations.of(context).password,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          TextFormField(
                            controller: passwordCont,
                            obscureText: isPassword,
                            key: passwordKey,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).enterValidPassword;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                                child: Icon(
                                  isPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                size: 30,
                                color: Color(0xFF757575),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF757575)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0,
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 8.0),
                              child: Text(
                                AppLocalizations.of(context).forgetPassword,
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    value: termsAccepted,
                    title: Text(AppLocalizations.of(context).conditionTitle,
                        style: TextStyle(fontSize: 14.0)),
                    subtitle: Text(
                      AppLocalizations.of(context).termsAndConditions,
                      style:
                          TextStyle(fontSize: 14.0, color: Colors.blueAccent),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        termsAccepted = newValue;
                      });
                    },
                    dense: true,
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              errorText = "";
                              showError = false;
                            });
                            if (emailKey.currentState.validate() &&
                                passwordKey.currentState.validate() &&
                                termsAccepted) {
                              setState(() {
                                isLoading = true;
                              });
                              NetworkClient()
                                  .login(
                                      username: emailCont.text.toString(),
                                      password: passwordCont.text.toString())
                                  .then((result) {
                                if (result is SuccessState) {
                                  PreferenceUtils.setString(
                                      SharedFields.TOKEN, result.value.token);

                                  PreferenceUtils.setBool(
                                      SharedFields.IS_LOGGED_IN, true);

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyHomePage()),
                                  );
                                } else {
                                  mainKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                      (result as ErrorState).msg.message,
                                    ),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            } else if (!termsAccepted) {
                              setState(() {
                                errorText = AppLocalizations.of(context).termsAndConditionValidation;
                                showError = true;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.black54,
                            ),
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              AppLocalizations.of(context).signIn,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).dontHaveAccount,
                      ),
                      Container(
                        child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(AppLocalizations.of(context).signUp,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 16.0)),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUpScreen()),
                              );
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
