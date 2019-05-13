/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/rewards_bloc.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/repository/reward_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/localiztions.dart';

import 'brands_page.dart';

class RewardPage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override
  Widget get title {
    return Text("Cita de la semana");
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final bloc = RewardBloc(injector.get<RewardRepository>(), injector.get<SessionManager>());
    return RewardContainer(bloc);
  }
}

class RewardContainer extends StatefulWidget {
  final RewardBloc _bloc;

  const RewardContainer(this._bloc) : super();

  @override
  RewardPageState createState() => new RewardPageState(_bloc);
}

class RewardPageState extends State<RewardContainer> {
  final RewardBloc _bloc;

  Reward reward;
  bool showProgress = false;

  RewardPageState(this._bloc);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.rewardStream.listen((reward) => setState(() => this.reward = reward));
    _bloc.progressSubject.listen((showProgress) => setState(() => this.showProgress = showProgress));
    _bloc.getRewards();
  }

  Future<Null> _fetchRewardData() async {
    setState(() => showProgress = true);
    _bloc.getRewards();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return showProgress
        ? Center(child: CircularProgressIndicator())
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BrandsPage()),
                      );
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
  }
}
