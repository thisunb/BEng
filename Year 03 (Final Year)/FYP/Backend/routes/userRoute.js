const express = require("express");
const router = express.Router();
const controller  = require("../controllers/userController");

router.post("/signup", controller.userSignup);
router.post("/login", controller.userLogin);
router.post("/passwordReset", controller.userPasswordReset);

module.exports = router;