/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {

  final _categorySelectedSubject = PublishSubject<String>();
  final _userSubject = PublishSubject<User>();

  HomeBloc(UserRepository repository, SessionManager session) : super(repository, session);

  Stream<User> get userStream => _userSubject.stream;
  Observable<String> get categorySelectedStream => _categorySelectedSubject.stream;

  set category(String category) {
    _categorySelectedSubject.sink.add(category);
  }

  void dispose() {
    _categorySelectedSubject.close();
    _userSubject.close();
  }
}
