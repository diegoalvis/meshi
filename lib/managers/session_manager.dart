/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'package:meshi/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  //User user;
  //String fbUserId;
  //String fbToken;
  //String authToken;

  User user;
  String _fbUserId = "10219787681781369";
  String _fbToken =
      "EAADuaK7hfRIBAMkKI0yEfUUOCEgAwLSqz39hS7pcjtXP6gZB0rXQ5ZAZAiOJiZC0Fv3G8Y4ZAtPC2IGJBbHsMd06YZAnKb2EyfVIlIZAoNzZCoYUo1OstAHN6MsZA8VFtt9ItXoePXKxfUQcZCqW4Y3mt1rvK8VcGLCaCD5pRuhoaYL3lN8J0dIPqRRlUJHPy8ifgZD";

  SharedPreferences _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) return _preferences;
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  Future<bool> get logged async => await preferences.then((value) => value.getBool("logged") ?? false);

  void setLogged(bool value) {
    preferences.then((prefs) => prefs.setBool("logged", value));
  }

  Future<User> initUser() {
    return preferences.then((prefs) {
      try {
        _fbToken = prefs.getString("fbToken");
        _fbUserId = prefs.getString("fbUserId");
        user = User.fromJson(jsonDecode(prefs.getString("user")));
        return user;
      } catch (error) {
        return null;
      }
    });
  }

  void saveUser(User user) {
    if (user != null) {
      this.user = user;
      preferences.then((prefs) => prefs.setString("user", jsonEncode(user.toJson())));
    }
  }

  void setToken(String value) async {
    final prefs = await preferences;
    await prefs.setString("token", value);
  }

  Future<String> get name async {
    final prefs = await preferences;
    return prefs.getString("name");
  }

  void setName(String value) async {
    final prefs = await preferences;
    await prefs.setString("name", value);
  }

  Future<String> get id async {
    final prefs = await preferences;
    return prefs.getString("id");
  }

  void setId(String value) async {
    final prefs = await preferences;
    await prefs.setString("id", value);
  }

  Future<String> get phone async {
    final prefs = await preferences;
    return prefs.getString("phone");
  }

  void setPhone(String value) async {
    final prefs = await preferences;
    await prefs.setString("phone", value);
  }

  Future<bool> get disability async {
    final prefs = await preferences;
    return prefs.getBool("disability") ?? false;
  }

  void setDisability(bool value) async {
    final prefs = await preferences;
    await prefs.setBool("disability", value);
  }

  Future<int> get cash async {
    final prefs = await preferences;
    return prefs.getInt("cash");
  }

  void setCash(int value) async {
    final prefs = await preferences;
    await prefs.setInt("cash", value);
  }

  Future<DateTime> get lastTransaction async {
    final prefs = await preferences;
    String date = prefs.getString("lastTransaction");
    return date != null ? DateTime.parse(date) : null;
  }

  void setLastTransaction(DateTime value) async {
    final prefs = await preferences;
    String date = value?.toIso8601String();
    await prefs.setString("lastTransaction", date);
  }

  void clear() async {
    final prefs = await preferences;
    prefs.clear();
  }

  String get fbToken => _fbToken;

  set fbToken(String value) {
    preferences.then((prefs) => prefs.setString("fbToken", value));
    _fbToken = value;
  }

  Future<String> get authToken async {
    final prefs = await preferences;
    String tk = prefs.getString("authToken");
    return "Bearer $tk";
  }

  void setAuhToken(String authToken) async {
    final prefs = await preferences;
    await prefs.setString("authToken", authToken);
  }

  String get fbUserId => _fbUserId;

  set fbUserId(String value) {
    preferences.then((prefs) => prefs.setString("fbUserId", value));
    _fbUserId = value;
  }
}
