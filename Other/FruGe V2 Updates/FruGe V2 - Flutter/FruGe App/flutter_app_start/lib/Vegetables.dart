import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/priceData.dart';
import 'package:flutter_app_start/userAccounts.dart';

class Vegetables extends StatefulWidget {
  @override
  _VegetablesState createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  Color colorToday = Color(0xFF59C65F);
  Color colorTomorrow = Color(0xFFA7CAA9);
  Color colorNextWeek = Color(0xFFA7CAA9);

  String tappedButton = "";

  @override
  void initState() {
    priceData().setDateIcons();
    priceData().setPriceData("today");
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
              "FruGe - Vegetables",
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  width * 0.04, height * 0.005, 0, height * 0.01),
              width: width * 100 / 100,
              height: height * 20 / 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tappedButton = "today";
                          changeButtonColor();
                          priceData().setPriceData("today");
                        });
                      },
                      child: Container(
                        color: colorToday,
                        width: width * 30 / 100,
                        height: height * 5 / 100,
                        child: Column(children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                            child: Text(
                              "Today",
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
                                image: AssetImage("assets/Calender Icons/" +
                                    priceData.iconToday +
                                    ".png"),
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
                        setState(() {
                          tappedButton = "tomorrow";
                          changeButtonColor();
                          priceData().setPriceData("tomorrow");
                        });
                      },
                      child: Container(
                        color: colorTomorrow,
                        width: width * 30 / 100,
                        height: height * 10 / 100,
                        child: Column(children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                            child: Text(
                              "Tomorrow",
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
                                image: AssetImage("assets/Calender Icons/" +
                                    priceData.iconTomorrow +
                                    ".png"),
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
                        setState(() {
                          tappedButton = "nextWeek";
                          changeButtonColor();
                          priceData().setPriceData("nextWeek");
                        });
                      },
                      child: Container(
                        color: colorNextWeek,
                        width: width * 30 / 100,
                        height: height * 10 / 100,
                        child: Column(children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.04, 0, 0),
                            child: Text(
                              "Next Week",
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
                                image: AssetImage("assets/Calender Icons/" +
                                    priceData.iconNextWeek +
                                    ".png"),
                                fit: BoxFit.contain,
                              )),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            Container(
              color: Color(0xFF59C65F),
              padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
              child: Column(
                children: <Widget>[
                  // 1st Row of items

                  Container(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
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
                                        image: AssetImage(
                                            "assets/Items/beans.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Beans",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.beansPrice.toString(),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.01, 0, 0),
                                    child: Container(
                                      width: width * 60 / 100,
                                      height: height * 10 / 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/Items/carrot.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.04, 0, 0),
                                    child: Text(
                                      "Carrot",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.carrotPrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/leeks.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Leeks",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.leeksPrice.toString(),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.01, 0, 0),
                                    child: Container(
                                      width: width * 60 / 100,
                                      height: height * 10 / 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/Items/potato.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.04, 0, 0),
                                    child: Text(
                                      "Potato",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.potatoPrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/knolkhol.jpg"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Knolkhol",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.knolkholPrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/cabbage.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Cabbage",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.cabbagePrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/tomato.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Tomato",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.tomatoPrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/ladiesfingers.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Ladies Fingers",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.ladiesfingersPrice
                                                .toString(),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.01, 0, 0),
                                    child: Container(
                                      width: width * 60 / 100,
                                      height: height * 10 / 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/Items/brinjals.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.04, 0, 0),
                                    child: Text(
                                      "Brinjals",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.brinjalsPrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/pumpkin.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Pumpkin",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.pumpkinPrice.toString(),
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
                                        image: AssetImage(
                                            "assets/Items/cucumber.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Cucumber",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.cucumberPrice.toString(),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width * 0.01, 0, 0, 0),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.01, 0, 0),
                                    child: Container(
                                      width: width * 60 / 100,
                                      height: height * 10 / 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/Items/bittergourd.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.04, 0, 0),
                                    child: Text(
                                      "Bitter Gourd",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.bittergourdPrice
                                                .toString(),
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
                                        image: AssetImage(
                                            "assets/Items/greenchilies.jpg"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Green Chilies",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.greenchiliesPrice
                                                .toString(),
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
                                        image: AssetImage(
                                            "assets/Items/beetroot.png"),
                                        fit: BoxFit.contain,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.05, 0, 0),
                                    child: Text(
                                      "Beet Root",
                                      style: TextStyle(
                                        fontSize: width * 5 / 100,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, height * 0.06, 0, 0),
                                    child: Text(
                                        "Rs. " +
                                            priceData.beetrootPrice.toString(),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void changeButtonColor() {
    if (tappedButton == "today") {
      colorToday = Color(0xFF59C65F);
      colorTomorrow = Color(0xFFA7CAA9);
      colorNextWeek = Color(0xFFA7CAA9);
    } else if (tappedButton == "tomorrow") {
      colorToday = Color(0xFFA7CAA9);
      colorTomorrow = Color(0xFF59C65F);
      colorNextWeek = Color(0xFFA7CAA9);
    } else {
      colorToday = Color(0xFFA7CAA9);
      colorTomorrow = Color(0xFFA7CAA9);
      colorNextWeek = Color(0xFF59C65F);
    }
  }
}
