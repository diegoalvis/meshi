/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/managers/session_manager.dart';

class ServiceController {
  static const BASE_URL = "https://meshi-app.herokuapp.com";
  static const API_URL = BASE_URL + "/api";
  static final ServiceController _serviceController = new ServiceController._internal();

  ServiceController._internal();

  static ServiceController get instance => _serviceController;

  Future<BaseResponse> get(String endpointName) {
    return http.get(API_URL + endpointName, headers: {
      'Authorization': 'Bearer ${SessionManager().authToken}',
      'Content-Type': 'application/json',
    }).then((response) => processRequest(response));
  }

  Future<BaseResponse> post(String endpointName, String body) {
    return http.post(API_URL + endpointName, body: body, headers: {
      'Authorization': 'Bearer ${SessionManager().authToken}',
      'Content-Type': 'application/json',
    }).then((response) => processRequest(response));
  }

  Future<BaseResponse> putMap(String endpointName, Map<String, dynamic> body) {
    return http.put(API_URL + endpointName, body: body, headers: {
      'Authorization': 'Bearer ${SessionManager().authToken}',
    }).then((response) => processRequest(response));
  }

  Future<BaseResponse> put(String endpointName, String body) {
    return http.put(API_URL + endpointName, body: body, headers: {
      'Authorization': 'Bearer ${SessionManager().authToken}',
    }).then((response) => processRequest(response));
  }


  Future<BaseResponse> delete(String endpointName) {
    return http.delete(API_URL + endpointName, headers: {
      'Authorization': 'Bearer ${SessionManager().authToken}',
    }).then((response) => processRequest(response));
  }



  // Process response from server
  BaseResponse processRequest(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return BaseResponse();//.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 403) {
      // TODO Logout user
      return BaseResponse();
    } else {
      // TODO Handle exceptions
      throw Exception('Error');
    }
  }
}
