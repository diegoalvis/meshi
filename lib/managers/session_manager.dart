/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user_model.dart';

class SessionManager {
  static final SessionManager _sessionManager = new SessionManager._internal();
  SessionManager._internal();
  static SessionManager get instance => _sessionManager;

  //User user;
  //String fbUserId;
  //String fbToken;
  //String authToken;

  User user = User();
  String fbUserId = "10219787681781369";
  String fbToken = "";
  String authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQsInJvbGUiOiJVc2VyIiwiaWF0IjoxNTU1ODgxOTI0fQ.KMEYTO6lnaSQVeoFOUWQ8C9hsiJ46ax_i6KfXAXVpbM";
}
