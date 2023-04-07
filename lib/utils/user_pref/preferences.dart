import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  static const _userId = 'user_id';
  static Future init() async {
    return preferences = await SharedPreferences.getInstance();
  }

  static Future setUserID(String userId) async {
    log("saved user in db");
    await preferences.setString(_userId, userId);
  }



  String getUserId() => preferences.getString(_userId) ?? "";
}
