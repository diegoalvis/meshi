/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;
import 'package:meshi/blocs/base_bloc.dart';
import 'package:meshi/data/api/BaseResponse.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/data/repository/UserRepository.dart';
import 'package:meshi/data/repository/UserRepositoryImp.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/gender.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BaseBloc {
  static const IMAGE_BASE_URL = "https://meshi-app.herokuapp.com/images/";
  final UserRepository repository = UserRepositoryImp();
  final User user = SessionManager.instance.user;

  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  DateTime selectedDate = DateTime.now();

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }

  set name(String name) {
    user.name = name;
    progressSubject.sink.add(false);
  }

  set email(String email) {
    user.email = email;
    progressSubject.sink.add(false);
  }

  set birthDate(DateTime birthday) {
    user.birthDate = birthday;
    _userSubject.sink.add(user);
    progressSubject.sink.add(false);
  }

  set userGender(Gender gender) {
    user.gender = gender;
    _userSubject.sink.add(user);
    progressSubject.sink.add(false);
  }

  void addImage(File image, int index) {
    progressSubject.add(true);
    Observable.fromFuture(image.readAsBytes())
        .map((imageBytes) => base64Encode(imageBytes))
        .flatMap((base64Image) => repository.uploadImage(base64Image))
        .doOnError(() => errorSubject.sink.add("Error trying to upload image"))
        .doOnDone(() => progressSubject.add(false))
        .listen((response) {
      if (response.success) {
        if (response.data != null) {
          if (user.images == null) {
            user.images = new List<String>(USER_PICTURE_NUMBER);
          }
          user.images[index] = IMAGE_BASE_URL + response.data.toString();
          _userSubject.sink.add(user);
        }
      } else {
        errorSubject.sink.add("Error trying to upload image");
      }
    });
  }

  removeGender(Gender gender) {
    user.likeGender.remove(gender);
    _userSubject.sink.add(user);
    progressSubject.sink.add(false);
  }

  addGender(Gender gender) {
    if (user.likeGender == null) {
      user.likeGender = Set();
    }
    user.likeGender.add(gender);
    _userSubject.sink.add(user);
    progressSubject.sink.add(false);
  }

  void loadFacebookProfile() async {
    progressSubject.sink.add(true);
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200),age_range,birthday&access_token=${SessionManager.instance.fbToken}');

    var profile = json.decode(graphResponse.body);
    try {
      user.name = profile['name'];
      user.email = profile['email'];
      List<int> date = profile['birthday'].toString().split('/').map((s) => int.tryParse(s)).toList();
      user.birthDate = DateTime(date[2], date[0], date[1]);
    } catch (e) {
      print(e.toString());
    }
    _userSubject.sink.add(user);
    progressSubject.sink.add(false);
  }

  Observable<BaseResponse> updateUseInfo() {
    progressSubject.sink.add(true);
    return repository.updateUserBasicInfo(user).handleError((error) {
      errorSubject.sink.add(error.toString());
    }).doOnEach((data) => progressSubject.sink.add(false));
  }
}
