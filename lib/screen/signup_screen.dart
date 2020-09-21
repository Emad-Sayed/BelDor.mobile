import 'package:bel_dor/networking/network_client.dart';
import 'package:bel_dor/networking/result.dart';
import 'package:bel_dor/screen/login_screen.dart';
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
                    'Getting Started',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Create a new account',
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
                          //username
                          Text(
                            'Username',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          TextFormField(
                            key: usernameKey,
                            controller: usernameCont,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Username";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.supervised_user_circle,
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

                          //Email
                          Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          TextFormField(
                            controller: emailCont,
                            key: emailKey,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Email";
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

                          //Phone 1
                          Text(
                            'Phone',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                          TextFormField(
                            key: phoneKey,
                            controller: phoneNumberCont,
                            validator: (value) {
                              if (value.isEmpty) return "Please Enter Phone";
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
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

                          //password
                          Text('Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          TextFormField(
                            key: passwordKey,
                            controller: passwordCont,
                            obscureText: isPassword,
                            validator: (value) {
                              print(value +
                                  " + " +
                                  confirmPasswordCont.text.toString());
                              if (value.isEmpty)
                                return "Please Enter Password";
                              else if (value !=
                                  confirmPasswordCont.text.toString())
                                return "passwords are not identical";
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
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
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
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),

                          //confirm password
                          Text('Confirm Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          TextFormField(
                            key: confirmPasswordKey,
                            controller: confirmPasswordCont,
                            obscureText: isConfirmPassword,
                            validator: (value) {
                              print(
                                  value + " + " + passwordCont.text.toString());
                              if (value.isEmpty)
                                return "Please Enter Confirmation Password";
                              else if (value != passwordCont.text.toString())
                                return "passwords are not identical";
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
                    title: Text('By Creating an account, you agree to our',
                        style: TextStyle(fontSize: 14.0)),
                    subtitle: Text(
                      'Terms and Conditions',
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
                                errorText = "Please accept our terms";
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
                              'Sign Up',
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
                        'Have an Account',
                      ),
                      Container(
                        child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('Sign In',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
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
        ],
      ),
    );
  }
}
