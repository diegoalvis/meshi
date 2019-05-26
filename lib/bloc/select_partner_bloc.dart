/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/utils/base_state.dart';

class SelectPartnerBloc extends BaseBloc<SelectPartnerEvent, BaseState> {
  UserRepository repository;

  SelectPartnerBloc(this.repository, session) : super(session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(SelectPartnerEvent event) async* {
    try {
      switch (event.event) {
        case SelectPartnerEventType.updateInscription:
          yield LoadingState();
          //TODO make call to the repo
          yield SuccessState<bool>(data: true);
          break;
        case SelectPartnerEventType.getMatches:
          yield LoadingState();
          //TODO make call to the repo
          final mockUser = User(name: "Maria", images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGYWrm1RxkJkLgt6dGcF7O9BRA8osy_lKoyL0w6ESMPAXqXuzp"]);
          yield SuccessState<List<User>>(data: List<User>.generate(10, (i) => mockUser));
          break;
        case SelectPartnerEventType.selectPartner:
          yield PartnerSelectedState(event.data as int);
          break;
      }
    } on Exception catch (e) {
      yield ErrorState(exception: e);
    }
  }
}

enum SelectPartnerEventType { updateInscription, getMatches, selectPartner }

class SelectPartnerEvent<T> {
  final SelectPartnerEventType event;
  final T data;

  SelectPartnerEvent(this.event, {this.data});
}


class PartnerSelectedState extends BaseState {
  final int position;

  PartnerSelectedState(this.position): super(props: [position]);

  @override
  String toString() => 'select-partner-initial';
}
