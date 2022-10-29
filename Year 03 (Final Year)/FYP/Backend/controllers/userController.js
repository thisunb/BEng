const mongoose = require("mongoose");
const userModel = require("../models/userModel");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// Connect to user accounts database
var MONGODB_USER_ACCOUNT_URI =
  "mongodb+srv://commodity_data:commodity_data12345678@cluster0.w1pij.mongodb.net/user_accounts?retryWrites=true&w=majority";
mongoose.connect(MONGODB_USER_ACCOUNT_URI, (err) => {
  if (err) {
    console.error("Connection error occurred!", err);
  } else {
    console.log("Connected to user accounts database.");
  }
});

// User signup function
exports.userSignup = (req, res) => {
  userModel
    .find({ userName: req.body.userName })
    .exec()
    .then((user) => {
      if (user.length >= 1) {
        return res.status(409).json({
          message: "User name already exists.",
        });
      } else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).json({
              error: err,
            });
          } else {
            const user = new userModel({
              _id: new mongoose.Types.ObjectId(),
              firstName: req.body.firstName,
              lastName: req.body.lastName,
              userName: req.body.userName,
              email: req.body.email,
              password: hash,
              createdDate: req.body.created_Date,
            });
            user
              .save()
              .then((result) => {
                console.log(result);
                res.status(201).json({
                  message: "New user has been created.",
                });
              })
              .catch((err) => {
                console.log(err);
                res.status(500).json({
                  message: "Unknown error occurred.",
                });
              });
          }
        });
      }
    });
};

// User login function
exports.userLogin = (req, res) => {
  userModel
    .find({ userName: req.body.userName })
    .exec()
    .then((user) => {
      if (user.length < 1) {
        return res.status(401).json({
          message: "Authentication failed, invalid username.",
        });
      }
      bcrypt.compare(req.body.password, user[0].password, (err, result) => {
        if (err) {
          return res.status(401).json({
            message: "Authentication failed, try again.",
          });
        }
        if (result) {
          const token = jwt.sign(
            {
              userName: user[0].userName,
              userId: user[0]._id,
            },
            "secret",
            {
              expiresIn: "1h",
            }
          );
          return res.status(200).json({
            auth: true,
            message: "Authentication successful.",
            token: token,
          });
        }
        res.status(401).json({
          message: "Authentication failed, enter the correct password.",
        });
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        error: err,
      });
    });
};

// User password reset function
exports.userPasswordReset = (req, res) => {
  userModel
    .find({ userName: req.body.userName })
    .exec()
    .then((user) => {
      if (user.length < 1) {
        return res.status(401).json({
          message: "Authentication failed, invalid user name.",
        });
      }

      if (req.body.email != user[0].email) {
        return res.status(405).json({
          message: "Authentication failed, email & password mismatch.",
        });
      }
      var firstName = user[0].firstName;
      var lastName = user[0].lastName;
      userModel.remove({ _id: user[0]._id }).exec();
      bcrypt.hash(req.body.password, 10, (err, hash) => {
        if (err) {
          return res.status(500).json({
            error: err,
          });
        } else {
          const user = new userModel({
            _id: new mongoose.Types.ObjectId(),
            firstName: firstName,
            lastName: lastName,
            userName: req.body.userName,
            email: req.body.email,
            password: hash,
            created_Date: req.body.created_Date,
          });

          user
            .save()
            .then((result) => {
              console.log(result);
              res.status(201).json({
                message: "Password reset successful.",
              });
            })
            .catch((err) => {
              console.log(err);
              res.status(500).json({
                error: err,
              });
            });
        }
      });
    });
};
