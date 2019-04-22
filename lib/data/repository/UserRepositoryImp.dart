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
  Future<User> loginUser(String id) async {
    var response = await api.post("auth/login-facebook", "{\"id\": \"$id\"}");
    SessionManager.instance.authToken = response.data['token'];
    if (response.data['user'] == null) {
      return User(state: response.data['state']);
    }

    // TODO remove this
    response.data['user']['state'] = "new";
    return User.fromJson(response.data['user']);
  }

  @override
  Observable<BaseResponse> updateUserBasicInfo(User user) {
    try {
      return Observable.fromFuture(api.put("users/basic", user.toJson().toString()).catchError((error) => Observable.error(error.toString())));
    } catch(e) {
      return Observable.error("Incomplete user info");
    }
  }

  @override
  Observable<BaseResponse> uploadImage(String imageBase64) {
    String body = "{\"base64\": \"$imageBase64\"}";
    return Observable.fromFuture(api.post("img", body));
  }
}
