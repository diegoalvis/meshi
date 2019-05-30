/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user.dart';

class RecommendationsEvents {}

class GetRecommendationsEvent extends RecommendationsEvents {
  @override
  String toString() {
    return "GetRecommendations";
  }
}

class AddMatchEvent extends RecommendationsEvents {
  final User user;

  AddMatchEvent(this.user);

  @override
  String toString() => 'AddMatch {user: $user}';
}
