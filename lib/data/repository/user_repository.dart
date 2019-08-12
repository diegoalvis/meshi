/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dio/dio.dart';
import 'package:meshi/data/api/user_api.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/models/user_preferences.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  SessionManager _session;
  UserApi _api;

  UserRepository(this._session, this._api);

  /// Fetch user data
  Future<bool> fetchUserData() {
    return _api.fetchUserData().then((response) {
      _session.saveUser(response.data.user);
      return response.success;
    });
  }

  /// validates if the user already exists, if so, returns the user info,
  /// otherwise it creates a new record.
  Future<bool> loginUser(String id) async {
    return _api.loginUser(id).then((response) {
      _session.setAuhToken(response.data.token);
      _session.saveUser(response.data.user);
      _session.setLogged(true);
      return response.success;
    }).then((success) {
      return activeAccount();
    }).catchError((error) {
      return Observable.error(error.toString());
    });
  }

  /// Updates the user basic info
  Observable<bool> updateUserBasicInfo(User user) {
    return Observable.fromFuture(_api.updateUserBasicInfo(user)).map((response) {
      if (response?.success == true) {
        if (user.state != User.ADVANCED_USER) user.state = User.BASIC_USER;
        _session.saveUser(user);
      }
      return response?.success ?? false;
    }).handleError((error) {
      return Observable.error(error.toString());
    });
  }

  /// Updates the user advanced info
  Observable<bool> updateUserAdvancedInfo(User user) {
    return Observable.fromFuture(_api.updateUserAdvancedInfo(user)).map((response) {
      if (response?.success == true) {
        user.state = User.ADVANCED_USER;
        _session.saveUser(user);
      }
      return response?.success ?? false;
    }).handleError((error) {
      return Observable.error(error.toString());
    });
  }

  /// Upload user image
  Future<bool> uploadImage(String imageBase64, int index) async {
    final user = _session.user;
    return _api.uploadImage(imageBase64).then((response) {
      if (response.success && response.data != null) {
        if (user.images == null) {
          user.images = new List<String>(USER_PICTURE_NUMBER);
        }
        user.images[index] = response.data.toString();
        _session.saveUser(user);
      }
      return response.success;
    });
  }

  /// Deletes user image
  Future<bool> deleteImage(String imageName, int index) async {
    final user = _session.user;
    return _api.deleteImage(imageName).then((response) {
      if (response.success && response.data != null) {
        user.images[index] = null;
        _session.saveUser(user);
      }
      return response.success;
    }).catchError((error) {
      if ((error as DioError).response.statusCode == 404) {
        user.images[index] = null;
        _session.saveUser(user);
        return true;
      }
      return Observable.error(error.toString());
    });
  }

  Future<int> deactivateAccount() async {
    final res = await _api.changeActive(false);
    return res.data;
  }

  Future<bool> activeAccount() async {
    final res = await _api.changeActive(true);
    return res.success;
  }

  Future<int> updateFirebaseToken({String token}) async {
    String tk = token;

    if (token != null) {
      _session.setFirebaseToken(token);
    } else {
      tk = await _session.firebaseToken;
    }

    final logged = await _session.logged;
    if (!logged) {
      return -1;
    }

    final rspn = await _api.changeFirebaseToken(tk);
    return rspn.data;
  }

  Future<UserPreferences> fetchUserPreferences() async {
    final res = await _api.fetchPreferences();
    if (res.data != null) {
      _session.saveUserPreferences(res.data);
    }
    return res.data;
  }

  Future<UserPreferences> fetchLocalUserPreferences() async {
    return _session.getUserPreferences();
  }

  Future<int> updateUserPreferences(UserPreferences preferences) async {
    _session.saveUserPreferences(preferences);
    final res = await _api.updatePreferences(preferences);
    return res.data;
  }
}
