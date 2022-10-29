import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/getDataUsage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Summary.dart';

class DailyUsage extends StatefulWidget {
  @override
  _DailyUsageState createState() => _DailyUsageState();
}

class _DailyUsageState extends State<DailyUsage> {
  String dateSelectTxt = "-- Select a Date --";
  String wifiName = "";
  bool clicked = false;

  // Usage History Lists

  List<dynamic> usageTotalHistory = [];
  List<dynamic> usageDownloadHistory = [];
  List<dynamic> usageUploadHistory = [];

  // Date variables

  DateTime setDate = DateTime.now();
  DateTime userSelectedPreviousDate = DateTime.now();
  String finalUserSelectedDate = "";

  int clickCount = 1;

  var scrollController = ScrollController();

  bool visibleImage = true;

  String usageDataTxtSuffix = "Usage Data";

  late Color savedCardColor;

  @override
  void initState() {
    getWifiName();
    userSelectedPreviousDate = DateTime.now();
    finalUserSelectedDate = "";
    clicked = false;
    getDataUsage.runDailyUsage = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Data Usage Meter - Daily Usage",
              style: TextStyle(
                fontSize: width * 4.5 / 100,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xff4E18B9),
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
      child: Container(
        color: Color(0xFF72E9FF),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
              child: Container(
                width: width * 0.99,
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.03),
                decoration: BoxDecoration(
                    color: Color(0xFF1F0F57),
                    borderRadius: BorderRadius.circular(width * 0.03)),
                child: RichText(
                  text: TextSpan(
                    text: "WiFi Name - " + wifiName.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                    children: <TextSpan>[],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Visibility(
              visible: visibleImage,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    width * 0.008, height * 0.004, width * 0.006, 0),
                child: Container(
                  child: Container(
                    width: width * 100 / 100,
                    height: height * 40 / 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        image: DecorationImage(
                          image: AssetImage("assets/Other/imageWifi.jpg"),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ),

            // ---------------- Select Date -------------------------

            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
                color: Color(0xff4E18B9),
                width: width * 1,
                child: Text(
                  "Select a Date for Daily Usage",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 4.5 / 100,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
              child: Container(
                color: Color(0xff001452),
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectDate(context);
                        });
                      },
                      child: Container(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, height * 0.03, 0, height * 0.03),
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: Color(0xFF720082),
                              borderRadius:
                                  BorderRadius.circular(width * 0.03)),
                          child: Text(
                            "$dateSelectTxt",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //-------------------------- Usage Data Types------------------

            Padding(
              padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
                color: Color(0xff4E18B9),
                width: width * 1,
                child: Text(
                  "Select Data Type ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 4.5 / 100,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(
                  width * 0.005, height * 0.005, 0, height * 0.0),
              width: width * 100 / 100,
              height: height * 22 / 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (finalUserSelectedDate.isNotEmpty) {
                            usageDataTxtSuffix = "Usage Data - Total Data";
                            clickCount = 1;
                            scrollController.jumpTo(height * 0.4);
                            clicked = true;
                            print("click - " + clickCount.toString());
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a Date!");
                          }
                        });
                      },
                      child: Container(
                        width: width * 32.5 / 100,
                        height: height * 10 / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          color: Color(0xFF4735F3),
                        ),
                        child: Column(children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                            child: Text(
                              "Total Data",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
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
                                image: AssetImage("assets/Other/dashboard.png"),
                                fit: BoxFit.contain,
                              )),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(width * 0.008, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (finalUserSelectedDate.isNotEmpty) {
                            usageDataTxtSuffix = "Usage Data - Upload";
                            clickCount = 2;
                            scrollController.jumpTo(height * 0.4);
                            clicked = true;
                            print("click - " + clickCount.toString());
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a Date!");
                          }
                        });
                      },
                      child: Container(
                        width: width * 32.5 / 100,
                        height: height * 10 / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          color: Color(0xFF6E33CE),
                        ),
                        child: Column(children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
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
                                image: AssetImage("assets/Other/dashboard.png"),
                                fit: BoxFit.contain,
                              )),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(width * 0.008, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (finalUserSelectedDate.isNotEmpty) {
                            usageDataTxtSuffix = "Usage Data - Download";
                            clickCount = 3;
                            scrollController.jumpTo(height * 0.4);
                            clicked = true;
                            print("click - " + clickCount.toString());
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a Date!");
                          }
                        });
                      },
                      child: Container(
                        width: width * 32.5 / 100,
                        height: height * 10 / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          color: Color(0xFF822AA2),
                        ),
                        child: Column(children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                            child: Text(
                              "Download",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
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
                                image: AssetImage("assets/Other/dashboard.png"),
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

            //------------------------- Usage Data---------------------

            if (clicked == true)
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width * 1,
                    child: Column(
                      children: <Widget>[
                        FutureBuilder<String>(
                          future: getDataUsage()
                              .getDailyUsage(finalUserSelectedDate),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            List<Widget> children;
                            print(snapshot);
                            if (snapshot.hasData) {
                              clicked = false;
                              if (clickCount == 1) {
                                scrollController.jumpTo(height * 0.7);
                                return displayTotalUsageHistory();
                              } else if (clickCount == 2) {
                                scrollController.jumpTo(height * 0.7);
                                return displayUploadUsageHistory();
                              } else {
                                scrollController.jumpTo(height * 0.7);
                                return displayDownloadUsageHistory();
                              }
                            } else if (snapshot.hasError) {
                              children = <Widget>[
                                const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    "Unknown Error Occurred! \n\n Please restart the App to resolve "
                                    "the error.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: width * 4 / 100),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ];
                            } else {
                              children = <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Text(
                                    'Please wait...',
                                    style: TextStyle(
                                        fontSize: width * 4 / 100,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ),
                              ];
                            }
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, height * 0.005, 0, height * 0.0),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    0, height * 0.02, 0, height * 0.03),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(width * 0.03),
                                  color: Color(0xff001452),
                                ),
                                width: width * 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: children,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            Padding(
              padding:
                  EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.005),
              child: Container(
                width: width * 0.99,
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.03),
                decoration: BoxDecoration(
                    color: Color(0xFF1F0F57),
                    borderRadius: BorderRadius.circular(width * 0.03)),
                child: RichText(
                  text: TextSpan(
                    text: "WiFi Name - " + wifiName.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                    children: <TextSpan>[],
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

  Widget displayTotalUsageHistory() {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    usageTotalHistory = getDataUsage.usageTotalHistory[0];
    savedCardColor = Color(0);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
            color: Color(0xff4E18B9),
            width: width * 1,
            child: Text(
              "$usageDataTxtSuffix",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 4.5 / 100,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.005),
          child: Container(
            color: Color(0xFF1F0F57),
            width: width * 0.98,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    dateSelectTxt,
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Container(
                    height: height * 0.01,
                    color: Color(0xFF4735F3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Standard Data Used - " +
                        getDataUsage.standardDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffFF8080),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Free Data Used - " +
                        getDataUsage.freeDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffCBFF80),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Total Data Used - " +
                        getDataUsage.totalDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffC7CDFF),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.01),
                  child: Container(
                    height: height * 0.01,
                    color: Color(0xFF4735F3),
                  ),
                ),
              ],
            ),
          ),
        ),
        for (int i = 0; i < usageTotalHistory.length; i++)
          Container(
            width: width * 0.98,
            color: containerColor(),
            padding: EdgeInsets.fromLTRB(
                width * 0.03, 0, width * 0.03, width * 0.02),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    usageTotalHistory[i]["protocol"].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(height * 0.025, height * 0.005,
                        height * 0.025, height * 0.005),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width * 0.05),
                        topLeft: Radius.circular(width * 0.05),
                        bottomLeft: Radius.circular(width * 0.1),
                        bottomRight: Radius.circular(width * 0.1),
                      ),
                      color: changeColor(usageTotalHistory[i]["presentage"]),
                    ),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: "  used  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 4 / 100,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (usageTotalHistory[i]["presentage"])
                                      .toStringAsFixed(1) +
                                  "%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 5.5 / 100,
                                fontWeight: FontWeight.w900,
                                // fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff121313).withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedContainer(
                          width: Summary.fillInnerBar(
                              usageTotalHistory[i]["presentage"], context),
                          height: height * 0.07,
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.04),
                                bottomLeft: Radius.circular(width * 0.04),
                                bottomRight: Radius.circular(
                                    Summary.changeInnerBarRightBorder(
                                        usageTotalHistory[i]["presentage"],
                                        context)),
                                topRight: Radius.circular(
                                    Summary.changeInnerBarRightBorder(
                                        usageTotalHistory[i]["presentage"],
                                        context))),
                            color:
                                changeColor(usageTotalHistory[i]["presentage"]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget displayDownloadUsageHistory() {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    usageDownloadHistory = getDataUsage.usageDownloadHistory[0];
    savedCardColor = Color(0);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
            color: Color(0xff4E18B9),
            width: width * 1,
            child: Text(
              "$usageDataTxtSuffix",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 4.5 / 100,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.005),
          child: Container(
            color: Color(0xFF1F0F57),
            width: width * 0.98,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    dateSelectTxt,
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Container(
                    height: height * 0.01,
                    color: Color(0xFF4735F3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Standard Data Used - " +
                        getDataUsage.standardDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffFF8080),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Free Data Used - " +
                        getDataUsage.freeDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffCBFF80),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Total Data Used - " +
                        getDataUsage.totalDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffC7CDFF),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.01),
                  child: Container(
                    height: height * 0.01,
                    color: Color(0xFF4735F3),
                  ),
                ),
              ],
            ),
          ),
        ),
        for (int i = 0; i < usageDownloadHistory.length; i++)
          Container(
            width: width * 0.98,
            color: containerColor(),
            padding: EdgeInsets.fromLTRB(
                width * 0.03, 0, width * 0.03, width * 0.02),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    usageDownloadHistory[i]["protocol"].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(height * 0.025, height * 0.005,
                        height * 0.025, height * 0.005),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width * 0.05),
                        topLeft: Radius.circular(width * 0.05),
                        bottomLeft: Radius.circular(width * 0.1),
                        bottomRight: Radius.circular(width * 0.1),
                      ),
                      color: changeColor(usageDownloadHistory[i]["presentage"]),
                    ),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: "  used  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 4 / 100,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (usageDownloadHistory[i]["presentage"])
                                      .toStringAsFixed(1) +
                                  "%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 5.5 / 100,
                                fontWeight: FontWeight.w900,
                                // fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff121313).withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedContainer(
                          width: Summary.fillInnerBar(
                              usageDownloadHistory[i]["presentage"], context),
                          height: height * 0.07,
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.04),
                                bottomLeft: Radius.circular(width * 0.04),
                                bottomRight: Radius.circular(
                                    Summary.changeInnerBarRightBorder(
                                        usageDownloadHistory[i]["presentage"],
                                        context)),
                                topRight: Radius.circular(
                                    Summary.changeInnerBarRightBorder(
                                        usageDownloadHistory[i]["presentage"],
                                        context))),
                            color: changeColor(
                                usageDownloadHistory[i]["presentage"]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget displayUploadUsageHistory() {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    usageUploadHistory = getDataUsage.usageUploadHistory[0];
    savedCardColor = Color(0);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
            color: Color(0xff4E18B9),
            width: width * 1,
            child: Text(
              "$usageDataTxtSuffix",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 4.5 / 100,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.005),
          child: Container(
            color: Color(0xFF1F0F57),
            width: width * 0.98,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    dateSelectTxt,
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Container(
                    height: height * 0.01,
                    color: Color(0xFF4735F3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Standard Data Used - " +
                        getDataUsage.standardDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffFF8080),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Free Data Used - " +
                        getDataUsage.freeDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffCBFF80),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    "Total Data Used - " +
                        getDataUsage.totalDataUsed.toString() +
                        " GB",
                    style: TextStyle(
                        color: Color(0xffC7CDFF),
                        fontStyle: FontStyle.italic,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.01),
                  child: Container(
                    height: height * 0.01,
                    color: Color(0xFF4735F3),
                  ),
                ),
              ],
            ),
          ),
        ),
        for (int i = 0; i < usageUploadHistory.length; i++)
          Container(
            width: width * 0.98,
            color: containerColor(),
            padding: EdgeInsets.fromLTRB(
                width * 0.03, 0, width * 0.03, width * 0.02),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                  child: Text(
                    usageUploadHistory[i]["protocol"].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(height * 0.025, height * 0.005,
                        height * 0.025, height * 0.005),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width * 0.05),
                        topLeft: Radius.circular(width * 0.05),
                        bottomLeft: Radius.circular(width * 0.1),
                        bottomRight: Radius.circular(width * 0.1),
                      ),
                      color: changeColor(usageUploadHistory[i]["presentage"]),
                    ),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: "  used  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 4 / 100,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (usageUploadHistory[i]["presentage"])
                                      .toStringAsFixed(1) +
                                  "%",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 5.5 / 100,
                                fontWeight: FontWeight.w900,
                                // fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff121313).withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: AnimatedContainer(
                          width: Summary.fillInnerBar(
                              usageUploadHistory[i]["presentage"], context),
                          height: height * 0.07,
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.04),
                                bottomLeft: Radius.circular(width * 0.04),
                                bottomRight: Radius.circular(
                                    Summary.changeInnerBarRightBorder(
                                        usageUploadHistory[i]["presentage"],
                                        context)),
                                topRight: Radius.circular(
                                    Summary.changeInnerBarRightBorder(
                                        usageUploadHistory[i]["presentage"],
                                        context))),
                            color: changeColor(
                                usageUploadHistory[i]["presentage"]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    getDataUsage.runDailyUsage = false;
    visibleImage = true;

    int currentYear = setDate.year;
    int currentMonth = setDate.month;
    int currentDay = setDate.day;

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: userSelectedPreviousDate,
        firstDate: DateTime((currentYear - 1), currentMonth),
        currentDate: DateTime(currentYear, currentMonth, (currentDay)),
        lastDate: DateTime(currentYear, currentMonth, currentDay));

    if (picked != null) {
      setState(() {
        userSelectedPreviousDate = picked;

        DateTime userSelectedDate = picked;

        int userSelectedYear = userSelectedDate.year;
        int userSelectedMonth = userSelectedDate.month;
        int userSelectedDay = userSelectedDate.day;

        getDataUsage.userSelectedYear = userSelectedYear;
        getDataUsage.userSelectedMonth = userSelectedMonth;
        getDataUsage.userSelectedDay = userSelectedDay;

        String month = "";
        String day = "";

        if (userSelectedMonth < 10) {
          month = "0" + userSelectedMonth.toString();
        } else {
          month = userSelectedMonth.toString();
        }

        if (userSelectedDay < 10) {
          day = "0" + userSelectedDay.toString();
        } else {
          day = userSelectedDay.toString();
        }

        finalUserSelectedDate =
            userSelectedYear.toString() + "-" + month + "-" + day;

        dateSelectTxt = finalUserSelectedDate;

        print(finalUserSelectedDate);
      });
    }
  }

  Color changeColor(double percentage) {
    if (percentage <= 10) {
      return Color(0xff0DAB07);
    } else if (percentage <= 25 && percentage > 10) {
      return Color(0xff67D505);
    } else if (percentage <= 50 && percentage > 25) {
      return Color(0xffBC7D07);
    } else if (percentage <= 75 && percentage > 50) {
      return Color(0xffC34D05);
    } else {
      return Color(0xffC90303);
    }
  }

  Color containerColor() {
    if (savedCardColor != Color(0xff1B0051)) {
      savedCardColor = Color(0xff1B0051);
      return Color(0xff1B0051);
    } else {
      savedCardColor = Color(0xff5C0EA6);
      return Color(0xff5C0EA6);
    }
  }

  void getWifiName() {
    if (getDataUsage.userSelectedConnection == "connection1") {
      getDataUsage.connection = getDataUsage.connection1;
    } else {
      getDataUsage.connection = getDataUsage.connection2;
    }

    wifiName = getDataUsage.connection["wifiName"].toString();
    print("wifi name - " + wifiName);
  }
}
