import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/userAccounts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Dashboard.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  bool btnClicked = false;

  var scrollController = ScrollController();

  @override
  void initState() {
    userNameController.clear();
    passwordController.clear();
    btnClicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double width = size.width;
    double height = size.height;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Container(
        child: Scaffold(
          backgroundColor: Color(0XFFB5D3B6),
          appBar: AppBar(
            title: Text(
              "FruGe - Sign up",
              style: TextStyle(
                fontSize: width * 5 / 100,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xFF15821C),
          ),
          body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return buildPortrait(context);
              } else {
                return buildPortrait(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildPortrait(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return SingleChildScrollView(
      controller: scrollController,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.025, 0, 0),
              child: Container(
                width: width * 0.4,
                height: height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Other/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.025, 0, 0),
              width: width * 0.7,
              child: TextField(
                controller: firstNameController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(height * 0.025),
                  prefixIcon: Icon(Icons.account_box),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "First Name",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: width * 4 / 100,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: "Enter your First Name",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: TextField(
                controller: lastNameController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(height * 0.025),
                  prefixIcon: Icon(Icons.account_box),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Last Name",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: width * 4 / 100,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: "Enter your Last Name",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: TextField(
                controller: userNameController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(height * 0.025),
                  prefixIcon: Icon(Icons.account_box),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Username",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: width * 4 / 100,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: "Enter your Username",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: TextField(
                controller: emailController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.all(height * 0.025),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Email",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: width * 4 / 100,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: "Enter your email",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: TextField(
                controller: passwordController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(height * 0.025),
                  prefixIcon: Icon(Icons.security),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Password",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: width * 4 / 100,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: "Enter your Password",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: TextField(
                controller: confirmPasswordController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(height * 0.025),
                  prefixIcon: Icon(Icons.security),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Confirm Password",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    fontSize: width * 4 / 100,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: "Re-enter your password",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
              width: width * 0.7,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    if (firstNameController.text.isNotEmpty &&
                        lastNameController.text.isNotEmpty &&
                        userNameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        confirmPasswordController.text.isNotEmpty) {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        scrollController.jumpTo(height * 0.3);
                        btnClicked = true;
                      } else {
                        Fluttertoast.showToast(msg: "Password mismatch!");
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please fill all the required fields!");
                    }
                  });
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: width * 4 / 100,
                  ),
                ),
                color: Color(0xFF59C65F),
                height: height * 0.075,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.04),
                    child: displayResult(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget displayResult(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    if (btnClicked == true) {
      btnClicked = false;

      return FutureBuilder<int>(
        future: userAccounts().signUp(
            firstNameController.text,
            lastNameController.text,
            userNameController.text,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          print("snapshot - " + snapshot.toString());

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            );
          } else {
            if (snapshot.data == 200) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: width * 10 / 100,
                            height: height * 5 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Other/correctIcon.gif"),
                              fit: BoxFit.cover,
                            )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
                            child: Text(
                              "Success!",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              width * 0.04, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 0.4,
                            height: height * 0.085,
                            decoration: BoxDecoration(
                              color: Color(0xFF59C65F),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(width * 0.02),
                                topLeft: Radius.circular(width * 0.05),
                                bottomLeft: Radius.circular(width * 0.05),
                                bottomRight: Radius.circular(width * 0.02),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: width * 4 / 100,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: width * 0.01),
                                  child: Container(
                                    width: width * 10 / 100,
                                    height: height * 5 / 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                          "assets/Other/pointRight.gif"),
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.data == 401) {
              return Column(
                children: <Widget>[
                  Icon(
                    Icons.error_rounded,
                    color: Colors.red,
                    size: width * 0.15,
                  ),
                  Text(
                    "Username entered is already in use!",
                    style: TextStyle(
                      fontSize: width * 4 / 100,
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: width * 0.15,
                  ),
                  Text(
                    "Incorrect userName!",
                    style: TextStyle(
                      fontSize: width * 4 / 100,
                    ),
                  ),
                ],
              );
            }
          }
        },
      );
    } else {
      return Container();
    }
  }
}
