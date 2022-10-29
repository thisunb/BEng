import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/SignUp.dart';
import 'package:flutter_app_start/userAccounts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool btnClicked = false;

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
              "FruGe - Login",
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

    // Navigator.pop(context, true);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                controller: userNameController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 4 / 100,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  contentPadding: EdgeInsets.all(height * 0.025),
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
              padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
              width: width * 0.7,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    if (userNameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      btnClicked = true;
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please fill all the required fields!");
                    }
                  });
                },
                child: Text(
                  "Login",
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
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: width * 4 / 100,
                  ),
                ),
                color: Color(0xFFFF4A4A),
                height: height * 0.075,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              width: width * 0.7,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  "Do not have an account?",
                  style: TextStyle(
                    fontSize: width * 4 / 100,
                  ),
                ),
                color: Color(0xFF54925C),
                height: height * 0.075,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
        future: userAccounts()
            .login(userNameController.text, passwordController.text),
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
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
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
                                  "Dashboard",
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
            } else if (snapshot.data == 400) {
              return Column(
                children: <Widget>[
                  Icon(
                    Icons.error_rounded,
                    color: Colors.red,
                    size: width * 0.15,
                  ),
                  Text("Username & Password mismatch!",
                      style: TextStyle(
                        fontSize: width * 4 / 100,
                      )),
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
