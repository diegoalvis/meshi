/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

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

  set description(String description) {
    user.description = description;
    _userSubject.sink.add(user);
  }

  set freeTime(String freeTime) {
    user.freeTime = freeTime;
    _userSubject.sink.add(user);
  }

  set occupation(String occupation) {
    user.occupation = occupation;
    _userSubject.sink.add(user);
  }

  set interests(String interests) {
    user.interests = interests;
    _userSubject.sink.add(user);
  }

  set email(String email) {
    user.email = email;
    _userSubject.sink.add(user);
  }

  set birthDate(DateTime birthday) {
    user.birthDate = birthday;
    _userSubject.sink.add(user);
  }

  set userGender(Gender gender) {
    user.gender = gender;
    _userSubject.sink.add(user);
  }

  addImage(File image, int index) {
    if (user.pictures == null) {
      user.pictures = new List<String>(USER_PICTURE_NUMBER);
    }
    // TODO hacer api call to save iamge and set value trhought bloc using a stream builder widget
//    user.pictures[index] = image;
    _userSubject.sink.add(user);
  }

  removeGender(Gender gender) {
    user.likeGender.remove(gender);
    _userSubject.sink.add(user);
  }

  addGender(Gender gender) {
    user.likeGender.add(gender);
    _userSubject.sink.add(user);
  }

  void loadFacebookProfile() async {
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
  }

  Observable<BaseResponse> updateUseInfo() {
    progressSubject.sink.add(true);
    return Observable.fromFuture(repository.updateUserBasicInfo(user))
        .doOnDone(() => progressSubject.sink.add(false));
  }
}
