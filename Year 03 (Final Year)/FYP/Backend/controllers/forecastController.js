const MongoClient = require("mongodb").MongoClient;
var MONGODB_PRICE_FORECAST_URI = "mongodb+srv://commodity_data:commodity_data12345678@cluster0.w1pij.mongodb.net/";
var allForecastData = [];
var dailyForecastData = [];
var weeklyForecastData = [];
var monthlyForecastData = [];

// --- Send daily forecast data ---
exports.dailyForecast = (req, res) => {
  allForecastData = [];
  dailyForecastData = [];

  //  --- Retrieve all forecast data ---
  MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
    if (err) throw err;
    else {
      console.log("Connected to price forecast database.");
      var databaseObject = db.db("commodity_data");
      databaseObject
        .collection("forecast_data")
        .find()
        .toArray(function (err, result) {
          if (err) throw err;
          else {
            for (var i = 0; i < result.length; i++) {
              singleCommodityDataDictionary = {"item_name": result[i]["item_name"], "item_type": result[i]["item_type"], "forecast_data": result[i]["forecast_data"]};
              allForecastData.push(singleCommodityDataDictionary);
            }
            console.log("Forecast data retrieved.");
            db.close();

            // --- Categorize daily forecast data & send response ---
            createDailyForecast()
            res.json(dailyForecastData)
          }
        });
    }
  });
};

// --- Send weekly forecast data ---
exports.weeklyForecast = (req, res) => {
  allForecastData = [];
  weeklyForecastData = [];

  // --- Retrieve all forecast data ---
  MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
    if (err) throw err;
    else {
      console.log("Connected to price forecast database.");
      var databaseObject = db.db("commodity_data");
      databaseObject
        .collection("forecast_data")
        .find()
        .toArray(function (err, result) {
          if (err) throw err;
          else {
            for (var i = 0; i < result.length; i++) {
              singleCommodityDataDictionary = {"item_name": result[i]["item_name"], "forecast_data": result[i]["forecast_data"]};
              allForecastData.push(singleCommodityDataDictionary);
            }
            console.log("Forecast data retrieved.");
            db.close();

            // --- Categorize weekly forecast data & send response ---
            createWeeklyForecast()
            res.json(weeklyForecastData)
          }
        });
    }
  });
};

// --- Send monthly forecast data ---
exports.monthlyForecast = (req, res) => {
  allForecastData = [];
  monthlyForecastData = [];

  // --- Retrieve forecast data ---
  MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
    if (err) throw err;
    else {
      console.log("Connected to price forecast database.");
      var databaseObject = db.db("commodity_data");
      databaseObject
        .collection("forecast_data")
        .find()
        .toArray(function (err, result) {
          if (err) throw err;
          else {
            for (var i = 0; i < result.length; i++) {
              singleCommodityDataDictionary = {"item_name": result[i]["item_name"], "forecast_data": result[i]["forecast_data"]};
              allForecastData.push(singleCommodityDataDictionary);
            }
            console.log("Forecast data retrieved.");
            db.close();

            // --- Categorize monthly forecast data & send response ---
            createMothlyForecast()
            res.json(monthlyForecastData)
          }
        });
    }
  });
};

// --- Categorize daily forecast data ---
function createDailyForecast(){
  for (var i = 0; i < allForecastData.length; i++) {
    var forecastData = allForecastData[i]["forecast_data"]
    if(forecastData.length > 0){
      tempDict = {"item_name": allForecastData[i]["item_name"], "item_type": allForecastData[i]["item_type"], "forecast_data": forecastData};
      dailyForecastData.push(tempDict);
    }
  }
}

