import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mobile_items.dart';

class Utility {
  List<MobileItem> mobileItems = [
    MobileItem(
        name: "Apple Iphone 14 (Blue, 128 Gb)",
        image: "image1.png",
        price: 499.99),
    MobileItem(
        name: "Apple Iphone 14 (Midnight, 128 Gb)",
        image: "image2.jpeg",
        price: 599.99),
    MobileItem(
        name: "Apple Iphone 14 (Blue, 128 Gb)",
        image: "image1.png",
        price: 499.99),
    MobileItem(
        name: "Apple Iphone 14 (Midnight, 128 Gb)",
        image: "image2.jpeg",
        price: 599.99),
    MobileItem(
        name: "Apple Iphone 14 (Blue, 128 Gb)",
        image: "image1.png",
        price: 499.99),
    MobileItem(
        name: "Apple Iphone 14 (Midnight, 128 Gb)",
        image: "image2.jpeg",
        price: 599.99),
    MobileItem(
        name: "Apple Iphone 14 (Blue, 128 Gb)",
        image: "image1.png",
        price: 499.99),
    MobileItem(
        name: "Apple Iphone 14 (Midnight, 128 Gb)",
        image: "image2.jpeg",
        price: 599.99),
  ];

  static void showCustomSnackbar(
      BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  static Future<bool> saveLogin(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("login", data);
    return true;
  }

  static Future<String> getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("login") ?? "";
    debugPrint('getLoginData: $data');
    return data;
  }

  static saveUserData(String userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", userData);
  }

  static Future<String> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("userData") ?? "";
    debugPrint('GetUserData: $userData');
    return userData;
  }

//--Get--User--Data-----
  static clearPreferenceData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

//--Get--User--Data-----
  Future<LoginDataModel?> getUserProfileData() async {
    String? res = await getUserData();
    if (res != "null" && res != "") {
      var data = loginDataModelFromJson(res.toString());
      debugPrint("user email = ${data.user!.email}");
      debugPrint("user phone = ${data.user!.phone}");
      return data;
    } else {
      return null;
    }
  }
}
