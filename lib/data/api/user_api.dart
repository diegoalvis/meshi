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

UserDto parseUser(Map<String, dynamic> map) => UserDto.fromJson(map);

class UserApi extends BaseApi {
  Dio dio;
  SessionManager session;

  UserApi(this.dio, this.session);

  /// Fetches user data
  Future<BaseResponse<UserDto>> fetchUserData() {
    return dio
        .get<Map<String, dynamic>>("/users/self",
            options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
        .then((response) => processResponse(response, parseUser));
  }

  /// validates if the user already exists, if so, returns the user info,
  /// otherwise it creates a new record.
  Future<BaseResponse<UserDto>> loginUser(String id) {
    return dio
        .post<Map<String, dynamic>>("/auth/login-facebook",
            data: "{\"id\": \"$id\"}",
            options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
        .then((response) => processResponse(response, parseUser));
  }

  /// Updates the user basic info
  Future<BaseResponse> updateUserBasicInfo(User user) {
    return dio
        .put<Map<String, dynamic>>("/users/basic",
            data: user.toJson(), options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
        .then((response) {
      return processBasicResponse(response);
    });
  }

  /// Updates the user advanced info
  Future<BaseResponse<UserDto>> updateUserAdvancedInfo(User user) {
    return dio
        .put<Map<String, dynamic>>("/users/advanced",
            data: user.toJson(), options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
        .then((response) => processResponse(response, parseUser))
    .catchError((er) {
      print(er);
    });
  }

  /// Upload user image
  Future<BaseResponse<String>> uploadImage(String imageBase64) {
    return dio
        .post<Map<String, dynamic>>("/img",
            data: "{\"base64\": \"$imageBase64\"}",
            options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
        .then((response) => processBasicResponse(response));
  }

  /// Deletes user image
  Future<BaseResponse> deleteImage(String imageName) {
    return dio
        .delete("/img" + imageName, options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer ${session.authToken}'}))
        .then((response) => processBasicResponse(response));
  }

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
