import 'dart:convert';
import 'dart:io';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:path_provider/path_provider.dart';

class userAccounts {
  String savedUsername = "";
  static bool userLogged = false;

  Future<int> login(String userName, password) async {
    print("username - " + userName + "\n" + "password - " + password);

    var db = await mongo.Db.create(
        "mongodb+srv://fruge:frugedatabase@frugedatabase.4krmx.mongodb.net/test");
    await db.open();

    print("DB Connected");

    var collection = db.collection("userdetails");
    var user =
        await collection.find(mongo.where.eq("userName", userName)).toList();

    if (user.isNotEmpty) {
      Map userMap = Map<String, dynamic>();
      userMap.addAll(user[0]);

      DBCrypt hash = new DBCrypt();

      var result = hash.checkpw(password, userMap["password"]);

      if (result == true) {
        print("login successful!");
        userLogged = true;
        saveUserData(userName);

        return 200;
      } else {
        print("password mismatch!");
        return 400;
      }
    } else {
      print("username does not exist!");
      return 401;
    }
  }

  Future<int> signUp(String firstName, lastName, userName, email, password,
      confirmPassword) async {
    print("firstName - " +
        firstName +
        "\n" +
        "lastName - " +
        lastName +
        "\n" +
        "userName - " +
        userName +
        "\n" +
        "email - " +
        email +
        "\n" +
        "password - " +
        password +
        "\n" +
        "confirm password - " +
        confirmPassword);

    var db = await mongo.Db.create(
        "mongodb+srv://fruge:frugedatabase@frugedatabase.4krmx.mongodb.net/test");
    await db.open();

    print("DB Connected");

    var collection = db.collection("userdetails");
    var user =
        await collection.find(mongo.where.eq("userName", userName)).toList();

    if (user.isEmpty) {
      DBCrypt hash = new DBCrypt();

      var hashedPassword = hash.hashpw(password, hash.gensalt());

      var result = await collection.insertOne({
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'password': hashedPassword
      });

      if (result.isSuccess) {
        print("Account created successfully");
        return 200;
      } else if (result.isFailure) {
        print("An error occurred while creating the account!");
        return 402;
      } else {
        print("Unknown error occurred!");
        return 403;
      }
    } else {
      print("username already exists!");
      return 401;
    }
  }

  saveUserData(String username) async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    File file = await File("${directory!.path}/userData.json").create();

    String fileContent = json.encode({
      "currentUser": {"username": username},
    });
    print("UserData saved successfully.");
    return await file.writeAsString(fileContent);
  }

  loadUserData() async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    File file = await File("${directory!.path}/userData.json").create();

    var fileContent = await file.readAsString();

    print("Data loaded successfully.");

    Map userDataMap = jsonDecode(fileContent);

    savedUsername = userDataMap["currentUser"]["username"];

    if (savedUsername.isNotEmpty) {
      userLogged = true;
    }
  }
}
