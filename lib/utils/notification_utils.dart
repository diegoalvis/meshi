import 'package:meshi/data/models/user_match.dart';
import 'package:rxdart/rxdart.dart';

const String NOTIFICATION_REWARD = "notification_reward";
const String NOTIFICATION_CHAT = "notification_chat";
const String NOTIFICATION_MATCH = "notification_match";
const String NOTIFICATION_INTEREST = "notification_interest";
const String NOTIFICATION_WINNER = "notification_winner";

class NotificationManager{
  final notificationSubject = PublishSubject<UserMatch>();

  void dispose() {
    notificationSubject.close();
  }
}