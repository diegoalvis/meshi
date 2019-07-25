/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  User user;
  RewardInfo rewardInfo;

  SharedPreferences _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) return _preferences;
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  Future<bool> get logged async => await preferences.then((value) => value.getBool("logged") ?? false);

  void setLogged(bool value) async {
    final prefs = await preferences;
    await prefs.setBool("logged", value);
  }

  SessionManager() {
    initUser();
  }

  Future<User> initUser() {
    return preferences.then((prefs) {
      try {
        user = User.fromJson(jsonDecode(prefs.getString("user")));
        return user;
      } catch (error) {
        return null;
      }
    });
  }

  void saveWinner(RewardInfo rewardInfo) {
    if (rewardInfo != null) {
      this.rewardInfo = rewardInfo;
      preferences.then((prefs) => prefs.setString("reward", jsonEncode(rewardInfo.toJson())));
    }
  }

  Future<RewardInfo> get rewardInfoWinner async {
    final prefs = await preferences;
    String notNull = prefs.getString("reward");
    if (notNull != null) {
      rewardInfo = RewardInfo.fromJson(jsonDecode(notNull));
      return rewardInfo;
    } else
      return null;
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

  Future<int> get userId async {
    final prefs = await preferences;
    user = User.fromJson(jsonDecode(prefs.getString("user")));
    return user.id;
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

  Future<String> get fbToken async {
    final prefs = await preferences;
    return prefs.getString("fbToken");
  }

  void setFbToken(String value) async {
    final prefs = await preferences;
    await prefs.setString("fbToken", value);
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

  Future<String> get fbUserId async {
    final prefs = await preferences;
    return prefs.getString("fbUserId");
  }

  void setFbUserId(String value) async {
    final prefs = await preferences;
    await prefs.setString("fbUserId", value);
  }

  Future<String> get firebaseToken async {
    final prefs = await preferences;
    return prefs.getString("firebaseToken");
  }

  void setFirebaseToken(String authToken) async {
    final prefs = await preferences;
    await prefs.setString("firebaseToken", authToken);
  }

  Future<int> get currentChatId async {
    final prefs = await preferences;
    return prefs.getInt("currentChatId");
  }

  void setCurrentChatId(int value) async {
    final prefs = await preferences;
    await prefs.setInt("currentChatId", value);
  }

  Future<int> recomendationTry(int maxTry) async{

    if(maxTry == 0){
      return 0;
    }

    final prefs = await preferences;

    final now = DateTime.now().toLocal();
    final valid = prefs.getString("dateTry");

    if(valid == "${now.year}-${now.month}-${now.day}"){
      return prefs.getInt("recomendationTry");
    }else{
      await prefs.setInt("recomendationTry", maxTry);
      await prefs.setString("dateTry", "${now.year}-${now.month}-${now.day}");
      return maxTry;
    }
  }

  void useRecomendationTry() async {
    final prefs = await preferences;
    final tryValue = prefs.getInt("recomendationTry");
    await prefs.setInt("recomendationTry", tryValue - 1);
  }

  Future<int> recomendationPage() async{

    final prefs = await preferences;

    final now = DateTime.now().toLocal();
    final valid = prefs.getString("dateTry");

    if(valid == "${now.year}-${now.month}-${now.day}"){
      return prefs.getInt("recomendationPage");
    }else{
      await prefs.setInt("recomendationPage", 0);
      await prefs.setString("dateTry", "${now.year}-${now.month}-${now.day}");
      return 0;
    }
  }

  void nextRecomendationPage() async {
    final prefs = await preferences;
    final page = prefs.getInt("recomendationPage");

    if(page == null){
      final now = DateTime.now().toLocal();
      await prefs.setString("dateTry", "${now.year}-${now.month}-${now.day}");
    }
    await prefs.setInt("recomendationPage", (page ?? 0 ) + 1);
  }


  Future<bool> getSettingsNotification(String key) async {
    final prefs = await preferences;
    return prefs.getBool(key);
  }

  void setSettingsNotification(bool value, String key) async {
    final prefs = await preferences;
    await prefs.setBool(key, value);
  }
}
