import 'dart:convert';
import 'package:http/http.dart' as http;

class getDataUsage {
  static String userSelectedConnection = "";
  static String authorization = "";
  static String packageName = "";
  static String status = "";
  static String wifiName = "";
  static String addOnPackageExpiry = "";

  static double dataLimit = 0;
  static double dataUsed = 0;
  static double dataRemain = 0;

  static double bonusDataLimit = 0;
  static double bonusDataUsed = 0;
  static double bonusDataRemain = 0;

  static double peakLimit = 0;
  static double peakUsed = 0;
  static double peakRemain = 0;

  static double offPeakLimit = 0;
  static double offPeakUsed = 0;
  static double offPeakRemain = 0;

  static double additionalPackageDataLimit = 0;
  static double additionalPackageDataUsed = 0;
  static double additionalPackageDataRemain = 0;
  static double additionalPackageDataRemainPercentage = 0;

  static bool displayAdditionalColumn = false;

  static Map<String, String> connection = new Map();

  static List<dynamic> usageTotalHistory = [];
  static List<dynamic> usageDownloadHistory = [];
  static List<dynamic> usageUploadHistory = [];

  static bool runDailyUsage = false;

  static int userSelectedYear = 0;
  static int userSelectedMonth = 0;
  static int userSelectedDay = 0;

  List<dynamic> usageDataExtraInfo = [];
  String userSelectedDate = "";

  static double totalDataUsed = 0;
  static double standardDataUsed = 0;
  static double freeDataUsed = 0;
  static double standardUsedPercentage = 0;
  static double totalDataUsedPercentage = 0;

  static Map<String, String> connection1 = {
    "wifiName": "SLT_FIBRE 1",
    "clientId": "622cc49f-6067-415e-82cd-04b1b76f6377",
    "username": "94112886189",
    "password": "Rathukavuda123",
    "subscriberId": "a:Ez16kDjqYQFNGir50OBSDUGeEkBtTh9tCGU+vQQHY3w="
  };

  static Map<String, String> connection2 = {
    "wifiName": "SLT_FIBRE 2",
    "clientId": "622cc49f-6067-415e-82cd-04b1b76f6377",
    "username": "94112054346",
    "password": "Rathukavuda123",
    "subscriberId": "a:HBPJm/uwOCsmzVcwpQ1+xlLXotIWsI/ma2Pecsli5p0="
  };

  Future<String> getUsageData() async {
    String formData = "client_id=" +
        connection1["clientId"].toString() +
        "&grant_type=password&password=" +
        connection1["password"].toString() +
        "&scope=scope1&username=" +
        connection1["username"].toString();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    final userDataResponse = await http.post(
        Uri.parse(
            'https://omniscapp.slt.lk/mobitelint/slt/sltvasoauth/oauth2/token'),
        body: formData,
        headers: requestHeaders);

    final userData = json.decode(userDataResponse.body);

    print(userData);

    authorization = userData["access_token"].toString();

    return "User Data Received Successfully. ";
  }

  Future<String> getSummary() async {
    if (userSelectedConnection == "connection1") {
      connection = connection1;
    } else {
      connection = connection2;
    }

    wifiName = connection["wifiName"].toString();

    Map<String, String> requestHeaders2 = {
      'Authorization': "Bearer " + authorization,
      'Accept': 'application/json',
      'x-ibm-client-id': connection["clientId"].toString(),
      'subscriberid': connection["subscriberId"].toString()
    };

    final dataUsageResponse = await http.get(
        Uri.parse(
            'https://omniscapp.slt.lk/mobitelint/slt/sltvasservices/dashboard/summary'),
        headers: requestHeaders2);

    final usageData = json.decode(dataUsageResponse.body);

    // print(usageData);

    packageName = usageData["my_package_info"]["package_name"];
    status = usageData["status"];

    // print("package name - " + packageName);

    dataLimit = double.parse(usageData["my_package_summary"]["limit"]);
    dataUsed = double.parse(usageData["my_package_summary"]["used"]);
    dataRemain = double.parse((dataLimit - dataUsed).toStringAsFixed(1));

    bonusDataLimit = double.parse(usageData["bonus_data_summary"]["limit"]);
    bonusDataUsed = double.parse(usageData["bonus_data_summary"]["used"]);
    bonusDataRemain =
        double.parse((bonusDataLimit - bonusDataUsed).toStringAsFixed(1));

    peakLimit =
        double.parse(usageData["my_package_info"]["usageDetails"][0]["limit"]);
    peakUsed =
        double.parse(usageData["my_package_info"]["usageDetails"][0]["used"]);
    peakRemain = double.parse(
        usageData["my_package_info"]["usageDetails"][0]["remaining"]);

    offPeakLimit = double.parse((dataLimit - peakLimit).toStringAsFixed(1));
    offPeakUsed = double.parse((dataUsed - peakUsed).toStringAsFixed(1));
    offPeakRemain =
        double.parse((offPeakLimit - offPeakUsed).toStringAsFixed(1));

    if (usageData["vas_data_summary"] != null) {
      displayAdditionalColumn = true;

      additionalPackageDataLimit =
          double.parse(usageData["vas_data_summary"]["limit"]);
      additionalPackageDataUsed =
          double.parse(usageData["vas_data_summary"]["used"]);
      additionalPackageDataRemain = double.parse(
          (additionalPackageDataLimit - additionalPackageDataUsed)
              .toStringAsFixed(1));
    }
    return status;
  }

