import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/utils/gender.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc {
  static const _MAX_PICTURES = 4;

  final _userSubject = PublishSubject<User>();
  // stream outputs
  Stream<User> get user => _userSubject.stream;

  DateTime selectedDate = DateTime.now();
  Gender _userDefineGender, _userInterestedGender;

  void loadFacebookProfile(String fbToken) async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$fbToken');

    final user = User();
    var profile = json.decode(graphResponse.body);
    try {
      user.name = profile['name'];
      user.email = profile['email'];
    } catch (e) {
      print(e.toString());
    }
    _userSubject.sink.add(user);
  }

  dispose() {
    _userSubject.close();
  }
}
