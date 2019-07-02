import 'package:rxdart/rxdart.dart';

const String NOTIFICATION_REWARD = "notification_reward";
const String NOTIFICATION_CHAT = "notification_chat";
const String NOTIFICATION_MATCH = "notification_match";

class NotificationUtils{
  final notificationSubject = PublishSubject<int>();

  void dispose() {
    notificationSubject.close();
  }
}