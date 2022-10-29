const express = require("express");
const router = express.Router();
const controller  = require("../controllers/dataModelController");

router.post("/trainForecast", controller.modelTrainForecast);
router.post("/updates", controller.updates);
router.get("/checkRunningProcess", controller.checkRunningProcess);
router.get("/dataFilesInfo", controller.dataFilesInfo);
router.get("/parameterData", controller.parameterData);
router.get("/modelTrainData", controller.modelTrainData);

module.exports = router;