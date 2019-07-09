/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:async';

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/repository/match_repository.dart';
import 'package:meshi/data/repository/chat_repository.dart';
import 'package:meshi/utils/notification_utils.dart';

class InterestsBloc extends BaseBloc<InterestsEvent, BaseState> {
  final MatchRepository repository;
  final ChatRepository chatRepository;
  final NotificationManager notificationsManager;

  //StreamSubscription variable;

  InterestsBloc(this.repository, this.chatRepository, this.notificationsManager, SessionManager session) : super(session: session) {
    notificationsManager.notificationSubject.stream.listen((message) {
      dispatch(InterestsEvent(InterestsEventType.refreshMutuals));
    });
  }

  @override
  void dispose() {
    notificationsManager.dispose();
    //variable.cancel();
    super.dispose();
  }

  @override
  BaseState get initialState => InitialState();

  List<UserMatch> matches;
  int idUserBlock;
  List<MyLikes> myLikes;
  List<MyLikes> likesMe;
  String lastMessage;
  bool refresh = false;

  @override
  Stream<BaseState> mapEventToState(InterestsEvent event) async* {
    try {
      switch (event.type) {
        case InterestsEventType.getMutals:
          yield* _loadMatches(false);
          break;
        case InterestsEventType.refreshMutuals:
          yield* _loadMatches(true);
          break;
        case InterestsEventType.getLikesMe:
          yield* _loadLikesMe(false, event.type);
          break;
        case InterestsEventType.refreshLikesMe:
          yield* _loadLikesMe(true, event.type);
          break;
        case InterestsEventType.getMyLikes:
          yield* _loadMyLikes(false, event.type);
          break;
        case InterestsEventType.refreshMyLikes:
          yield* _loadMyLikes(true, event.type);
          break;
        case InterestsEventType.onMyLikesPageSelected:
          yield InitialState<InterestsEventType>(initialData: InterestsEventType.getMyLikes);
          break;
        case InterestsEventType.onLikesMePageSelected:
          yield InitialState<InterestsEventType>(initialData: InterestsEventType.getLikesMe);
          break;
        case InterestsEventType.onMutualPageSelected:
          yield InitialState();
          break;
        case InterestsEventType.clearChat:
          yield PerformingRequestState();
          matches = await chatRepository.clear(event.data);
          yield SuccessState<List<UserMatch>>(data: matches);
          break;
        case InterestsEventType.blockMatch:
          yield PerformingRequestState();
          await repository.blockMatch(event.data[0]);
          matches.removeAt(event.data[1]);
          yield SuccessState<List<UserMatch>>(data: matches);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }

  Stream<BaseState> _loadMatches(bool refresh) async* {
    if (matches != null && !refresh) {
      yield SuccessState<List<UserMatch>>(data: matches);
    } else {
      yield LoadingState();
      matches = await repository.getMatches();
      yield SuccessState<List<UserMatch>>(data: matches);
    }
  }

  Stream<BaseState> _loadMyLikes(bool refresh, InterestsEventType event) async* {
    if (myLikes != null && !refresh) {
      yield LikesFetchedState(myLikes, event);
    } else {
      yield LoadingState();
      myLikes = await repository.getMyLikes();
      yield LikesFetchedState(myLikes, event);
    }
  }

  Stream<BaseState> _loadLikesMe(bool refresh, InterestsEventType event) async* {
    if (likesMe != null && !refresh) {
      yield LikesFetchedState(likesMe, event);
    } else {
      yield LoadingState();
      likesMe = await repository.getLikesMe();
      yield LikesFetchedState(likesMe, event);
    }
  }
}

class InterestsEvent {
  final InterestsEventType type;
  dynamic data;

  InterestsEvent(this.type, {this.data});
}

class LikesFetchedState extends BaseState {
  final List<MyLikes> myLikes;
  final InterestsEventType eventGenerator;

  LikesFetchedState(this.myLikes, this.eventGenerator) : super(props: [myLikes, eventGenerator]);

  @override
  String toString() => 'state-likes-fetched';
}

enum InterestsEventType {
  getMutals,
  refreshMutuals,
  getLikesMe,
  refreshLikesMe,
  getMyLikes,
  refreshMyLikes,
  onMyLikesPageSelected,
  onLikesMePageSelected,
  onMutualPageSelected,
  clearChat,
  blockMatch
}
