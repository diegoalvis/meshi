/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class BaseBloc {

  static const int POP_PAGE = 1;
  static const int REPLACE_PAGE = 2;

  // Inject
  SessionManager session;

  BaseBloc(this.session);

  final errorSubject = PublishSubject<String>();
  final successSubject = PublishSubject<String>();
  final progressSubject = PublishSubject<bool>();

  void dispose() {
    errorSubject.close();
    successSubject.close();
    progressSubject.close();
  }
}
