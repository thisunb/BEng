import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
              "FruGe - About",
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
      child: Center(
        child: Column(
          children: <Widget>[
            // Heading -  Usage of the App

            Container(
              width: width * 1,
              color: Color(0xffF66EB42),
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.02),
                child: Text(
                  "Usage of the App",
                  style: TextStyle(
                    fontSize: width * 5 / 100,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Description for the usage of the app

            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              child: Container(
                color: Color(0xffDBF6C0),
                width: width * 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.04, height * 0.02, 0, height * 0.02),
                  child: Text(
                    "* This App provides the price prediction for some of the popular Fruits and Vegetables in the market. \n\n"
                    "* The prices are displayed for Today, Tomorrow & Next Week. \n\n * Please use these predicted prices only to get an idea "
                    "about the actual prices prior to reaching the supermarket.",
                    style: TextStyle(
                      fontSize: width * 4 / 100,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Heading - How to use the app

            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
              child: Container(
                color: Color(0xffF66EB42),
                width: width * 1,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.02),
                  child: Text(
                    "How to use this App?",
                    style: TextStyle(
                      fontSize: width * 5 / 100,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Description for the using

            Container(
              width: width * 1,
              child: Column(
                children: <Widget>[
                  Container(
                    width: width * 1,
                    color: Color(0xffDBF6C0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.04, height * 0.02, 0, height * 0.02),
                      child: Text(
                        "* Home Page will display predicted price for today for 4 items until you sign up! \n\n"
                        "* You have options to select to navigate different pages.",
                        style: TextStyle(
                          fontSize: width * 4 / 100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.01),
                    child: Container(
                      width: width * 60 / 100,
                      height: height * 40 / 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage("assets/App Screenshots/homepage.JPG"),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: width * 1,
                    padding: EdgeInsets.fromLTRB(
                        width * 0.04, height * 0.02, 0, height * 0.02),
                    color: Color(0xffDBF6C0),
                    child: Text(
                      "* The Dashboard Page displays predicted prices on Fruits and Vegetables for today by default.\n\n"
                      "* You can click on the items to navigate to Vegetables/ Fruits Page depending on the selection.",
                      style: TextStyle(
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.01),
                    child: Container(
                      width: width * 60 / 100,
                      height: height * 40 / 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                            "assets/App Screenshots/dashboardpage.JPG"),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: width * 1,
                    padding: EdgeInsets.fromLTRB(
                        width * 0.04, height * 0.02, 0, height * 0.02),
                    color: Color(0xffDBF6C0),
                    child: Text(
                      "* The Vegetables page displays predicted price for Vegetables for Current Date by default.\n\n"
                      "* 3 Options are available on the top to select price by date.",
                      style: TextStyle(
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.01),
                    child: Container(
                      width: width * 60 / 100,
                      height: height * 40 / 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                            "assets/App Screenshots/vegetablespage.JPG"),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: width * 1,
                    padding: EdgeInsets.fromLTRB(
                        width * 0.04, height * 0.02, 0, height * 0.02),
                    color: Color(0xffDBF6C0),
                    child: Text(
                      "* The Fruits page displays predicted price for Fruits for Current Date by default.\n\n"
                      "* 3 Options are available on the top to select price by date.",
                      style: TextStyle(
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.01),
                    child: Container(
                      width: width * 60 / 100,
                      height: height * 40 / 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage("assets/App Screenshots/fruitspage.JPG"),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: width * 1,
                    padding: EdgeInsets.fromLTRB(
                        width * 0.04, height * 0.02, 0, height * 0.02),
                    color: Color(0xffDBF6C0),
                    child: Text(
                      "* The Login page allows you to login to your account. \n\n"
                      "* You have the option to change your password in case you lost it.",
                      style: TextStyle(
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.01),
                    child: Container(
                      width: width * 60 / 100,
                      height: height * 40 / 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage("assets/App Screenshots/loginpage.JPG"),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: width * 1,
                    padding: EdgeInsets.fromLTRB(
                        width * 0.04, height * 0.02, 0, height * 0.02),
                    color: Color(0xffDBF6C0),
                    child: Text(
                      "* The Sign up page allows you to create an account. ",
                      style: TextStyle(
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.01),
                    child: Container(
                      width: width * 60 / 100,
                      height: height * 40 / 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage("assets/App Screenshots/signuppage.JPG"),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: width * 1,
              color: Color(0xffF66EB42),
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.02),
                child: Text(
                  "Thanks for using FruGe!!!",
                  style: TextStyle(
                    fontSize: width * 5 / 100,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
