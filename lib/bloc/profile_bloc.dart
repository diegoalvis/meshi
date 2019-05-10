/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:convert';
import 'dart:io';

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BaseBloc {

  UserRepository repository;

  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  User user;
  DateTime selectedDate = DateTime.now();

  ProfileBloc() {
    loadProfileInfo();
  }

  @override
  dispose() {
    super.dispose();
    _userSubject.close();
  }

  void addImage(File image, int index) {
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
          user.images[index] = response.data.toString();
          _userSubject.sink.add(user);
        }
      } else {
        errorSubject.sink.add("Error trying to upload image");
      }
    });
  }

  void deleteImage(String image, int index) {
    repository
        .deleteImage(image)
        .doOnError(() => errorSubject.sink.add("Error trying to delete the image"))
        .doOnEach((data) => progressSubject.add(false))
        .listen((response) {
      if (response.success) {
        if (response.data != null) {
          if (user.images == null) {
            user.images = new List<String>(USER_PICTURE_NUMBER);
          }
          user.images[index] = null;
          _userSubject.sink.add(user);
        }
      } else {
        errorSubject.sink.add("Error trying to delete the image");
      }
    });
  }

  void loadProfileInfo() {
    progressSubject.sink.add(true);
    repository
        .fetchUserData()
        .handleError((error) => errorSubject.sink.add(error.toString()))
        .doOnEach((data) => progressSubject.sink.add(false))
        .listen((data) {
      user = data;
      _userSubject.sink.add(this.user);
    });
  }
}
