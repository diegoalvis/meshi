/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/data/models/user_preferences.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/notification_manager.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/utils/base_state.dart';

class SettingsBloc extends BaseBloc<SettingsEvent, BaseState> {
  final UserRepository repository;
  final NotificationManager notificationManager;

  SettingsBloc(this.repository, this.notificationManager, SessionManager session) : super(session: session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(SettingsEvent event) async* {
    try {
      switch (event.type) {
        case SettingsEventType.getUserPreferences:
          UserPreferences userPreferences = await repository.fetchLocalUserPreferences();
          yield SuccessState<UserPreferences>(data: userPreferences);
          userPreferences = await repository.fetchUserPreferences();
          yield SuccessState<UserPreferences>(data: userPreferences);
          break;
        case SettingsEventType.updateUserPreferences:
          yield LoadingState();
          repository.updateUserPreferences(event.data);
          yield SuccessState<UserPreferences>(data: event.data);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum SettingsEventType { getUserPreferences, updateUserPreferences }

class SettingsEvent {
  final SettingsEventType type;
  UserPreferences data;

  SettingsEvent(this.type, {this.data});
}
