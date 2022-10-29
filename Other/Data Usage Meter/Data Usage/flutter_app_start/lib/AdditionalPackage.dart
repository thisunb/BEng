import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/getDataUsage.dart';
import 'Summary.dart';

class AdditionalPackage extends StatefulWidget {
  @override
  _AdditionalPackageState createState() => _AdditionalPackageState();
}

class _AdditionalPackageState extends State<AdditionalPackage> {
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
              "Data Usage Meter - Data Add On",
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
                  future: getDataUsage().getAdditionalPackageDetails(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children;
                    print(snapshot);
                    if (snapshot.hasData) {
                      return buildPortrait(context);
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            "You have not activated any Additional Packages!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: width * 5 / 100),
                            textAlign: TextAlign.center,
                          ),
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
                          child: Text('Please wait...'),
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

    double additionalDataRemainPercentage = double.parse(
        ((getDataUsage.dataRemain / getDataUsage.dataLimit) * 100)
            .toStringAsFixed(1));

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Color(0xFF72E9FF),
            padding: EdgeInsets.fromLTRB(
                width * 0.005, height * 0.005, width * 0.005, height * 0.006),
            child: Container(
              width: width * 0.99,
              decoration: BoxDecoration(
                  color: Color(0xFF1F0F57),
                  borderRadius: BorderRadius.circular(width * 0.04)),
              padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, height * 0.03),
              child: RichText(
                text: TextSpan(
                  text: "WiFi Name - " +
                      getDataUsage.wifiName.toString() +
                      "\n\n"
                          "Package - " +
                      getDataUsage.packageName.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 4 / 100,
                      fontWeight: FontWeight.w900),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n\n"
                              "Date of Expiry - " +
                          getDataUsage.addOnPackageExpiry.toString(),
                      style: TextStyle(
                        fontSize: width * 3.5 / 100,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            color: Color(0xff4E18B9),
            padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Text(
                    "Remaining - " + getDataUsage.dataRemain.toString() + " GB",
                    style: TextStyle(
                        color: Color(0xffF4D9FF),
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.01),
                  child: Text(
                    "Used - " + getDataUsage.dataUsed.toString() + " GB",
                    style: TextStyle(
                        color: Color(0xffFF7E7E),
                        fontSize: width * 4 / 100,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(height * 0.025,
                          height * 0.005, height * 0.025, height * 0.005),
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(width * 0.05),
                          topLeft: Radius.circular(width * 0.05),
                          bottomLeft: Radius.circular(width * 0.1),
                          bottomRight: Radius.circular(width * 0.1),
                        ),
                        color:
                            Summary.changeColor(additionalDataRemainPercentage),
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
                                text:
                                    additionalDataRemainPercentage.toString() +
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
                      padding: EdgeInsets.fromLTRB(
                          width * 0.03, height * 0.01, width * 0.03, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.04),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff373739).withOpacity(1),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: Summary.fillInnerBar(
                                  additionalDataRemainPercentage, context),
                              height: height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(width * 0.04),
                                    bottomLeft: Radius.circular(width * 0.04),
                                    bottomRight: Radius.circular(
                                        Summary.changeInnerBarRightBorder(
                                            additionalDataRemainPercentage,
                                            context)),
                                    topRight: Radius.circular(
                                        Summary.changeInnerBarRightBorder(
                                            additionalDataRemainPercentage,
                                            context))),
                                color: Summary.changeColor(
                                    additionalDataRemainPercentage),
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
          Container(
            color: Color(0xFF72E9FF),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.008, height * 0.004, width * 0.006, height * 0.004),
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
        ],
      ),
    );
  }
}
