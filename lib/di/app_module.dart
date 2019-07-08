import 'package:dependencies/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/api/chat_api.dart';
import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/api/reward_api.dart';
import 'package:meshi/data/api/user_api.dart';
import 'package:meshi/data/db/app_database.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/db/dao/message_dao.dart';
import 'package:meshi/data/repository/chat_repository.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/data/sockets/ChatSocket.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/notification_utils.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
//      ..bindSingleton(FirebaseMessaging())
      ..bindSingleton(NotificationManager())
      ..bindSingleton(SessionManager())
      ..bindSingleton(Dio(BaseOptions(baseUrl: BaseApi.API_URL_DEV, receiveTimeout: 15000)))
      //DAO
      ..bindLazySingleton((injector, params) => AppDatabase())
      ..bindLazySingleton((injector, params) => MessageDao(injector.get()))
      ..bindLazySingleton((injector, params) => MatchDao(injector.get()))
      // API
      ..bindLazySingleton((injector, params) => UserApi(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => RewardApi(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => MatchApi(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => ChatApi(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => ChatSocket())
      // REPOSITORY
      ..bindLazySingleton((injector, params) => UserRepository(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => MatchRepository(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => RewardRepository(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => ChatRepository(injector.get(), injector.get(), injector.get()));
  }
}
