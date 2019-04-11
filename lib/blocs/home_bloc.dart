/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _categorySelectedSubject = PublishSubject<String>();

  Observable<String> get categorySelectedStream => _categorySelectedSubject.stream;

  set category(String category) {
    _categorySelectedSubject.sink.add(category);
  }

  void dispose() {
    _categorySelectedSubject.close();
  }
}
