/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meshi/bloc/interests_bloc.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

import '../../../main.dart';

class MutualPage extends StatelessWidget {
  InterestsBloc _bloc;
  List<UserMatch> matches;

  Future<Null> _fetchRewardData() async {
    _bloc.dispatch(InterestsEventType.getMutals);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<InterestsBloc>();
    _bloc.dispatch(InterestsEventType.getMutals);
    final strings = MyLocalizations.of(context);
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is InitialState) {
          _bloc.dispatch(InterestsEventType.getMutals);
        }
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SuccessState<List<UserMatch>>) {
              matches = state.data;
            }
            if (state is ErrorState) {
              onWidgetDidBuild(() {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Ocurrio un error")));
              });
            }

            return RefreshIndicator(
                onRefresh: _fetchRewardData,
                child: matches == null
                    ? ListView(children: <Widget>[
                        SizedBox(height: 100),
                        Center(child: Text("No tienes mutuos aun"))
                      ])
                    : ListView.separated(
                        itemCount: matches.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(height: 20),
                        itemBuilder: (BuildContext context, int index) {
                          final match = matches.elementAt(index);
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, CHAT_ROUTE, arguments: match);
                            },
                            title: Row(children: [
                              ClipOval(
                                child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Image.network(
                                        BaseApi.IMAGES_URL_DEV +
                                                match?.images?.firstWhere((image) => image != null) ??
                                            "",
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(alignment: Alignment.topLeft, child: Text(match?.name ?? "")),
                                    Row(children: [
                                      Text(
                                          match.lastDate == null
                                              ? ""
                                              : DateTime.now().difference(match.lastDate).inDays > 0
                                                  ? DateFormat.yMd().format(match.lastDate)
                                                  : DateFormat.jm().format(match.lastDate),
                                          style: TextStyle(color: Theme.of(context).accentColor)),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Text(match?.lastMessage ?? "",
                                              overflow: TextOverflow.ellipsis)),
                                    ])
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }));
          }),
    );
  }
}
