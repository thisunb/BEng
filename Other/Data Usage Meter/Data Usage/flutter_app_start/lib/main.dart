import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_start/AdditionalPackage.dart';
import 'package:flutter_app_start/DailyUsage.dart';
import 'package:flutter_app_start/Summary.dart';
import 'package:flutter_app_start/getDataUsage.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> loadUserData;

  int clickCount = 0;
  Color color1 = Color(0xFF1F0F57);
  Color color2 = Color(0xFF1F0F57);
  Color clickedColor = Color(0xFF4E0A80);

  @override
  void initState() {
    super.initState();
    loadUserData = getDataUsage().getUsageData();
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
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Data Usage Meter",
              style: TextStyle(
                fontSize: width * 5 / 100,
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
                  future: loadUserData,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children;
                    print(snapshot);
                    if (snapshot.hasData) {
                      return buildPortrait(context);
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            "Unknown error Occurred!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: width * 5 / 100),
                          ),
                        )
                      ];
                    } else {
                      children = <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Loading User Data...'),
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

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
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
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.000, 0, 0),
            child: Container(
              padding:
                  EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
              width: width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.0),
                color: Color(0xff4E18B9),
              ),
              child: Text(
                "Available Connections",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: width * 4.5 / 100,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Color(0xFF72E9FF),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    clickCount++;
                    getDataUsage.userSelectedConnection = "connection1";
                    setState(() {
                      changeButtonColor();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.005, height * 0.005, 0, height * 0.005),
                    child: Container(
                      width: width * 0.49,
                      height: width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        color: color1,
                      ),
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Text(
                            "SLT FIBRE 1 \n\n(0112886189)",
                            style: TextStyle(
                              fontSize: width * 4 / 100,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(width * 1)),
                            child: Container(
                              width: width * 8 / 100,
                              height: height * 4 / 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/Other/about.png"),
                                fit: BoxFit.contain,
                              )),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    clickCount++;
                    getDataUsage.userSelectedConnection = "connection2";
                    setState(() {
                      changeButtonColor();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.01, height * 0.005, 0, height * 0.005),
                    child: Container(
                      width: width * 0.49,
                      height: width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        color: color2,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                            child: Text(
                              "SLT FIBRE 2 \n\n(0112054346)",
                              style: TextStyle(
                                fontSize: width * 4 / 100,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 1)),
                              child: Container(
                                width: width * 8 / 100,
                                height: height * 4 / 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage("assets/Other/about.png"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.00, 0, 0),
            child: Container(
              padding:
                  EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.00),
                color: Color(0xff4E18B9),
              ),
              width: width * 1,
              child: Text(
                "Options",
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
                width * 0.005, height * 0.005, 0, height * 0.005),
            width: width * 100 / 100,
            height: height * 23 / 100,
            color: Color(0xFF72E9FF),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      if (clickCount != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Summary()),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please select a Connection!");
                      }
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
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text(
                            "Summary",
                            style: TextStyle(
                              fontSize: width * 4 / 100,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
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
                      if (clickCount != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DailyUsage()),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please select a Connection!");
                      }
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
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text(
                            "Daily Usage",
                            style: TextStyle(
                              fontSize: width * 4 / 100,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
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
                      if (clickCount != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdditionalPackage()),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please select a Connection!");
                      }
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
                          padding: EdgeInsets.fromLTRB(0, height * 0.06, 0, 0),
                          child: Text(
                            "Data Add On",
                            style: TextStyle(
                              fontSize: width * 4 / 100,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
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
        ],
      ),
    );
  }

  void changeButtonColor() {
    if (getDataUsage.userSelectedConnection == "connection1") {
      color1 = clickedColor;
      color2 = Color(0xFF1F0F57);
    } else {
      color2 = clickedColor;
      color1 = Color(0xFF1F0F57);
    }
  }
}
