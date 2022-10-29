import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/Dashboard.dart';
import 'package:flutter_app_start/Login.dart';
import 'package:flutter_app_start/SignUp.dart';
import 'package:flutter_app_start/Vegetables.dart';
import 'package:flutter_app_start/priceData.dart';
import 'package:flutter_app_start/userAccounts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'About.dart';
import 'Fruits.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    userAccounts().loadUserData();
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "FruGe",
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
                return Center(
                  child: FutureBuilder<String>(
                    future: priceData()
                        .getData(), // a previously-obtained Future<String> or null
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        priceData().setPriceData("today");
                        return buildPortrait(context);
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text("Error Occurred!"),
                          )
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Loading Data...'),
                          )
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: children,
                        ),
                      );
                    },
                  ),
                );
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
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Container(
                width: width * 99 / 100,
                height: height * 30 / 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/Other/imageSliderImage3.png"),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Container(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.01),
                width: width * 100 / 100,
                height: height * 25 / 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          if (userAccounts.userLogged) {
                            /*Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()),
                                (Route<dynamic> route) => false);*/

                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()),
                            );*/
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please sign up to get full access!");
                          }
                        },
                        child: Container(
                          color: Color(0xFFA7CAA9),
                          width: width * 30 / 100,
                          height: height * 10 / 100,
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.09, 0, 0),
                              child: Text(
                                "Dashboard",
                                style: TextStyle(
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                              child: Container(
                                width: width * 10 / 100,
                                height: height * 7 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage("assets/Other/dashboard.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          if (userAccounts.userLogged) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Vegetables()),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please sign up to get full access!");
                          }
                        },
                        child: Container(
                          color: Color(0xFF59C65F),
                          width: width * 30 / 100,
                          height: height * 10 / 100,
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.09, 0, 0),
                              child: Text(
                                "Vegetables",
                                style: TextStyle(
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                              child: Container(
                                width: width * 10 / 100,
                                height: height * 7 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      "assets/Other/brinjalsIcon.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          if (userAccounts.userLogged) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Fruits()),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please sign up to get full access!");
                          }
                        },
                        child: Container(
                          color: Color(0xFFA7CAA9),
                          width: width * 30 / 100,
                          height: height * 10 / 100,
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.09, 0, 0),
                              child: Text(
                                "Fruits",
                                style: TextStyle(
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                              child: Container(
                                width: width * 10 / 100,
                                height: height * 7 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage("assets/Other/appleIcon.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          ).then((value) => setState(() {}));

                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );*/
                        },
                        child: Container(
                          color: Color(0xFF59C65F),
                          width: width * 30 / 100,
                          height: height * 10 / 100,
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.09, 0, 0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                              child: Container(
                                width: width * 10 / 100,
                                height: height * 7 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage("assets/Other/login.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Container(
                          color: Color(0xFFA7CAA9),
                          width: width * 30 / 100,
                          height: height * 10 / 100,
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.09, 0, 0),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                              child: Container(
                                width: width * 10 / 100,
                                height: height * 7 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage("assets/Other/signup.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => About()),
                          );
                        },
                        child: Container(
                          color: Color(0xFF59C65F),
                          width: width * 30 / 100,
                          height: height * 10 / 100,
                          child: Column(children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.09, 0, 0),
                              child: Text(
                                "About",
                                style: TextStyle(
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                              child: Container(
                                width: width * 10 / 100,
                                height: height * 8 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage("assets/Other/about.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
              child: Text(
                priceData.dateHeading.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: width * 5 / 100,
                ),
              ),
            ),
            if (userAccounts.userLogged)
              Container(
                color: Color(0xFF59C65F),
                padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                child: displayItems2(context),
              )
            else
              Container(
                color: Color(0xFF59C65F),
                padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                child: displayItems(context),
              )
          ],
        ),
      ),
    );
  }

  Widget displayItems(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Column(
      children: <Widget>[
        // 1st Row of items

        Container(
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/beans.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Beans",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.beansPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/carrot.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Carrot",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.carrotPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2nd Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/leeks.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Leeks",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.leeksPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fruits()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/banana.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Banana",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.bananaPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 3rd Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/knolkhol.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Knolkhol",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/cabbage.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Cabbage",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 4th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/tomato.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Tomato",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/Items/ladiesfingers.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Ladies Fingers",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 5th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/brinjals.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Brinjals",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/pumpkin.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Pumpkin",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 6th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/cucumber.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Cucumber",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/bittergourd.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Bitter Gourd",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 7th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/Items/greenchilies.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Green Chilies",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/beetroot.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Beet Root",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 8th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vegetables()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/potato.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Potato",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fruits()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/lime.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Lime",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 9th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fruits()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/papaya.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Papaya",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fruits()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/pineapple.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Pineapple",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 10th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fruits()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/mango.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Mango",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userAccounts.userLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Fruits()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please sign up to get full access!");
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/avocado.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Avocado",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Sign up for price",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget displayItems2(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Column(
      children: <Widget>[
        // 1st Row of items

        Container(
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/beans.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Beans",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.beansPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/carrot.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Carrot",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.carrotPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2nd Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/leeks.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Leeks",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.leeksPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fruits()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/banana.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Banana",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.bananaPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 3rd Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/knolkhol.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Knolkhol",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.knolkholPrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/cabbage.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Cabbage",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.cabbagePrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 4th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/tomato.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Tomato",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.tomatoPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/Items/ladiesfingers.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Ladies Fingers",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text(
                              "Rs. " + priceData.ladiesfingersPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 5th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/brinjals.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Brinjals",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.brinjalsPrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/pumpkin.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Pumpkin",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.pumpkinPrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 6th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/cucumber.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Cucumber",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.cucumberPrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/bittergourd.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Bitter Gourd",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text(
                              "Rs. " + priceData.bittergourdPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 7th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/Items/greenchilies.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Green Chilies",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text(
                              "Rs. " + priceData.greenchiliesPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/beetroot.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Beet Root",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.beetrootPrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 8th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Vegetables()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/potato.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Potato",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.potatoPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fruits()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/lime.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                          child: Text(
                            "Lime",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.limePrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 9th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fruits()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/papaya.png"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Papaya",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.papayaPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fruits()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/pineapple.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Pineapple",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.pineapplePrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 10th Row of items

        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fruits()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/mango.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Mango",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text("Rs. " + priceData.mangoPrice.toString(),
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fruits()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            width: width * 60 / 100,
                            height: height * 10 / 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/Items/avocado.jpg"),
                              fit: BoxFit.contain,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "Avocado",
                            style: TextStyle(
                              fontSize: width * 5 / 100,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child:
                              Text("Rs. " + priceData.avocadoPrice.toString(),
                                  style: TextStyle(
                                    fontSize: width * 4 / 100,
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    width: width * 49.5 / 100,
                    height: height * 30 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
