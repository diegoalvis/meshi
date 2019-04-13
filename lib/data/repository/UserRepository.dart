/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user_model.dart';

abstract class UserRepository {
  /// Fetches user data
  Future<User> fetchUser();
}
