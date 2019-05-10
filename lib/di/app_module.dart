import 'dart:io';

import 'package:dependencies/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/api/user_api.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
//      ..bindSingleton(AppDatabase())
      ..bindSingleton(SessionManager())
      ..bindSingleton(Dio(BaseOptions(baseUrl: BaseApi.API_URL_DEV, receiveTimeout: 30000)))
      ..bindLazySingleton((injector, params) => UserApi(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => UserRepository(
            injector.get(),
            injector.get(),
          ));
  }
}
