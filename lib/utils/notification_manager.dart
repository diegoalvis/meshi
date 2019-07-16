import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

const String NOTIFICATION_REWARD = "notification_reward";
const String NOTIFICATION_CHAT = "notification_chat";
const String NOTIFICATION_MATCH = "notification_match";
const String NOTIFICATION_INTEREST = "notification_interest";
const String NOTIFICATION_WINNER = "notification_winner";

class NotificationManager {
  final UserRepository _repository;
  final messageNotificationSubject = PublishSubject<UserMatch>();
  final onChangePageSubject = PublishSubject<int>();
  final SessionManager sessionManager;

  GlobalKey<NavigatorState> _navigatorKey;

  NotificationManager(this._repository, this.sessionManager);

  void dispose() {
    messageNotificationSubject.close();
    onChangePageSubject.close();
  }

  Future showNotification(int id, String title, String body, dynamic message,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final data = jsonEncode(message);
    final android = AndroidNotificationDetails("channel_id", "channel_name", "channel_description",
        priority: Priority.High, importance: Importance.Max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform, payload: data);
  }

  void setNotificationsConfig(GlobalKey<NavigatorState> globalNavigatorKey) {
    _navigatorKey = globalNavigatorKey;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings("drawable/ic_logo");
    var iOS = IOSInitializationSettings();
    var platform = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(platform, onSelectNotification: (payload) => onSelectedNotification(payload));
    fcmListener(flutterLocalNotificationsPlugin);
  }

  void fcmListener(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    FirebaseMessaging _fcm = FirebaseMessaging();
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
      _fcm.onIosSettingsRegistered.listen((settings) {
        print("Settings registered: $settings");
      });
    }
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      final match = UserMatch.fromMessage(message);
      messageNotificationSubject.sink.add(match);
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          if(sessionManager.currentChatId != message["data"]["idMatch"]){
            showNotification(0, match.name, match.lastMessage, message, flutterLocalNotificationsPlugin);
          }else{
            print(message);
          }
          //showNotification(0, match.name, match.lastMessage, match, flutterLocalNotificationsPlugin);
          break;
        case NOTIFICATION_REWARD:
          showNotification(1, "Nueva Cita de Regalo", "Participa por una cita de", message, flutterLocalNotificationsPlugin);
          break;
        case NOTIFICATION_WINNER:
          showNotification(
              2, 'Ganaste una cita!', "Eres el ganador de una fabulosa cita", message, flutterLocalNotificationsPlugin);
          break;
      }
    }, onResume: (Map<String, dynamic> message) async {
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          final match = UserMatch.fromMessage(message);
          _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match);
          break;
        case NOTIFICATION_REWARD:
        case NOTIFICATION_WINNER:
          onChangePageSubject.add(2);
          break;
        default:
          _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
          break;
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      print("on launch");
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          final match = UserMatch.fromMessage(message);
          _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
          Future.delayed(
              Duration(milliseconds: 200), () => _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match));
          break;
        case NOTIFICATION_REWARD:
        case NOTIFICATION_WINNER:
          onChangePageSubject.add(2);
          break;
        default:
          _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
          break;
      }
    });

    _fcm.getToken().then((token) {
      print('TOKEEEEEN $token');
      _repository.updateFirebaseToken(token);
    });
  }

  Future onSelectedNotification(String payload) async {
    dynamic message = jsonDecode(payload);
    switch (message["data"]["typeMessage"]) {
      case NOTIFICATION_CHAT:
        final match = UserMatch.fromMessage(message);
        _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match);
        break;
      case NOTIFICATION_REWARD:
      case NOTIFICATION_WINNER:
        onChangePageSubject.add(2);
        break;
      default:
        _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
        break;
    }
  }
}
