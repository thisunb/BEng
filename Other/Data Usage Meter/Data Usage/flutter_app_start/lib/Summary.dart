import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/getDataUsage.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();

  static Color changeColor(double percentage) {
    if (percentage <= 10) {
      return Color(0xffC90303);
    } else if (percentage <= 25 && percentage > 10) {
      return Color(0xffC34D05);
    } else if (percentage <= 50 && percentage > 25) {
      return Color(0xffBC7D07);
    } else if (percentage <= 75 && percentage > 50) {
      return Color(0xff67D505);
    } else {
      return Color(0xff0DAB07);
    }
  }

  static double fillInnerBar(double percentage, BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;

    if (percentage == 0) {
      return 0;
    } else if (percentage < 2.5) {
      return (width * 0.92) * 0.025;
    } else {
      return (width * 0.92) * percentage / 100;
    }
  }

  static double changeInnerBarRightBorder(
      double percentage, BuildContext context) {
    final size = MediaQuery.of(context).size;

    double width = size.width;

    if (percentage == 100) {
      return (width * 0.04);
    } else if (percentage >= 97 && percentage < 97.5) {
      return (width * 0.005);
    } else if (percentage >= 97.5 && percentage < 98) {
      return (width * 0.015);
    } else if (percentage >= 98 && percentage < 98.5) {
      return (width * 0.02);
    } else if (percentage >= 98.5 && percentage < 99) {
      return (width * 0.025);
    } else if (percentage >= 99 && percentage < 99.5) {
      return (width * 0.03);
    } else if (percentage >= 99.5 && percentage < 100) {
      return (width * 0.035);
    } else {
      return 0;
    }
  }
}

class _SummaryState extends State<Summary> {
  String userSelectedOption = "";

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
              "Data Usage Meter - Summary",
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
                return FutureBuilder<String>(
                  future: getDataUsage().getSummary(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children;
                    print(snapshot);
                    if (snapshot.hasData) {
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
                          child: Text("Unknown error Occurred!"),
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
                          child: Text('Loading Usage Data...'),
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

    double totalDataRemainPercentage = double.parse(
        ((getDataUsage.dataRemain / getDataUsage.dataLimit) * 100)
            .toStringAsFixed(1));
    double dayTimeRemainPercentage = double.parse(
        ((getDataUsage.peakRemain / getDataUsage.peakLimit) * 100)
            .toStringAsFixed(1));
    double nightTimeRemainPercentage = double.parse(
        ((getDataUsage.offPeakRemain / getDataUsage.offPeakLimit) * 100)
            .toStringAsFixed(1));
    double bonusDataRemainPercentage = double.parse(
        ((getDataUsage.bonusDataRemain / getDataUsage.bonusDataLimit) * 100)
            .toStringAsFixed(1));

    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF72E9FF),
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFF72E9FF),
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.006),
                child: Container(
                  width: width * 0.99,
                  decoration: BoxDecoration(
                      color: Color(0xFF1F0F57),
                      borderRadius: BorderRadius.circular(width * 0.04)),
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.03),
                  child: Text(
                    "WiFi Name - " +
                        getDataUsage.wifiName.toString() +
                        "\n\n"
                            "Package - " +
                        getDataUsage.packageName.toString() +
                        "\n\n" +
                        "Status - " +
                        getDataUsage.status.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 4 / 100,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: width * 0.98,
                child: Column(
                  children: <Widget>[
                    // Total Data

                    Container(
                      color: Color(0xff4E18B9),
                      padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                            child: Text(
                              "Total Data (Day + Night) - " +
                                  getDataUsage.dataLimit.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffD9FDFF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                            child: Text(
                              "Remaining - " +
                                  getDataUsage.dataRemain.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffF4D9FF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, height * 0.01, 0, height * 0.01),
                            child: Text(
                              "Used - " +
                                  getDataUsage.dataUsed.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffFF7E7E),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    height * 0.025,
                                    height * 0.005,
                                    height * 0.025,
                                    height * 0.005),
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * 0.05),
                                    topLeft: Radius.circular(width * 0.05),
                                    bottomLeft: Radius.circular(width * 0.1),
                                    bottomRight: Radius.circular(width * 0.1),
                                  ),
                                  color: Summary.changeColor(
                                      totalDataRemainPercentage),
                                ),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: " available ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 4 / 100,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: totalDataRemainPercentage
                                                  .toString() +
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(width * 0.03,
                                    height * 0.01, width * 0.03, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff373739).withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: Summary.fillInnerBar(
                                            totalDataRemainPercentage, context),
                                        height: height * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(width * 0.04),
                                              bottomLeft: Radius.circular(width * 0.04),
                                              bottomRight: Radius.circular(Summary.changeInnerBarRightBorder(totalDataRemainPercentage, context)),
                                              topRight: Radius.circular(Summary.changeInnerBarRightBorder(totalDataRemainPercentage, context))
                                          ),
                                          color: Summary.changeColor(
                                              totalDataRemainPercentage),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Day Time Usage

