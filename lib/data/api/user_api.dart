/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/api/ServiceController.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/api/dto/user_dto.dart';
import 'package:meshi/data/api/exceptions/exceptions.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class UserApi extends BaseApi {

  Dio dio;
  SessionManager session;

  UserApi(this.dio, this.session); //UserApi(dio, session) : super(dio, session);

  /// Fetches user data
  Observable<BaseResponse<UserDto>> fetchUserData() {
    return Observable.fromFuture(dio
        .get<Map<String, dynamic>>("/users/self",
            options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
    ).flatMap((response) => processResponse(response, parseLoginRes).asStream());
  }

  /// validates if the user already exists, if so, returns the user info,
  /// otherwise it creates a new record.
  Observable<BaseResponse<UserDto>> loginUser(String id) {
    return Observable.fromFuture(dio
        .post<Map<String, dynamic>>("/auth/login-facebook",
            data: "{\"id\": \"$id\"}",
            options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'})
    ).catchError((error) {
      print(error.toString());
    })).flatMap((response) => processResponse(response, parseLoginRes).asStream());
  }

//  /// Updates the user basic info
//  Observable<BaseResponse> updateUserBasicInfo(User user) {
//    return Observable(api.put("/users/basic", user.toJson().toString()).catchError((error) {
//      return Observable.error(error.toString());
//    }).asStream());
//  }
//
//  /// Updates the user advanced info
//  Observable<BaseResponse> updateUserAdvancedInfo(User user) {
//    return Observable(api.put("/users/advanced", user.toJson().toString()).catchError((error) {
//      return Observable.error(error.toString());
//    }).asStream());
//  }
//
//  /// Upload user image
//  Observable<BaseResponse> uploadImage(String imageBase64) {
//    String body = "{\"base64\": \"$imageBase64\"}";
//    return Observable.fromFuture(api.post("/img", body));
//  }
//
//  /// Deletes user image
//  Observable<BaseResponse> deleteImage(String imageName) {
//    return Observable.fromFuture(api.delete("/img" + imageName));
//  }

//  @override
//  Observable<User> fetchUserData() {
//    return Observable(api.get("/users/self").asStream().map((response) {
//      if (response.data['user'] == null) {
//        return User(state: response.data['state']);
//      }
//      return User.fromJson(response.data['user']);
//    }));
//  }
//
//  @override
//  Observable<User> loginUser(String id) {
//    return Observable(api.post("/auth/login-facebook", "{\"id\": \"$id\"}").asStream().map((response) {
//      SessionManager.instance.authToken = response.data['token'];
//      if (response.data['user'] == null) {
//        return User(state: response.data['state']);
//      }
//      response.data['user']['state'] = "new";
//      return User.fromJson(response.data['user']);
//    }));
//  }
//
//  @override
//  Observable<BaseResponse> updateUserBasicInfo(User user) {
//    return Observable(api.put("/users/basic", user.toJson().toString()).catchError((error) {
//      return Observable.error(error.toString());
//    }).asStream());
//  }
//
//  @override
//  Observable<BaseResponse> updateUserAdvancedInfo(User user) {
//    return Observable(api.put("/users/advanced", user.toJson().toString()).catchError((error) {
//      return Observable.error(error.toString());
//    }).asStream());
//  }
//
//  @override
//  Observable<BaseResponse> uploadImage(String imageBase64) {
//    String body = "{\"base64\": \"$imageBase64\"}";
//    return Observable.fromFuture(api.post("/img", body));
//  }
//
//  @override
//  Observable<BaseResponse> deleteImage(String imageName) {
//    return Observable.fromFuture(api.delete("/img" + imageName));
//  }
}

UserDto parseLoginRes(Map<String, dynamic> map) => UserDto.fromJson(map);
