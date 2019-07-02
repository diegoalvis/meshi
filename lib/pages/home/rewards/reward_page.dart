/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/reward_info.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/rewards/rewards_bloc.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../main.dart';

class RewardPage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override
  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text(strings.appointmentOfWeek);
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return InjectorWidget.bind(
        bindFunc: (binder) {
          binder.bindLazySingleton((inject, params) => RewardBloc(injector.get(), injector.get()));
        },
        child: RewardContainer());
  }
}

class RewardContainer extends StatelessWidget {
  RewardBloc _bloc;

  Future<Null> _fetchRewardData() async {
    _bloc.dispatch(RewardEventType.getCurrent);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<RewardBloc>();
    final strings = MyLocalizations.of(context);
    RewardInfo rewardInfo;
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _fetchRewardData();
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SuccessState<RewardInfo>) {
            rewardInfo = state.data;
          }
          if (state is SuccessState<bool> && state.data) {
            Navigator.pop(context);
          }
          if (state is ErrorState) {
            onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(strings.tryError)));
            });
          }
          return rewardInfo == null
              ? Center(child: Text(strings.noData))
              : RefreshIndicator(
                  onRefresh: _fetchRewardData,
                  child: Material(
                    child: rewardInfo == null
                        ? ListView()
                        : Column(children: [
                            Expanded(
                              child: rewardInfo?.winner == true
                                  ? QrImage(data: "${BaseApi.BASE_URL_DEV}/winner/${rewardInfo?.joinId}" )
                                  : Image.network(BaseApi.IMAGES_URL_DEV + (rewardInfo?.reward?.image ?? ""), fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(children: [
                                SizedBox(height: 24.0),
                                Text(
                                  rewardInfo?.winner == true
                                      ? "${strings.youAnd} ${rewardInfo?.couple?.name ?? ""} ${strings.wonAppointment}"
                                      : "${strings.meshiInvitation}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: 30.0),
                                Row(
                                  children: [
                                    Icon(Icons.attach_money),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(alignment: Alignment.centerLeft, child: Text(strings.value)),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(rewardInfo?.reward?.value?.toString() ?? "")),
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
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(rewardInfo?.winner == true ? strings.validUntil : strings.participateUp)),
                                          Align(alignment: Alignment.centerLeft, child: Text(getRewardDate(rewardInfo))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: buildActionButton(context, rewardInfo),
                            ),
                          ]),
                  ),
                );
        });
  }

  Widget buildActionButton(BuildContext context, RewardInfo rewardInfo) {
    final winner = rewardInfo?.winner == true;
    final joined = rewardInfo?.joined == true;
    final strings = MyLocalizations.of(context);
    return Align(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, winner ? BRANDS_ROUTE : joined ? null : SELECT_PARTNER_ROUTE,
              arguments: rewardInfo.reward.id);
        },
        shape: winner || joined ? null : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: winner || joined ? null : Theme.of(context).accentColor,
        child: Text(
          "${winner ? "${strings.lookClaim}" : joined ? "${strings.alreadyJoined}" : "${strings.takePart}"}".toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(color: winner || joined ? Theme.of(context).accentColor : Colors.white),
        ),
      ),
    );
  }

  String getRewardDate(RewardInfo rewardInfo) {
    final rewardDate = rewardInfo?.winner == true ? rewardInfo?.reward?.validDate : rewardInfo?.reward?.choseDate;
    if (rewardDate != null) {
      return DateFormat.yMd().format(rewardDate);
    } else {
      return "";
    }
  }
}
