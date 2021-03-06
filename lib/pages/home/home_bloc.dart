/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';


class HomeBloc extends BaseBloc {
  final _categorySelectedSubject = PublishSubject<String>();
  final _userSubject = PublishSubject<User>();

  Stream<User> get userStream => _userSubject.stream;
  Stream<String> get categorySelectedStream => _categorySelectedSubject.stream;

  final UserRepository _repository;

  HomeBloc(this._repository, SessionManager session): super(session: session);

  set category(String category) {
    _categorySelectedSubject.sink.add(category);
  }

  Future<void> close() async {
    super.close();
    _categorySelectedSubject.close();
    _userSubject.close();
  }

  void updateToken(String token) async{
    await _repository.updateFirebaseToken(token:token);
  }
}
