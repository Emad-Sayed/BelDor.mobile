import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/login_screen.dart';
import 'package:bel_dor/utils/app_localization.dart';
import 'package:bel_dor/utils/background_widget.dart';
import 'package:bel_dor/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false,
      isPassword = true,
      isConfirmPassword = true,
      termsAccepted = false,
      showError = false;

  String errorText = "";

  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var confirmPasswordCont = TextEditingController();
  var usernameCont = TextEditingController();
  var phoneNumberCont = TextEditingController();

  final usernameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();
  final phoneKey = GlobalKey<FormFieldState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailCont.dispose();
    passwordCont.dispose();
    confirmPasswordCont.dispose();
    usernameCont.dispose();
    phoneNumberCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            key: mainKey,
            body: Container(
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
                      AppLocalizations.of(context).signUpTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppColors.ACCENT_COLOR),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      AppLocalizations.of(context).signUpSubtitle,
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
                            //username
                            Text(
                              AppLocalizations.of(context).username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            TextFormField(
                              key: usernameKey,
                              controller: usernameCont,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .enterValidUsername;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.supervised_user_circle,
                                  size: 30,
                                  color: AppColors.ACCENT_COLOR,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.ACCENT_COLOR,
                                  ),
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

                            //Email
                            Text(
                              AppLocalizations.of(context).email,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            TextFormField(
                              controller: emailCont,
                              key: emailKey,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return AppLocalizations.of(context)
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
                                  borderSide: BorderSide(
                                    color: AppColors.ACCENT_COLOR,
                                  ),
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

                            //Phone 1
                            Text(
                              AppLocalizations.of(context).phone,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            TextFormField(
                              key: phoneKey,
                              controller: phoneNumberCont,
                              validator: (value) {
                                if (value.isEmpty)
                                  return AppLocalizations.of(context)
                                      .enterValidPhone;
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  size: 30,
                                  color: AppColors.ACCENT_COLOR,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.ACCENT_COLOR,
                                  ),
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

                            //password
                            Text(AppLocalizations.of(context).password,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0)),
                            TextFormField(
                              key: passwordKey,
                              controller: passwordCont,
                              obscureText: isPassword,
                              validator: (value) {
                                print(value +
                                    " + " +
                                    confirmPasswordCont.text.toString());
                                if (value.isEmpty)
                                  return AppLocalizations.of(context)
                                      .enterValidPassword;
                                else if (value !=
                                    confirmPasswordCont.text.toString())
                                  return AppLocalizations.of(context)
                                      .passwordsNotIdentical;
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
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  size: 30,
                                  color: AppColors.ACCENT_COLOR,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.ACCENT_COLOR,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),

                            //confirm password
                            Text(AppLocalizations.of(context).confirmPassword,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0)),
                            TextFormField(
                              key: confirmPasswordKey,
                              controller: confirmPasswordCont,
                              obscureText: isConfirmPassword,
                              validator: (value) {
                                print(value +
                                    " + " +
                                    passwordCont.text.toString());
                                if (value.isEmpty)
                                  return AppLocalizations.of(context)
                                      .enterValidConfirmPassword;
                                else if (value != passwordCont.text.toString())
                                  return AppLocalizations.of(context)
                                      .passwordsNotIdentical;
                                return null;
                              },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isConfirmPassword = !isConfirmPassword;
                                    });
                                  },
                                  child: Icon(
                                    isConfirmPassword
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
                                  borderSide: BorderSide(
                                    color: AppColors.ACCENT_COLOR,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
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
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.ACCENT_COLOR,
                          )),
                      subtitle: Text(
                        AppLocalizations.of(context).termsAndConditions,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.PRIMARY_COLOR,
                        ),
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
                              if (usernameKey.currentState.validate() &&
                                  emailKey.currentState.validate() &&
                                  passwordKey.currentState.validate() &&
                                  confirmPasswordKey.currentState.validate() &&
                                  phoneKey.currentState.validate() &&
                                  termsAccepted) {
                                setState(() {
                                  isLoading = true;
                                });
                                NetworkClient()
                                    .register(
                                        username: usernameCont.text.toString(),
                                        email: emailCont.text.toString(),
                                        phone: phoneNumberCont.text.toString(),
                                        password: passwordCont.text.toString())
                                    .then((result) {
                                  if (result is SuccessState) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginScreen()),
                                    );
                                  } else {
                                    setState(() {
                                      errorText =
                                          (result as ErrorState).msg.errorEN;
                                      showError = true;
                                    });
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              } else if (!termsAccepted) {
                                setState(() {
                                  errorText = AppLocalizations.of(context)
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
                                AppLocalizations.of(context).signUp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: AppColors.PRIMARY_DARK_COLOR,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).haveAnAccount,
                          style: TextStyle(
                            color: AppColors.ACCENT_COLOR,
                          ),
                        ),
                        Container(
                          child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(AppLocalizations.of(context).signIn,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.PRIMARY_COLOR,
                                        fontSize: 16.0)),
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen()),
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
    );
  }
}
