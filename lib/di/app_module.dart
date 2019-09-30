import 'package:dependencies/dependencies.dart';
import 'package:dio/dio.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/api/chat_api.dart';
import 'package:meshi/data/api/match_api.dart';
import 'package:meshi/data/api/reward_api.dart';
import 'package:meshi/data/api/user_api.dart';
import 'package:meshi/data/db/app_database.dart';
import 'package:meshi/data/db/dao/match_dao.dart';
import 'package:meshi/data/db/dao/message_dao.dart';
import 'package:meshi/data/db/dao/recomendation_dao.dart';
import 'package:meshi/data/repository/chat_repository.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/data/sockets/chat_socket.dart';
import 'package:meshi/data/sockets/user_socket.dart';
import 'package:meshi/managers/location_manager.dart';
import 'package:meshi/managers/notification_manager.dart';
import 'package:meshi/managers/session_manager.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(Dio(BaseOptions(baseUrl: BaseApi.API_URL_DEV, receiveTimeout: 15000)))
      ..bindLazySingleton((injector, params) => SessionManager(injector.get()))
      ..bindLazySingleton((injector, params) => NotificationManager(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => LocationManager())
      // Data base
      ..bindLazySingleton((injector, params) => AppDatabase())
      // DAO
      ..bindFactory((injector, params) => MessageDao(injector.get()))
      ..bindFactory((injector, params) => MatchDao(injector.get()))
      ..bindFactory((injector, params) => RecomendationDao(injector.get()))
      // API
      ..bindFactory((injector, params) => UserApi(injector.get(), injector.get()))
      ..bindFactory((injector, params) => RewardApi(injector.get(), injector.get()))
      ..bindFactory((injector, params) => MatchApi(injector.get(), injector.get()))
      ..bindFactory((injector, params) => ChatApi(injector.get(), injector.get()))
      ..bindLazySingleton((injector, params) => ChatSocket())
      ..bindLazySingleton((injector, params) => UserSocket())
      // REPOSITORY
      ..bindFactory((injector, params) => MatchRepository(injector.get(), injector.get(), injector.get(), injector.get()))
      ..bindFactory((injector, params) => UserRepository(injector.get(), injector.get()))
      ..bindFactory((injector, params) => RewardRepository(injector.get(), injector.get()))
      ..bindFactory((injector, params) => ChatRepository(injector.get(), injector.get(), injector.get()));
    // Notifications
  }
}