// --- Categorize weekly forecast data ---
function createWeeklyForecast(){
  var weeklySingleCommodityData = [];
  console.log('all forecast length -', allForecastData.length)
  for (var i = 0; i < allForecastData.length; i++){
    var forecastData = allForecastData[i]["forecast_data"]
    var tempArray = []
    var weekStartDate;

    // console.log('forecast length - ', forecastData.length)

    if(forecastData.length > 0){
      for (var j = 0; j < forecastData.length; j++){
        var date = new Date(forecastData[j]["date"])
        dateInt = parseInt(date.getDay())

        console.log('j - ', j)
        console.log('date int - ', dateInt)

        if(dateInt == 1){
          if(tempArray.length > 0){
            if(j == (forecastData.length - 1)){
              tempArray.push(forecastData[j])
            }
            tempDict = {"week_category": "Week starting from " + (weekStartDate.getDate() + " " + 
            getMonthName(weekStartDate.getMonth() + 1) + " " + 
            weekStartDate.getFullYear()), "weekly_data": tempArray}
            weeklySingleCommodityData.push(tempDict)
            tempArray = []
          }
          weekStartDate = date
          tempArray.push(forecastData[j])
        }
        else{
          if(weekStartDate == undefined){
            if(dateInt == 0){
              dateInt = 7
            }
            weekStartDate = new Date(date.setDate(date.getDate() - (dateInt - 1)))
            console.log(weekStartDate)
          }
          tempArray.push(forecastData[j])
          if(j == (forecastData.length - 1)){
            tempDict = {"week_category": "Week starting from " + (weekStartDate.getDate() + " " + 
            getMonthName(weekStartDate.getMonth() + 1) + " " + 
            weekStartDate.getFullYear()), "weekly_data": tempArray}
            weeklySingleCommodityData.push(tempDict)
            tempArray = []
          }
        }
      }
      mainDataDict = {"item_name": allForecastData[i]["item_name"], "forecast_data": weeklySingleCommodityData}
      weeklyForecastData.push(mainDataDict)
      weeklySingleCommodityData = []
      tempArray = []
      weekStartDate = undefined
    }
  }
};

// --- Categorize monthly forecast data ---
function createMothlyForecast(){
  var monthlySingleCommodityData = [];
  for (var i = 0; i < allForecastData.length; i++){
    var forecastData = allForecastData[i]["forecast_data"]

    // console.log('forecast length - ', forecastData.length)

    if(forecastData.length > 0){  
      var tempArray = []
      var prevMonth = parseInt(new Date(forecastData[0]["date"]).getMonth() + 1)
      var prevYear = parseInt(new Date(forecastData[0]["date"]).getFullYear())
      
      for (var j = 0; j < forecastData.length; j++){
        var date = new Date(forecastData[j]["date"]);
        var currentMonth = parseInt(date.getMonth() + 1)
        var currentYear = parseInt(date.getFullYear())

        if(j != (forecastData.length - 1)){
          if(currentMonth == prevMonth){
            tempArray.push(forecastData[j])
            continue
          }
          else{
            // --- Adding categorized data to array ---
            tempDict = {"month_category": (getMonthName(prevMonth) + " " + prevYear), "monthly_data": tempArray}
            monthlySingleCommodityData.push(tempDict)

            // --- Reset variables ---
            tempArray = []
            prevMonth = currentMonth
            prevYear = currentYear

            // --- Add first element of next array ---
            tempArray.push(forecastData[j])
          }
        }
        else{
          // --- Handling last set of data for categorizing ---
          tempArray.push(forecastData[j])
          tempDict = {"month_category": (getMonthName(prevMonth) + " " + prevYear), "monthly_data": tempArray}
          monthlySingleCommodityData.push(tempDict)
        }
      }
      mainDataDict = {"item_name": allForecastData[i]["item_name"], "forecast_data": monthlySingleCommodityData}
      monthlyForecastData.push(mainDataDict)
      monthlySingleCommodityData = []
      tempArray = []
      weekStartDate = undefined
    }
  }
};

// --- Get month string by name ---
function getMonthName(monthNumber){
  switch (monthNumber){
    case 1:
      return "January"
    case 2:
      return "February"
    case 3: 
      return "March"
    case 4: 
      return "April"
    case 5:
      return "May"
    case 6:
      return "June"
    case 7:
      return "July"
    case 8:
      return "August"
    case 9:
      return "September"
    case 10:
      return "October"
    case 11:
      return "November"
    case 12:
      return "December"
    default:
      return ""
  }
}