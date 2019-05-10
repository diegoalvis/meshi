/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BaseBloc {

  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  UserRepository repository;
  SessionManager session;

  DateTime selectedDate = DateTime.now();

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }

  set name(String name) {
    session.user.name = name;
    progressSubject.sink.add(false);
  }

  set email(String email) {
    session.user.email = email;
    progressSubject.sink.add(false);
  }

  set birthDate(DateTime birthday) {
    session.user.birthdate = birthday;
    _userSubject.sink.add(session.user);
    progressSubject.sink.add(false);
  }

  set userGender(String gender) {
    session.user.gender = gender;
    _userSubject.sink.add(session.user);
    progressSubject.sink.add(false);
  }

  void addImage(File image, int index) {
    progressSubject.add(true);
    Observable.fromFuture(image.readAsBytes())
        .map((imageBytes) => base64Encode(imageBytes))
        .flatMap((base64Image) => repository.uploadImage(base64Image))
        .doOnError(() => errorSubject.sink.add("Error trying to upload the image"))
        .doOnEach((data) => progressSubject.add(false))
        .listen((response) {
      if (response.success) {
        if (response.data != null) {
          if (session.user.images == null) {
            session.user.images = new List<String>(USER_PICTURE_NUMBER);
          }
          session.user.images[index] = response.data.toString();
          _userSubject.sink.add(session.user);
        }
      } else {
        errorSubject.sink.add("Error trying to upload the image");
      }
    });
  }

  void deleteImage(String image, int index) {
    progressSubject.add(true);
    repository
        .deleteImage(image)
        .doOnError(() => errorSubject.sink.add("Error trying to delete the image"))
        .doOnEach((data) => progressSubject.add(false))
        .listen((response) {
      if (response.success) {
        if (response.data != null) {
          if (session.user.images == null) {
            session.user.images = new List<String>(USER_PICTURE_NUMBER);
          }
          session.user.images[index] = null;
          _userSubject.sink.add(session.user);
        }
      } else {
        errorSubject.sink.add("Error trying to delete the image");
      }
    });
  }

  void removeGender(String gender) {
    session.user.likeGender.remove(gender);
    _userSubject.sink.add(session.user);
    progressSubject.sink.add(false);
  }

  void addGender(String gender) {
    if (session.user.likeGender == null) {
      session.user.likeGender = Set();
    }
    session.user.likeGender.add(gender);
    _userSubject.sink.add(session.user);
    progressSubject.sink.add(false);
  }

  void loadFacebookProfile() async {
    progressSubject.sink.add(true);
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200),age_range,birthday&access_token=${session.fbToken}');

    var profile = json.decode(graphResponse.body);
    try {
      session.user.name = session.user.name ?? profile['name'];
      session.user.email = session.user.email ?? profile['email'];
      List<int> date = profile['birthday'].toString().split('/').map((s) => int.tryParse(s)).toList();
      session.user.birthdate = session.user.birthdate ?? DateTime(date[2], date[0], date[1]);
    } catch (e) {
      print(e.toString());
    }
    _userSubject.sink.add(session.user);
    progressSubject.sink.add(false);
  }

  Observable<BaseResponse> updateUseInfo() {
    progressSubject.sink.add(true);
    return repository.updateUserBasicInfo(session.user).handleError((error) {
      errorSubject.sink.add(error.toString());
    }).doOnEach((data) => progressSubject.sink.add(false));
  }
}