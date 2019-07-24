import 'dart:io';

import 'package:dependencies_flutter/dependencies_flutter.dart';
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

class NotificationManager {
  final UserRepository _repository;
  final messageNotificationSubject = PublishSubject<UserMatch>();
  final onChangePageSubject = PublishSubject<int>();
  SessionManager sessionManager;

  GlobalKey<NavigatorState> _navigatorKey;

  NotificationManager(this._repository, this.sessionManager);

  void dispose() {
    messageNotificationSubject.close();
    onChangePageSubject.close();
  }

  set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  void fcmListener(BuildContext context) async {
    FirebaseMessaging _fcm = FirebaseMessaging();
    final messageNotification = await sessionManager.getSettingsNotification("messageNotification");
    final interestNotification = await sessionManager.getSettingsNotification("interestNotification");
    final rewardNotification = await sessionManager.getSettingsNotification("rewardNotification");
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
          final idCurrentMatch = await sessionManager.currentChatId;
          if (idCurrentMatch != match.idMatch && messageNotification) {
            showSimpleNotification(
                GestureDetector(
                    onTap: () {
                      _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match);
                    },
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
                              child:
                                  Text(match.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(match.lastMessage,
                                  maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black))),
                        )
                      ],
                    )),
                background: Colors.white);
          } else {
            print(message);
          }
          break;
        case NOTIFICATION_REWARD:
          if(rewardNotification){
            showSimpleNotification(
                GestureDetector(
                    onTap: () {
                      onChangePageSubject.add(2);
                    },
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
                              child: Text("Nueva Cita de Regalo",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Participa por una cita de",
                                  maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black))),
                        )
                      ],
                    )),
                background: Colors.white);
          }else{
            print(message);
          }
          break;
        case NOTIFICATION_WINNER:
          if(rewardNotification){
            showSimpleNotification(
                GestureDetector(
                    onTap: () {
                      onChangePageSubject.add(2);
                    },
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
                              child: Text('Ganaste una cita!',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Eres el ganador de una fabulosa cita",
                                  maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black))),
                        )
                      ],
                    )),
                background: Colors.white);
          }else{
            print(message);
          }
          break;
        default:
          if(interestNotification) _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
          else print(message);
          break;
      }
    }, onResume: (Map<String, dynamic> message) async {
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
          if(messageNotification){
            final match = UserMatch.fromMessage(message);
            _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match);
          }else{
            print(message);
          }
          break;
        case NOTIFICATION_REWARD:
        case NOTIFICATION_WINNER:
          if(rewardNotification) onChangePageSubject.add(2);
          else print(message);
          break;
        default:
          if(interestNotification) _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
          else print(message);
          break;
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      print("on launch");
      switch (message["data"]["typeMessage"]) {
        case NOTIFICATION_CHAT:
         if(messageNotification){
           final match = UserMatch.fromMessage(message);
           _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
           Future.delayed(
               Duration(milliseconds: 200), () => _navigatorKey.currentState.pushNamed(CHAT_ROUTE, arguments: match));
         }else{
           print(message);
         }
          break;
        case NOTIFICATION_REWARD:
        case NOTIFICATION_WINNER:
          if(rewardNotification) onChangePageSubject.add(2);
          else print(message);
          break;
        default:
          if(interestNotification) _navigatorKey.currentState.pushReplacementNamed(HOME_ROUTE);
          else print(message);
          break;
      }
    });

    _fcm.getToken().then((token) {
      print('TOKEEEEEN $token');
      _repository.updateFirebaseToken(token);
    });
  }
}
