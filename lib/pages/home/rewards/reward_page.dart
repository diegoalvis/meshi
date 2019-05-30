/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/pages/home/rewards/rewards_bloc.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

import '../../../main.dart';

class RewardPage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override
  Widget get title {
    return Text("Cita de la semana");
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindLazySingleton(
              (inject, params) => RewardBloc(injector.get<SessionManager>(), injector.get<RewardRepository>()));
        },
        child: RewardContainer());
  }
}

class RewardContainer extends StatelessWidget {
  RewardBloc _bloc;

  Future<Null> _fetchRewardData() async {
    _bloc.dispatch(RewardEvent.getCurrent);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<RewardBloc>();
    final strings = MyLocalizations.of(context);
    Reward reward;
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(RewardEvent.getCurrent);
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SuccessState<Reward>) {
            reward = state.data;
          }
          if (state is ErrorState) {
            onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Ocurrio un error")));
            });
          }
          return reward == null
              ? Center(child: Text("No hay datos para mostar"))
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _fetchRewardData,
                        child: reward == null
                            ? ListView()
                            : ListView(children: [
                                Image.network(reward?.image ?? "", height: reward?.image != null ? 280 : 0, fit: BoxFit.cover),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(children: [
                                    SizedBox(height: 24.0),
                                    Text(
                                      "Meshi quiere invitarte una cena para que conozcas a tu pareja ideal.",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Icon(Icons.attach_money),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Align(alignment: Alignment.centerLeft, child: Text("Valor")),
                                              Align(alignment: Alignment.centerLeft, child: Text("7000")),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    Row(
                                      children: [
                                        Icon(Icons.date_range),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Align(alignment: Alignment.centerLeft, child: Text("Participa hasta")),
                                              Align(alignment: Alignment.centerLeft, child: Text("7000")),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                              ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SELECT_PARTNER_ROUTE);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          color: Theme.of(context).accentColor,
                          child: Text(
                            "Participar".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
