/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:meshi/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class ServiceController {
  static const BASE_URL = "exmple.com/";
  static final ServiceController _serviceController = new ServiceController._internal();

  ServiceController._internal();

  static ServiceController get instance => _serviceController;

  Future<http.Response> get(String endpointName) {
    return http.get(BASE_URL + endpointName);
  }

  Future<http.Response> post(String endpointName, String body) {
    return http.post(BASE_URL + endpointName, body: body);
  }
}
