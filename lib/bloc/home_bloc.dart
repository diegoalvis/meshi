/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final _categorySelectedSubject = PublishSubject<String>();
  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;

  Stream<String> get categorySelectedStream => _categorySelectedSubject.stream;

  final UserRepository _repository;

  HomeBloc(this._repository);


  set category(String category) {
    _categorySelectedSubject.sink.add(category);
  }

  void dispose() {
    super.dispose();
    _categorySelectedSubject.close();
    _userSubject.close();
  }

  void updateToken(String token) async{
    await _repository.updateFirebaseToken(token);
  }
}
