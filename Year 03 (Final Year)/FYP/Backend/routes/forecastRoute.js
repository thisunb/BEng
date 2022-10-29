const express = require("express");
const router = express.Router();
const controller  = require("../controllers/forecastController");

router.get("/dailyForecast", controller.dailyForecast);
router.get("/weeklyForecast", controller.weeklyForecast);
router.get("/monthlyForecast", controller.monthlyForecast);

module.exports = router;