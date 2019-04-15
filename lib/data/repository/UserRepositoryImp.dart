/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';

import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/api/ServiceController.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/data/repository/UserRepository.dart';
import 'package:meshi/managers/session_manager.dart';

class UserRepositoryImp extends UserRepository {
  final api = ServiceController.instance;

  @override
  Future<User> fetchUser() async {
    return null;
  }

  @override
  Future<User> loginUser(String id) async {
    var response = await api.post("auth/login-facebook", id);
    SessionManager.instance.authToken = response.data['token'];
    if (response.data['user'] == null) {
      return User(state: response.data['state']);
    }
    return User.fromJson(json.decode(response.data['user']));
  }

  @override
  Future<BaseResponse> updateUserBasicInfo(User user) async {
    return await api.put("users/basic", user.toJson().toString());
  }
}
