import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

const String NOTIFICATION_REWARD = "notification_reward";
const String NOTIFICATION_CHAT = "notification_chat";
const String NOTIFICATION_MATCH = "notification_match";
const String NOTIFICATION_INTEREST = "notification_interest";
const String NOTIFICATION_WINNER = "notification_winner";
const String NOTIFICATION_PAYMENT = "notification_payment";

const String TOPIC_REWARD = "topic_reward";

class NotificationManager {
  final UserRepository _repository;
  final messageNotificationSubject = PublishSubject<UserMatch>();
  final onChangePageSubject = PublishSubject<int>();
  final FirebaseMessaging _fcm = FirebaseMessaging();

  SessionManager sessionManager;

  GlobalKey<NavigatorState> _navigatorKey;

  NotificationManager(this._repository, this.sessionManager);

  set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  void subscribeToTopics() {
    sessionManager.getUserPreferences().then((pref) {
      if (pref.reward) _fcm.subscribeToTopic(TOPIC_REWARD);
    });
  }

  void subscribeToTopic(String topic) {
    _fcm.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    _fcm.unsubscribeFromTopic(topic);
  }

  Future deleteInstance() async {
    await _fcm.deleteInstanceID();
  }

  void setFcmListener() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
      _fcm.onIosSettingsRegistered.listen((settings) => print("Settings registered: $settings"));
    }

    _fcm.getToken().then((token) => _repository.updateFirebaseToken(token: token));
    _fcm.onTokenRefresh.listen((token) => _repository.updateFirebaseToken(token: token));

    _fcm.setAutoInitEnabled(true);
    _fcm.configure(
      onMessage: (Map<String, dynamic> msg) async {
        print("alvis --  ON MESSAGE");
        Map<String, dynamic> notification = msg["notification"].cast<String, dynamic>();
        Map<String, dynamic> data = Platform.isAndroid ? msg["data"].cast<String, dynamic>() : msg;
        switch (data["typeMessage"]) {
          case NOTIFICATION_CHAT:
            final match = UserMatch.fromMessage(data);
            messageNotificationSubject.sink.add(match);
            final idCurrentMatch = await sessionManager.currentChatId;
            if (idCurrentMatch != match?.idMatch) {
              showNotificationDialog(
                  NOTIFICATION_CHAT, onChangePageSubject, 2, "${match?.name}", "${match?.lastMessage}", _navigatorKey,
                  match: match);
            }
            break;
          case NOTIFICATION_REWARD:
            showNotificationDialog(
                NOTIFICATION_REWARD, onChangePageSubject, 2, '', '${notification["body"]}', _navigatorKey);
            break;
          case NOTIFICATION_WINNER:
            showNotificationDialog(NOTIFICATION_WINNER, onChangePageSubject, 2, 'Ganaste una cita!',
                "Eres el ganador de una fabulosa cita", _navigatorKey);
            break;
          case NOTIFICATION_INTEREST:
            final match = UserMatch.fromMessage(data);
            showNotificationDialog(NOTIFICATION_INTEREST, onChangePageSubject, 1, 'Le interesas a alguien!',
                "Le interesas a ${match.name}", _navigatorKey,
                match: match);
            break;
          case NOTIFICATION_MATCH:
            final match = UserMatch.fromMessage(data);
            showNotificationDialog(
                NOTIFICATION_MATCH, onChangePageSubject, 1, 'Nuevo match', "${match.name} es tu nuevo match", _navigatorKey,
                match: match);
            break;
          case NOTIFICATION_PAYMENT:
            showNotificationDialog(NOTIFICATION_PAYMENT, onChangePageSubject, 0, 'Meshi Premium',
                "Realiza el pago a timepo para seguir disfrutando de las funcionalidades premium", _navigatorKey);
            break;
        }
      },
      onResume: (Map<String, dynamic> msg) async {
        print("alvis --  ON RESUME");
        handleBackgroundNotification(msg);
      },
      onLaunch: (Map<String, dynamic> msg) async {
        print("alvis --  ON LUNCH");
        Future.delayed(Duration(milliseconds: 2000), () {
          handleBackgroundNotification(msg);
        });
      },
    );
  }

  void handleBackgroundNotification(Map<String, dynamic> msg) {
    Map<String, dynamic> data = Platform.isAndroid ? msg["data"].cast<String, dynamic>() : msg;
    data.keys.forEach((a) => print(a));
    switch (data["typeMessage"]) {
      case NOTIFICATION_CHAT:
        final match = UserMatch.fromMessage(data);
        _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match);
        break;
      case NOTIFICATION_REWARD:
      case NOTIFICATION_WINNER:
        onChangePageSubject.add(2);
        break;
      case NOTIFICATION_INTEREST:
      case NOTIFICATION_MATCH:
        onChangePageSubject.add(1);
        break;
      case NOTIFICATION_PAYMENT:
        break;
    }
  }
}

void showNotificationDialog(String notificationType, PublishSubject<int> onPageChange, int pos, String title,
    String description, GlobalKey<NavigatorState> _navigatorKey,
    {UserMatch match}) {
  showSimpleNotification(
      GestureDetector(
          onTap: () => notificationAction(notificationType, onPageChange, pos, _navigatorKey, match: match),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: <Widget>[
                    Icon(AppIcons.logo, color: Color(0xFF80065E), size: 15),
                    SizedBox(width: 8),
                    Text("meshi", style: TextStyle(color: Colors.black))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(description,
                        maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black))),
              )
            ],
          )),
      background: Colors.white);
}

void notificationAction(
    String notificationType, PublishSubject<int> onChangePage, int pos, GlobalKey<NavigatorState> _navigatorKey,
    {UserMatch match}) {
  switch (notificationType) {
    case NOTIFICATION_CHAT:
      _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match);
      break;
    case NOTIFICATION_PAYMENT:
    case NOTIFICATION_REWARD:
    case NOTIFICATION_WINNER:
    case NOTIFICATION_MATCH:
    case NOTIFICATION_INTEREST:
      onChangePage.add(pos);
      break;
  }
}