  Future<String> getAdditionalPackageDetails() async {
    if (userSelectedConnection == "connection1") {
      connection = connection1;
    } else {
      connection = connection2;
    }

    wifiName = connection["wifiName"].toString();

    Map<String, String> requestHeaders2 = {
      'Authorization': "Bearer " + authorization,
      'Accept': 'application/json',
      'x-ibm-client-id': connection["clientId"].toString(),
      'subscriberid': connection["subscriberId"].toString()
    };

    final dataUsageResponse = await http.get(
        Uri.parse(
            'https://omniscapp.slt.lk/mobitelint/slt/sltvasservices/dashboard/vas_data'),
        headers: requestHeaders2);

    final usageData = json.decode(dataUsageResponse.body);

    // print(usageData);

    packageName = usageData["usageDetails"][0]["name"];

    // print("Additional package name - " + packageName);

    dataLimit = double.parse(usageData["usageDetails"][0]["limit"]);
    dataUsed = double.parse(usageData["usageDetails"][0]["used"]);
    dataRemain = double.parse(usageData["usageDetails"][0]["remaining"]);
    additionalPackageDataRemainPercentage =
        double.parse((dataRemain / dataLimit).toStringAsFixed(1));

    addOnPackageExpiry = usageData["usageDetails"][0]["expiry_date"];

    return packageName;
  }

  Future<String> getDailyUsage(String date) async {
    userSelectedDate = date;

    if (runDailyUsage == false) {
      runDailyUsage = true;

      if (userSelectedConnection == "connection1") {
        connection = connection1;
      } else {
        connection = connection2;
      }

      wifiName = connection["wifiName"].toString();

      Map<String, String> requestHeaders2 = {
        'Authorization': "Bearer " + authorization,
        'Accept': 'application/json',
        'x-ibm-client-id': connection["clientId"].toString(),
        'subscriberid': connection["subscriberId"].toString()
      };

      final dataUsageResponse = await http.get(
          Uri.parse(
              "https://omniscapp.slt.lk/mobitelint/slt/sltvasservices/protocolhistory?date=" +
                  date),
          headers: requestHeaders2);

      final usageData = json.decode(dataUsageResponse.body);

      usageTotalHistory.clear();
      usageDownloadHistory.clear();
      usageUploadHistory.clear();

      usageTotalHistory.add(usageData["total"]);

      /*print(usageData);
      print("usage total history - " + usageTotalHistory.toString());*/

      usageDownloadHistory.add(usageData["download"]);
      usageUploadHistory.add(usageData["upload"]);

      //------------------- Usage Data ------------------------------

      final selectedDate =
          DateTime(userSelectedYear, userSelectedMonth, userSelectedDay);
      final currentDate = DateTime.now();
      final difference = currentDate.difference(selectedDate).inDays;

/*      print("year - " + userSelectedYear.toString());
      print("month - " + userSelectedMonth.toString());
      print("day - " + userSelectedDay.toString());*/

      int billNo = int.parse((difference / 30).toStringAsFixed(0));

      // print("bill no - " + billNo.toString());

      if ((billNo == 0)) {
        final dataUsageResponse2 = await http.get(
            Uri.parse(
                'https://omniscapp.slt.lk/mobitelint/slt/sltvasservices/dailyusage/current?billdate=01'),
            headers: requestHeaders2);

        final usageData2 = json.decode(dataUsageResponse2.body);

        // print(usageData2.toString());

        usageDataExtraInfo.clear();

        usageDataExtraInfo.add(usageData2["dailylist"]);
      } else {
        final dataUsageResponse2 = await http.get(
            Uri.parse(
                'https://omniscapp.slt.lk/mobitelint/slt/sltvasservices/dailyusage/previous/' +
                    billNo.toString() +
                    '?billdate=01'),
            headers: requestHeaders2);

        final usageData2 = json.decode(dataUsageResponse2.body);

        // print(usageData2.toString());

        usageDataExtraInfo.clear();

        usageDataExtraInfo.add(usageData2["dailylist"]);
      }

      //--------------Extracting General Usage Data------

      // Get summary if data usage is for today

      if (userSelectedDate == getCurrentDateString()) {
        final dataUsageResponse3 = await http.get(
            Uri.parse(
                'https://omniscapp.slt.lk/mobitelint/slt/sltvasservices/dashboard/summary'),
            headers: requestHeaders2);

        final usageData3 = json.decode(dataUsageResponse3.body);

        // print(usageData3);

        dataUsed = double.parse(usageData3["my_package_summary"]["used"]);
        peakUsed = double.parse(
            usageData3["my_package_info"]["usageDetails"][0]["used"]);
        offPeakUsed = double.parse((dataUsed - peakUsed).toStringAsFixed(1));
      }

      extractGeneralUsageData();

      return "Daily Usage Data Retrieved Successfully";
    } else {
      return "False";
    }
  }

