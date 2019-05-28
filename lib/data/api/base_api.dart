/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meshi/data/api/exceptions/exceptions.dart';
import 'package:meshi/managers/session_manager.dart';

class BaseApi {
  static const BASE_URL_DEV = "https://meshi-app.herokuapp.com";
  static const API_URL_DEV = "https://meshi-app.herokuapp.com/api";

  Dio _dio;
  SessionManager session;

  BaseApi(this._dio, this.session);

  Future<Response<Map<String, dynamic>>> get(String path, {Map<String, dynamic> query}) async {
    final auth = await _mkAuth(session);
    return await _dio.get<Map<String, dynamic>>(path, queryParameters: query, options: auth).catchError((error) {
      print(error);
    });
  }

  Future<Response<Map<String, dynamic>>> post(String path, {Map<String, dynamic> body}) async {
    final auth = await _mkAuth(session);
    return await _dio.post<Map<String, dynamic>>(path, data: body, options: auth).catchError((error) {
      print(error);
    });
  }

  Future<Response<Map<String, dynamic>>> put(String path, {Map<String, dynamic> body}) async {
    final auth = await _mkAuth(session);
    return await _dio.put<Map<String, dynamic>>(path, data: body, options: auth);
  }

  Future<Response<Map<String, dynamic>>> delete(String path) async {
    final auth = await _mkAuth(session);
    return await _dio.delete<Map<String, dynamic>>(path, options: auth);
  }

  Future<Options> _mkAuth(SessionManager session) async {
    final token = await session.authToken;
    return Options(headers: {HttpHeaders.authorizationHeader: token});
  }


  //process responses
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

  Future<BaseResponse<T>> processListResponse<T>(
      Response response, ComputeCallback<List<Map<String, dynamic>>, T> callback) async {
    if ((response.statusCode >= 200 && response.statusCode < 300) || response.statusCode == 304) {
      final body = response.data;
      bool success = body["success"] as bool;
      int error = body["error"] as int;

      T data;
      if (body["data"] != null) {
        data = await compute<List<Map<String, dynamic>>, T>(callback, (body["data"] as List).cast<Map<String, dynamic>>());
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
}

class BaseResponse<T> {
  bool success;
  T data;
  int error;

  BaseResponse({this.success, this.data, this.error});
}