                    Container(
                      color: Color(0xff6F0A6B),
                      padding: EdgeInsets.fromLTRB(
                          0, height * 0.01, 0, height * 0.01),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                            child: Text(
                              "Day Time Usage - " +
                                  getDataUsage.peakLimit.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffD9FDFF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                            child: Text(
                              "Remaining - " +
                                  getDataUsage.peakRemain.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffF4D9FF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, height * 0.01, 0, height * 0.01),
                            child: Text(
                              "Used - " +
                                  getDataUsage.peakUsed.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffFF7E7E),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    height * 0.025,
                                    height * 0.005,
                                    height * 0.025,
                                    height * 0.005),
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * 0.05),
                                    topLeft: Radius.circular(width * 0.05),
                                    bottomLeft: Radius.circular(width * 0.1),
                                    bottomRight: Radius.circular(width * 0.1),
                                  ),
                                  color: Summary.changeColor(
                                      dayTimeRemainPercentage),
                                ),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: " available ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 4 / 100,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: dayTimeRemainPercentage
                                                  .toString() +
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(width * 0.03,
                                    height * 0.01, width * 0.03, 0),
                                child: Container(
                                  width: width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff373739).withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: Summary.fillInnerBar(
                                            dayTimeRemainPercentage, context),
                                        height: height * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(width * 0.04),
                                              bottomLeft: Radius.circular(width * 0.04),
                                              bottomRight: Radius.circular(Summary.changeInnerBarRightBorder(dayTimeRemainPercentage, context)),
                                              topRight: Radius.circular(Summary.changeInnerBarRightBorder(dayTimeRemainPercentage, context))
                                          ),
                                          color: Summary.changeColor(
                                              dayTimeRemainPercentage),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Night Time Usage

                    Container(
                      color: Color(0xff5C0EA6),
                      padding: EdgeInsets.fromLTRB(
                          0, height * 0.01, 0, height * 0.01),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                            child: Text(
                              "Night Time Usage - " +
                                  getDataUsage.offPeakLimit.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffD9FDFF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                            child: Text(
                              "Remaining - " +
                                  getDataUsage.offPeakRemain.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffF4D9FF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, height * 0.01, 0, height * 0.01),
                            child: Text(
                              "Used - " +
                                  getDataUsage.offPeakUsed.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffFF7E7E),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    height * 0.025,
                                    height * 0.005,
                                    height * 0.025,
                                    height * 0.005),
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * 0.05),
                                    topLeft: Radius.circular(width * 0.05),
                                    bottomLeft: Radius.circular(width * 0.1),
                                    bottomRight: Radius.circular(width * 0.1),
                                  ),
                                  color: Summary.changeColor(
                                      nightTimeRemainPercentage),
                                ),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: " available ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 4 / 100,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: nightTimeRemainPercentage
                                                  .toString() +
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(width * 0.03,
                                    height * 0.01, width * 0.03, 0),
                                child: Container(
                                  width: width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff373739).withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: Summary.fillInnerBar(
                                            nightTimeRemainPercentage, context),
                                        height: height * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(width * 0.04),
                                              bottomLeft: Radius.circular(width * 0.04),
                                              bottomRight: Radius.circular(Summary.changeInnerBarRightBorder(nightTimeRemainPercentage, context)),
                                              topRight: Radius.circular(Summary.changeInnerBarRightBorder(nightTimeRemainPercentage, context))
                                          ),
                                          color: Summary.changeColor(
                                              nightTimeRemainPercentage),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bonus data usage

                    Container(
                      color: Color(0xff4E18B9),
                      padding: EdgeInsets.fromLTRB(
                          0, height * 0.01, 0, height * 0.01),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                            child: Text(
                              "Bonus Data Usage - " +
                                  getDataUsage.bonusDataLimit.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffD9FDFF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                            child: Text(
                              "Remaining - " +
                                  getDataUsage.bonusDataRemain.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffF4D9FF),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, height * 0.01, 0, height * 0.01),
                            child: Text(
                              "Used - " +
                                  getDataUsage.bonusDataUsed.toString() +
                                  " GB",
                              style: TextStyle(
                                  color: Color(0xffFF7E7E),
                                  fontSize: width * 4 / 100,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    height * 0.025,
                                    height * 0.005,
                                    height * 0.025,
                                    height * 0.005),
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * 0.05),
                                    topLeft: Radius.circular(width * 0.05),
                                    bottomLeft: Radius.circular(width * 0.1),
                                    bottomRight: Radius.circular(width * 0.1),
                                  ),
                                  color: Summary.changeColor(
                                      bonusDataRemainPercentage),
                                ),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: " available ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 4 / 100,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: bonusDataRemainPercentage
                                                  .toString() +
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(width * 0.03,
                                    height * 0.01, width * 0.03, 0),
                                child: Container(
                                  width: width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff373739).withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: Summary.fillInnerBar(
                                            bonusDataRemainPercentage, context),
                                        height: height * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(width * 0.04),
                                              bottomLeft: Radius.circular(width * 0.04),
                                              bottomRight: Radius.circular(Summary.changeInnerBarRightBorder(bonusDataRemainPercentage, context)),
                                              topRight: Radius.circular(Summary.changeInnerBarRightBorder(bonusDataRemainPercentage, context))
                                          ),
                                          color: Summary.changeColor(
                                              bonusDataRemainPercentage),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Additional Package usage data

                    if (getDataUsage.displayAdditionalColumn == true)
                      displayAdditionalPackageDetails(),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(0, height * 0.005, 0, height * 0.004),
              child: Container(
                width: width * 0.99,
                decoration: BoxDecoration(
                    color: Color(0xFF1F0F57),
                    borderRadius: BorderRadius.circular(width * 0.04)),
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.03),
                child: Text(
                  "WiFi Name - " +
                      getDataUsage.wifiName.toString() +
                      "\n\n"
                          "Package - " +
                      getDataUsage.packageName.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 4 / 100,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayAdditionalPackageDetails() {
    getDataUsage.displayAdditionalColumn = false;
    final size = MediaQuery.of(context).size;

    double width = size.width;
    double height = size.height;

    double additionalPackRemainPercentage = double.parse(
        ((getDataUsage.additionalPackageDataRemain /
                    getDataUsage.additionalPackageDataLimit) *
                100)
            .toStringAsFixed(1));

    return Container(
      color: Color(0xff013C3F),
      padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
            child: Text(
              "Additional Package Data Usage - " +
                  getDataUsage.additionalPackageDataLimit.toString() +
                  " GB",
              style: TextStyle(
                  color: Color(0xffD9FDFF),
                  fontSize: width * 4 / 100,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
            child: Text(
              "Remaining - " +
                  getDataUsage.additionalPackageDataRemain.toString() +
                  " GB",
              style: TextStyle(
                  color: Color(0xffF4D9FF),
                  fontSize: width * 4 / 100,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
            child: Text(
              "Used - " +
                  getDataUsage.additionalPackageDataUsed.toString() +
                  " GB",
              style: TextStyle(
                  color: Color(0xffFF7E7E),
                  fontSize: width * 4 / 100,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
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
                  color: Summary.changeColor(additionalPackRemainPercentage),
                ),
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      text: " available ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: additionalPackRemainPercentage.toString() + "%",
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    width * 0.03, height * 0.01, width * 0.03, 0),
                child: Container(
                  width: width * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.04),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff373739).withOpacity(1),
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: Summary.fillInnerBar(
                            additionalPackRemainPercentage, context),
                        height: height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.04),
                              bottomLeft: Radius.circular(width * 0.04),
                              bottomRight: Radius.circular(Summary.changeInnerBarRightBorder(additionalPackRemainPercentage, context)),
                              topRight: Radius.circular(Summary.changeInnerBarRightBorder(additionalPackRemainPercentage, context))
                          ),
                          color: Summary.changeColor(
                              additionalPackRemainPercentage),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
