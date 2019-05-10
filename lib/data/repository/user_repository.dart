/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/api/ServiceController.dart';
import 'package:meshi/data/api/user_api.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {

  SessionManager _session;
  UserApi _api;

  UserRepository(this._session, this._api);

  /// Fetches user data
  Observable<User> fetchUserData() {
    return Observable.just(User());
//    return Observable(api.get("/users/self").asStream().map((response) {
//      if (response.data['user'] == null) {
//        return User(state: response.data['state']);
//      }
//      return User.fromJson(response.data['user']);
//    }));
  }

  /// validates if the user already exists, if so, returns the user info,
  /// otherwise it creates a new record.
  Observable<bool> loginUser(String id) {
    return Observable(_api.loginUser(id)).map((response) {
      _session.authToken = response.data.token;
      _session.user = response.data.user;
      return response.success;
    });
  }

  /// Updates the user basic info
  Observable<BaseResponse> updateUserBasicInfo(User user) {
    return Observable.just(BaseResponse());
//    return Observable(api.put("/users/basic", user.toJson().toString()).catchError((error) {
//      return Observable.error(error.toString());
//    }).asStream());
  }

  /// Updates the user advanced info
  Observable<BaseResponse> updateUserAdvancedInfo(User user) {
    return Observable.just(BaseResponse());
//    return Observable(api.put("/users/advanced", user.toJson().toString()).catchError((error) {
//      return Observable.error(error.toString());
//    }).asStream());
  }

  /// Upload user image
  Observable<BaseResponse> uploadImage(String imageBase64) {
    return Observable.just(BaseResponse());
//    String body = "{\"base64\": \"$imageBase64\"}";
//    return Observable.fromFuture(api.post("/img", body));
  }

  /// Deletes user image
  Observable<BaseResponse> deleteImage(String imageName) {
    return Observable.just(BaseResponse());
//    return Observable.fromFuture(api.delete("/img" + imageName));
  }
}
