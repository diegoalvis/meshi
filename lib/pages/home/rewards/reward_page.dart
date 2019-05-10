/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/bloc/rewards_bloc.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/localiztions.dart';

class RewardPage extends StatefulWidget with HomeSection {
  @override
  Widget get title {
    return Text("Cita de la semana");
  }

  @override
  RewardPageState createState() => new RewardPageState(RewardBloc());
}

class RewardPageState extends State<RewardPage> {
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
                          Image.network(reward?.image ?? "",
                              height: reward?.image != null ? 280 : 0, fit: BoxFit.cover),
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
                                  Column(
                                    children: [Text("Valor"), Text("7000")],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.0),
                              Row(
                                children: [
                                  Icon(Icons.date_range),
                                  SizedBox(width: 8.0),
                                  Column(
                                    children: [Text("Participa hasta"), Text("10/05/2019")],
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
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
