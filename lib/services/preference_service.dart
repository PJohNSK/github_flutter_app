import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constant.dart' as constant;

class PreferenceService {
  static const String locale = "LOCALE";
  static const String isLogin  ="IS_LOGIN";

  SharedPreferences pref;

  PreferenceService(this.pref);

  static Future<PreferenceService> init() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return PreferenceService(sharedPref);
  }

  setLoggedIn(bool value) {
    pref.setBool(isLogin, value);
    debugPrint("Is Login stored successfully");
  }

  bool isLoggedIn() {
    return pref.getBool(isLogin) ?? false;
  }

  setLocale(String value) {
    pref.setString(locale, value);
    debugPrint("Locale stored successfully");
  }

  String getLocale() {
    return pref.getString(locale) ?? constant.Locale.ENGLISH;
  }

  clearData() async {
    pref.clear();
  }


}
