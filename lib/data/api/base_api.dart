/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/api/exceptions/exceptions.dart';
import 'package:meshi/managers/session_manager.dart';

abstract class BaseApi {

  static const BASE_URL_DEV = "https://meshi-app.herokuapp.com";
  static const API_URL_DEV = "https://meshi-app.herokuapp.com/api";

  Future<BaseResponse<T>> processResponse<T>(Response response, ComputeCallback<Map<String, dynamic>, T> callback) async {
    if ((response.statusCode >= 200 && response.statusCode < 300) || response.statusCode == 304) {
      final body = response.data;
      bool success = body["success"] as bool;
      int error = body["error"] as int;

      T data;
      if (body["data"] != null) {
        data = await compute<Map<String, dynamic>, T>(callback, body["data"]);
      }
      return BaseResponse(success: success, data: data, error: error);
    } else if (response.statusCode == 403) {
      throw AuthorizationException(cause: "Unauthorized");
    } else if (response.statusCode == 404) {
      throw ServiceException(cause: "Not found");
    } else {
      throw ServiceException(cause: 'Error');
    }
  }

  BaseResponse<T> processBasicResponse<T>(Response response) {
    if ((response.statusCode >= 200 && response.statusCode < 300) || response.statusCode == 304) {
      final body = response.data;
      bool success = body["success"] as bool;
      int error = body["error"] as int;
      T data = body["data"] as T;
      return BaseResponse(success: success, data: data, error: error);
    } else if (response.statusCode == 403) {
      throw AuthorizationException(cause: "Unauthorized");
    } else if (response.statusCode == 404) {
      throw ServiceException(cause: "Not found");
    } else {
      throw ServiceException(cause: 'Error');
    }
  }
}
