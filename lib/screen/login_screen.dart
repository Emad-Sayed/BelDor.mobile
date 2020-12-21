import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/home_page_screen.dart';
import 'package:bel_dor/screen/signup_screen.dart';
import 'package:bel_dor/utils/preference_utils.dart';
import 'package:bel_dor/utils/resources/LayoutUtils.dart';
import 'package:bel_dor/utils/resources/app_strings.dart';
import 'package:bel_dor/utils/shared_fields.dart';
import 'package:bel_dor/utils/utils.dart';
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
    return LayoutUtils.wrapWithtinLayoutDirection(
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              key: mainKey,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.PRIMARY_DARK_COLOR,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Image.asset(
                            'assets/images/beldoor_logo.png',
                            height: 150.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        AppStrings.loginTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: AppColors.ACCENT_COLOR),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        AppStrings.loginSubtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: AppColors.ACCENT_COLOR,
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
                        margin: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppStrings.email,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              TextFormField(
                                key: emailKey,
                                controller: emailCont,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return AppStrings
                                        .enterValidEmail;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 30,
                                    color: AppColors.ACCENT_COLOR,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.ACCENT_COLOR),
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
                              Text(AppStrings.password,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                              TextFormField(
                                controller: passwordCont,
                                obscureText: isPassword,
                                key: passwordKey,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return AppStrings
                                        .enterValidPassword;
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
                                      color: AppColors.ACCENT_COLOR,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    size: 30,
                                    color: AppColors.ACCENT_COLOR,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.ACCENT_COLOR),
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
                                    AppStrings.forgetPassword,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black),
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
                        activeColor: AppColors.ACCENT_COLOR,
                        checkColor: AppColors.PRIMARY_COLOR,
                        value: termsAccepted,
                        title: Text(AppStrings.conditionTitle,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.ACCENT_COLOR,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          AppStrings.termsAndConditions,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold),
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
                                    if (result is SuccessState &&
                                        result.value.roles[0] == "VISITOR") {
                                      PreferenceUtils.setString(
                                          SharedFields.TOKEN, result.value.token);

                                      PreferenceUtils.setBool(
                                          SharedFields.IS_LOGGED_IN, true);

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MyHomePage()),
                                      );
                                    } else if (result is SuccessState) {
                                      mainKey.currentState.showSnackBar(SnackBar(
                                        content: Text(
                                          (result as ErrorState).msg.message,
                                        ),
                                        duration: Duration(seconds: 3),
                                      ));
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
                                    errorText = AppStrings
                                        .termsAndConditionValidation;
                                    showError = true;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: AppColors.ACCENT_COLOR,
                                ),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 16.0),
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  AppStrings.signIn,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: AppColors.PRIMARY_DARK_COLOR,
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
                            AppStrings.dontHaveAccount,
                            style: TextStyle(color: AppColors.ACCENT_COLOR),
                          ),
                          Container(
                            child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(AppStrings.signUp,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: AppColors.PRIMARY_COLOR,
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
            ),
          ],
        ),
      ),
    );
  }
}
