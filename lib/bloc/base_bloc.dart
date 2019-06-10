/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:bloc/bloc.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class BaseBloc<E, S> extends Bloc<E, S> {
  static const int ACTION_POP_PAGE = 1;
  static const int ACTION_REPLACE_PAGE = 2;

  // Inject
  SessionManager session;

  BaseBloc({this.session});

  final errorSubject = PublishSubject<String>();
  final successSubject = PublishSubject<String>();
  final progressSubject = PublishSubject<bool>();

  void dispose() {
    super.dispose();
    errorSubject.close();
    successSubject.close();
    progressSubject.close();
  }

  @override
  S get initialState => null;

  @override
  Stream<S> mapEventToState(E event) {
    return null;
  }


}
