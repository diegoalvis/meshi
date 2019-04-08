import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc {
  static const _MAX_PICTURES = 4;

  final User user = SessionManager.instance.user;

  final _userSubject = PublishSubject<User>();
  Stream<User> get userStream => _userSubject.stream;

  DateTime selectedDate = DateTime.now();

  void loadFacebookProfile(String fbToken) async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200),age_range,birthday&access_token=$fbToken');

    user.fbToken = fbToken;

    var profile = json.decode(graphResponse.body);
    try {
      user.name = profile['name'];
      user.email = profile['email'];
      List<int> date = profile['birthday'].toString().split('/').map((s) => int.tryParse(s)).toList();
      user.birthday = DateTime(date[2], date[0], date[1]);
      int age = DateTime.now().year - user.birthday.year;
      if (DateTime.now().isBefore(DateTime(DateTime.now().year, date[0], date[1]))) {
        age = age - 1;
      }
      user.age = age;
    } catch (e) {
      print(e.toString());
    }
    _userSubject.sink.add(user);
  }

  set birthday(DateTime birthday) {
    user.birthday = birthday;
    _userSubject.sink.add(user);
  }

  addImage(File image, int index) {
    user.photos[index] = image;
    _userSubject.sink.add(user);
  }

  dispose() {
    _userSubject.close();
  }
}
