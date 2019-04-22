/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserRepository {
  /// validates if the user already exists, if so, returns the user info,
  /// otherwise it creates a new record.
  Future<User> loginUser(String id);

  /// Fetches user data
  Future<User> fetchUser();

  /// Updates the user basic info
  Observable<BaseResponse> updateUserBasicInfo(User user);

  Observable<BaseResponse> uploadImage(String imageBase64);
}
