const request = require('request-promise');
const MongoClient = require("mongodb").MongoClient;
var MONGODB_PRICE_FORECAST_URI = "mongodb+srv://commodity_data:commodity_data12345678@cluster0.w1pij.mongodb.net/";

// --- Model train / forecast function ---
exports.modelTrainForecast = (req, res) => {

	sendModelTrainForecastRequest(req)

	async function sendModelTrainForecastRequest(req) {

		var data = {
			commodityList: req.body.commodityList,
			parameterTuning: req.body.parameterTuning,
			modelTrain: req.body.modelTrain,
			priceForecast: req.body.priceForecast
		}

		var options = {
			method: 'POST',
			uri: 'http://127.0.0.1:5000/executeTrainForecast',
			body: data,
			json: true
		};

		await request(options)
		.then((response) => {
			console.log(response);
			res.json(response)
		})	
		.catch((err) => {
			console.log(err);
		});	
	}
};

// --- Retrieve hyper parameter data --- 
exports.parameterData = (req, res) => {

	MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
		if (err) throw err;
		else {
		console.log("Connected to price forecast database.");
		var databaseObject = db.db("model_data");
		databaseObject
			.collection("Multivariate LSTM_parameter_tuning")
			.find()
			.toArray(function (err, result) {
				if (err) throw err;
				else {
					res.json(result)
				}
			});
		}
	});
};

// --- Retrieve model train data --- 
exports.modelTrainData = (req, res) => {

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
					res.json(result)
				}
			});
		}
	});
};

// --- Retrieve data files details ---
exports.dataFilesInfo = (req, res) => {

	MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
		if (err) throw err;
		else {
		console.log("Connected to price forecast database.");
		var databaseObject = db.db("commodity_data");
		databaseObject
			.collection("saved_data_files")
			.find()
			.toArray(function (err, result) {
				if (err) throw err;
				else {
					res.json(result[0])
				}
			});
		}
	});
};

// --- Check if process running in flask server ---
exports.checkRunningProcess = (req, res) => {

	MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
		if (err) throw err;
		else {
		console.log("Connected to price forecast database.");
		var databaseObject = db.db("commodity_data");
		databaseObject
			.collection("server_updates")
			.find()
			.toArray(function (err, result) {
				if (err) throw err;
				else {
					res.json(result)
				}
			});
		}
	});
};

exports.updates = (req, res) => {

	refreshFlaskServer()

	async function refreshFlaskServer() {

		var options = {
			method: 'POST',
			uri: 'http://127.0.0.1:5000/refreshServer',
			body: null,
			json: true
		};

		await request(options)
		.then((response) => {
			console.log(response);
			res.status(201).json({
				response,
			});
		})
		.catch((err) => {
			console.log(err);
		});	
	}
};