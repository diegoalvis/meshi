/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';

import 'package:meshi/data/api/ServiceController.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/data/repository/UserRepository.dart';

class UserRepositoryImp extends UserRepository {
  final api = ServiceController.instance;

  @override
  Future<User> fetchUser() async {
    var response = await api.get("/user");

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      // Handle exceptions
      throw Exception('Failed to load post');
    }
  }
}
