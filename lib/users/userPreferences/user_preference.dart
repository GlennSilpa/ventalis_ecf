import 'dart:convert';

import 'package:ecf_studi2/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs
{
  //sauvegarder Info Utilisateur
  static Future<void> saveRememberUser(User userInfo) async
{
  SharedPreferences preferences = await SharedPreferences.getInstance();
 String userJsonData = jsonEncode(userInfo.toJson());
 await preferences.setString("currentUser", userJsonData);
}
}