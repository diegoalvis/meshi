/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/managers/session_manager.dart';

class ServiceController {
  static const BASE_URL = "https://meshi-app.herokuapp.com/api/";
  static final ServiceController _serviceController = new ServiceController._internal();

  ServiceController._internal();

  static ServiceController get instance => _serviceController;

  Future<BaseResponse> get(String endpointName) {
    return http.get(BASE_URL + endpointName).then((response) {
      if (response.statusCode == 200) {
        return response.body as BaseResponse;
      } else {
        // TODO Handle exceptions
        throw Exception('Error');
      }
    });
  }

  Future<BaseResponse> post(String endpointName, String body) {
    return http.post(BASE_URL + endpointName, body: body).then((response) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    });
  }

  Future<BaseResponse> put(String endpointName, String body) {
    return http.put(BASE_URL + endpointName,
        body: body,
        headers: {'Authorization': 'Bearer ${SessionManager.instance.authToken}'}).then((response) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    });
  }
}
