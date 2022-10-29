import 'package:mongo_dart/mongo_dart.dart' as mongo;

class priceData {
  static String iconToday = "";
  static String iconTomorrow = "";
  static String iconNextWeek = "";

  static double beansPrice = 0,
      carrotPrice = 0,
      leeksPrice = 0,
      knolkholPrice = 0,
      cabbagePrice = 0,
      tomatoPrice = 0,
      ladiesfingersPrice = 0,
      brinjalsPrice = 0,
      pumpkinPrice = 0,
      cucumberPrice = 0,
      bittergourdPrice = 0,
      greenchiliesPrice = 0,
      beetrootPrice = 0,
      potatoPrice = 0;
  static double bananaPrice = 0,
      limePrice = 0,
      papayaPrice = 0,
      pineapplePrice = 0,
      mangoPrice = 0,
      avocadoPrice = 0;

  static String dateHeading = "";

  static Map beans = Map<dynamic, dynamic>();
  static Map carrot = Map<String, dynamic>();
  static Map leeks = Map<String, dynamic>();
  static Map knolkhol = Map<String, dynamic>();
  static Map cabbage = Map<String, dynamic>();
  static Map tomato = Map<String, dynamic>();
  static Map ladiesfingers = Map<String, dynamic>();
  static Map brinjals = Map<String, dynamic>();
  static Map pumpkin = Map<String, dynamic>();
  static Map cucumber = Map<String, dynamic>();
  static Map bittergourd = Map<String, dynamic>();
  static Map greenchilies = Map<String, dynamic>();
  static Map beetroot = Map<String, dynamic>();
  static Map potato = Map<String, dynamic>();
  static Map banana = Map<String, dynamic>();
  static Map lime = Map<String, dynamic>();
  static Map papaya = Map<String, dynamic>();
  static Map pineapple = Map<String, dynamic>();
  static Map mango = Map<String, dynamic>();
  static Map avocado = Map<String, dynamic>();

  Future<String> getData() async {
    var db = await mongo.Db.create(
        "mongodb+srv://fruge:frugedatabase@frugedatabase.4krmx.mongodb.net/Fruge");
    await db.open();

    print("DB Connected");

    var collection = db.collection(getCurrentDate());
    var response = await collection.find().toList();
    db.close();

    List itemList = [
      beans,
      carrot,
      leeks,
      beetroot,
      knolkhol,
      cabbage,
      tomato,
      ladiesfingers,
      brinjals,
      pumpkin,
      cucumber,
      bittergourd,
      greenchilies,
      lime,
      potato,
      banana,
      papaya,
      pineapple,
      mango,
      avocado
    ];

    for (int i = 0; i < 20; i++) {
      itemList.elementAt(i).addAll(response[i]);
    }

    return "completed";
  }

  void setPriceData(String day) {
    beansPrice = double.parse(beans[day]);
    carrotPrice = double.parse(carrot[day]);
    leeksPrice = double.parse(leeks[day]);
    knolkholPrice = double.parse(knolkhol[day]);
    cabbagePrice = double.parse(cabbage[day]);
    tomatoPrice = double.parse(tomato[day]);
    ladiesfingersPrice = double.parse(ladiesfingers[day]);
    brinjalsPrice = double.parse(brinjals[day]);
    pumpkinPrice = double.parse(pumpkin[day]);
    cucumberPrice = double.parse(cucumber[day]);
    bittergourdPrice = double.parse(bittergourd[day]);
    greenchiliesPrice = double.parse(greenchilies[day]);
    beetrootPrice = double.parse(beetroot[day]);
    potatoPrice = double.parse(potato[day]);

    bananaPrice = double.parse(banana[day]);
    limePrice = double.parse(lime[day]);
    papayaPrice = double.parse(papaya[day]);
    pineapplePrice = double.parse(pineapple[day]);
    mangoPrice = double.parse(mango[day]);
    avocadoPrice = double.parse(avocado[day]);

    if (day == "today") {
      dateHeading = "Price forecast for today " + beans["date"];
    } else if (day == "tomorrow") {
      dateHeading = "Price forecast for tomorrow " + beans["tomorrowDate"];
    } else {
      dateHeading = "Price forecast for Next Week " + beans["nextWeekDate"];
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();

    String yearText = "";
    String monthText = "";
    String dayText = "";
    String currentDate = "";

    int year = now.year;
    int month = now.month;
    int day = now.day;

    yearText = year.toString();
    monthText = month.toString();
    dayText = day.toString();

    if (month < 10) {
      monthText = "0" + monthText;
    }

    if (day < 10) {
      dayText = "0" + dayText;
    }

    currentDate = yearText + "-" + monthText + "-" + dayText;

    print(currentDate);

    return currentDate;
  }

  void setDateIcons() {
    iconToday = beans["date"].substring(8, 10);
    iconTomorrow = beans["tomorrowDate"].substring(8, 10);
    iconNextWeek = beans["nextWeekDate"].substring(8, 10);
  }
}
