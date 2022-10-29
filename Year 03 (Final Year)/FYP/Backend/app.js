const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const cors = require('cors')
var fileupload = require("express-fileupload");

// --- Import all routes ---
const userRoute = require("./routes/userRoute");
const forecastRoute = require("./routes/forecastRoute");
const dataModelRoute = require("./routes/dataModelRoute");

app.use(cors());
app.use(bodyParser.urlencoded({extended: false})); 
app.use(bodyParser.json());
app.use(fileupload());
app.use("/userAuth", userRoute);
app.use("/forecastData", forecastRoute);
app.use("/dataModel", dataModelRoute);

// --- Retrieve continous flask server updates ---
const MongoClient = require("mongodb").MongoClient;
var MONGODB_PRICE_FORECAST_URI = "mongodb+srv://commodity_data:commodity_data12345678@cluster0.w1pij.mongodb.net/";

const http = require("http")
const {Server} = require("socket.io");
const server = http.createServer(app);
const io = new Server(server)

io.on("connection", (socket) => {
    MongoClient.connect(MONGODB_PRICE_FORECAST_URI, function (err, db) {
		if (err) throw err;
		else {
            console.log("Connected to price forecast database.");
            var databaseObject = db.db("commodity_data");
            var collection  = databaseObject.collection("server_updates")
            changeStream = collection.watch();
            changeStream.on("change", change => {
            databaseObject
            	.collection("server_updates")
            	.find()
            	.toArray(function (err, result) {
        		    if (err) throw err;
            	    else {
                    socket.emit("receive_message", result[0])
            	    }
            	});
            });
        }
	});    
})

// --- Start listening on the server ---
server.listen(4000);
console.log("Server started at 4000.");
