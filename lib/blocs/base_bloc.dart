/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final errorSubject = PublishSubject<String>();
  final successSubject = PublishSubject<String>();
  final progressSubject = PublishSubject<bool>();

  void dispose() {
    errorSubject.close();
    successSubject.close();
    progressSubject.close();
  }
}