  void extractGeneralUsageData() {
    double totalUsedUptoDate = 0;
    double standardUsedUptoDate = 0;
    double freeUsedUptoDate = 0;

    if (userSelectedDate == getCurrentDateString()) {
      // print("current date - " + getCurrentDateString());

      // print("extra info - " + usageDataExtraInfo.toString());

      for (int i = 0; i < (usageDataExtraInfo[0]).length; i++) {
        double tempTotal = double.parse(usageDataExtraInfo[0][i]["totalusage"]);
        double tempStandard =
            double.parse(usageDataExtraInfo[0][i]["standardusage"]);
        double tempFree = double.parse(usageDataExtraInfo[0][i]["freeusage"]);

        totalUsedUptoDate = totalUsedUptoDate + tempTotal;
        standardUsedUptoDate = standardUsedUptoDate + tempStandard;
        freeUsedUptoDate = freeUsedUptoDate + tempFree;
      }

      totalDataUsed =
          double.parse((dataUsed - totalUsedUptoDate).toStringAsFixed(1));
      freeDataUsed =
          double.parse((offPeakUsed - freeUsedUptoDate).toStringAsFixed(1));
      standardDataUsed =
          double.parse((peakUsed - standardUsedUptoDate).toStringAsFixed(1));
    } else {
      for (int i = 0; i < (usageDataExtraInfo[0]).length; i++) {
        String date = usageDataExtraInfo[0][i]["date"].toString();

        if (date == userSelectedDate) {
          totalDataUsed = double.parse(usageDataExtraInfo[0][i]["totalusage"]);
          standardDataUsed =
              double.parse(usageDataExtraInfo[0][i]["standardusage"]);
          freeDataUsed = double.parse(usageDataExtraInfo[0][i]["freeusage"]);

          totalDataUsedPercentage = double.parse(
              (usageDataExtraInfo[0][i]["totalpercentage"]).toStringAsFixed(1));

          standardUsedPercentage = double.parse((usageDataExtraInfo[0][i]
                  ["standardpercentage"])
              .toStringAsFixed(1));
        }
      }
    }

    /*print("data used - " + dataUsed.toString());
    print("free used - " + offPeakUsed.toString());
    print("standard used - " + peakUsed.toString() + "\n");

    print("total used upto date - " + totalUsedUptoDate.toString());
    print("free used upto date - " + freeUsedUptoDate.toString());
    print("standard used upto date - " + standardUsedUptoDate.toString());

    print("total used today - " + totalDataUsed.toString());
    print("free used today - " + freeDataUsed.toString());
    print("standard used today - " + standardDataUsed.toString());*/
  }

  String getCurrentDateString() {
    DateTime currentDate = DateTime.now();
    String year = currentDate.year.toString();
    String month = currentDate.month.toString();
    String day = currentDate.day.toString();

    if (int.parse(month) < 10) {
      month = "0" + month;
    }

    if (int.parse(day) < 10) {
      day = "0" + day;
    }

    return (year + "-" + month + "-" + day);
  }
}
