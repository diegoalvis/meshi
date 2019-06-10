/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/api/dto/user_dto.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/managers/session_manager.dart';

UserDto parseUser(Map<String, dynamic> map) => UserDto.fromJson(map);

class UserApi extends BaseApi {
  UserApi(Dio dio, SessionManager session) : super(dio, session);

  Future<BaseResponse<UserDto>> fetchUserData() {
    return get("/users/self").then((response) => processResponse(response, parseUser));
  }

  Future<BaseResponse<UserDto>> loginUser(String id) {
    return post("/auth/login-facebook", body: {"id": id}).then((response) => processResponse(response, parseUser));
  }

  Future<BaseResponse> updateUserBasicInfo(User user) {
    return put("/users/basic", body: user.toJson()).then((response) {
      return processBasicResponse(response);
    });
  }

  Future<BaseResponse> updateUserAdvancedInfo(User user) {
    return put("/users/advanced", body: user.toJson()).then((response) => processBasicResponse(response)).catchError((er) {
      print(er);
    });
  }

  Future<BaseResponse<String>> uploadImage(String imageBase64) {
    return post("/img", body: {"base64": imageBase64}).then((response) => processBasicResponse(response));
  }

  Future<BaseResponse> deleteImage(String imageName) {
    return delete("/img" + imageName).then((response) => processBasicResponse(response));
  }
}
