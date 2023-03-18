import 'dart:convert';
import 'dart:developer';

import 'package:coin_gecko/app/config/global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbConfig {
  var isAuth = false;

  late SharedPreferences _pref;

  /// set local current user
  void setCurrentUser(jsonString) async {
    try {
      if (json.decode(jsonString) != null) {
        _pref = await SharedPreferences.getInstance();
        await _pref.setString('${Constants.CURRENT_USER}', json.encode(json.decode(jsonString)));
        log("set success");
      }
    } catch (e) {
      // print(jsonString);
    }
  }

  /// get local current user
  // Future<CustomerResponse> getCurrentUser() async {
  //   var user;
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   if (pref.containsKey('current_user')) {
  //     user = CustomerResponse.fromJson(json.decode(_pref.getString("${Constants.CURRENT_USER}") ?? ""));
  //     log("get success");
  //   }
  //   log(json.encode(user).toString(), name: "get current user");
  //   return user;
  // }

  /// set user token
  void setToken(user) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString(Constants.AUTH_KEY, user ?? "");
      log("set token success");
    } catch (e) {
      log(e.toString(), name: "set token failed");
    }
  }

  /// get user authenticated key
  getAuthKey() async {
    _pref = await SharedPreferences.getInstance();
    if (_pref.containsKey(Constants.AUTH_KEY)) {
      String result = _pref.getString(Constants.AUTH_KEY) ?? "";
      // log(result, name: "DB Token");
      return result;
    }
    return null;
  }

  /// delete current user
  removeUser() async {
    _pref = await SharedPreferences.getInstance();

    if (_pref.containsKey(Constants.AUTH_KEY)) {
      _pref.remove(Constants.AUTH_KEY);
      _pref.remove(Constants.CURRENT_USER);
    }
  }
}