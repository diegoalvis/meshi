/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user_model.dart';

class SessionManager {
  static final SessionManager _sessionManager = new SessionManager._internal();
  SessionManager._internal();
  static SessionManager get instance => _sessionManager;

  final user = User();
  String fbToken = "";
}
