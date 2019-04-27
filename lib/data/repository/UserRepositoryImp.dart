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
import 'package:rxdart/rxdart.dart';

class UserRepositoryImp extends UserRepository {
  final api = ServiceController.instance;

  @override
  Future<User> fetchUser() async {
    return null;
  }

  @override
  Observable<User> loginUser(String id) {
    return Observable(api.post("auth/login-facebook", "{\"id\": \"$id\"}").asStream().map((response) {
      SessionManager.instance.authToken = response.data['token'];
      if (response.data['user'] == null) {
        return User(state: response.data['state']);
      }
      return User.fromJson(response.data['user']);
    }));
  }

  @override
  Observable<BaseResponse> updateUserBasicInfo(User user) {
    return Observable(
        api.put("users/basic", user.toJson().toString())
            .catchError((error) => Observable.error(error.toString()))
            .asStream());
  }

  @override
  Observable<BaseResponse> uploadImage(String imageBase64) {
    String body = "{\"base64\": \"$imageBase64\"}";
    return Observable.fromFuture(api.post("img", body));
  }
}
