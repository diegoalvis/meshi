/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/data/models/brand.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:rxdart/rxdart.dart';

class SelectPartnerBloc extends BaseBloc<SelectPartnerEvent, BaseState> {
  UserRepository repository;

  SelectPartnerBloc(this.repository, session) : super(session);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(SelectPartnerEvent event) async* {
    switch (event) {
      case SelectPartnerEvent.updateInscription:
        // TODO: Handle this case.
        break;
      case SelectPartnerEvent.getMatches:
        // TODO: Handle this case.
        break;
    }
  }
}

enum SelectPartnerEvent { updateInscription, getMatches }
