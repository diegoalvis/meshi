/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BaseBloc {
  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  ProfileBloc(UserRepository repository, SessionManager session) : super(repository, session);

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }

  void addImage(File image, int index) {
    progressSubject.add(true);
    Observable.fromFuture(image.readAsBytes())
        .map((imageBytes) => base64Encode(imageBytes))
        .flatMap((base64Image) => repository.uploadImage(base64Image, index).asStream())
        .handleError((error) => errorSubject.sink.add("Error trying to upload the image"))
        .doOnEach((data) => progressSubject.add(false))
        .listen((success) {
      if (success) {
        _userSubject.sink.add(session.user);
      } else {
        errorSubject.sink.add("Error trying to upload the image");
      }
    });
  }

  void deleteImage(String image, int index) {
    progressSubject.add(true);
    repository
        .deleteImage(image, index)
        .catchError((error) => errorSubject.sink.add("Error trying to delete the image"))
        .whenComplete(() => progressSubject.add(false))
        .then((success) {
      if (success) {
        _userSubject.sink.add(session.user);
      } else {
        errorSubject.sink.add("Error trying to delete the image");
      }
    });
  }

  void loadProfileInfo() {
    progressSubject.sink.add(true);
    repository
        .fetchUserData()
        .catchError((error) => errorSubject.sink.add(error.toString()))
        .whenComplete(() => progressSubject.sink.add(false))
        .then((data) {
      _userSubject.sink.add(session.user);
    });
  }
}
