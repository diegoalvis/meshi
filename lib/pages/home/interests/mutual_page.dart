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
import '../../interests_profile_page.dart';

class MutualPage extends StatelessWidget {
  InterestsBloc _bloc;
  List<UserMatch> matches;
  List<int> blockMatch;
  bool showLoader = false;

  Future<Null> _fetchRewardData() async {
    _bloc.dispatch(InterestsEvent(InterestsEventType.getMutals));
  }

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<InterestsBloc>();
    if (matches == null) {
      _bloc.dispatch(InterestsEvent(InterestsEventType.getMutals));
    }
    final strings = MyLocalizations.of(context);

    void _showDialog(String name, int matchId, int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              ListTile(title: Text(name, style: TextStyle(fontWeight: FontWeight.bold))),
              Divider(),
              FlatButton(
                child: Text("Vaciar chat", style: TextStyle(color: Theme.of(context).primaryColor)),
                onPressed: () {
                  _bloc.dispatch(InterestsEvent(InterestsEventType.clearChat, data: matchId));
                },
              ),
              Divider(),
              FlatButton(
                  child: Text("Eliminar match", style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Eliminar match",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            content: Text("Estas seguro que deseas eliminar de mutuos a $name?"),
                            actions: <Widget>[
                              FlatButton(
                                child:
                                    new Text("Cancelar", style: TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child:
                                    new Text("Confirmar", style: TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  _bloc.dispatch(InterestsEvent(InterestsEventType.blockMatch,
                                      data: blockMatch = [matchId, index]));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }),
            ],
          );
        },
      );
    }

    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        if (state is InitialState) {
          _bloc.dispatch(InterestsEvent(InterestsEventType.getMutals));
        }
      },
      child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PerformingRequestState) {
              showLoader = true;
            }
            if (state is SuccessState<List<UserMatch>>) {
              matches = state.data;
            }
            if (state is ErrorState) {
              onWidgetDidBuild(() {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(strings.anErrorOccurred)));
              });
            }

            return RefreshIndicator(
                onRefresh: _fetchRewardData,
                child: matches == null || matches.length == 0
                    ? ListView(children: <Widget>[
                        SizedBox(height: 100),
                        Center(child: Text(strings.youDoNotHaveMutualsYet))
                      ])
                    : ListView.separated(
                        itemCount: matches.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(height: 20),
                        itemBuilder: (BuildContext context, int index) {
                          final match = matches.elementAt(index);
                          final erased = match.lastDate == null ||
                              (match.erasedDate != null &&
                                  match.erasedDate.millisecondsSinceEpoch >
                                      match.lastDate.millisecondsSinceEpoch);
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, CHAT_ROUTE, arguments: match);
                            },
                            onLongPress: () => _showDialog(match.name, match.idMatch, index),
                            title: Row(children: [
                              ClipOval(
                                child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(context, '/interests-profile',
                                          arguments: UserDetail(id: match.id, isMyLike: 0)),
                                      child: Image.network(
                                          BaseApi.IMAGES_URL_DEV +
                                                  match?.images?.firstWhere((image) => image != null) ??
                                              "",
                                          fit: BoxFit.cover),
                                    )),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(alignment: Alignment.topLeft, child: Text(match?.name ?? "")),
                                    Row(children: [
                                      Text(
                                          erased
                                              ? ""
                                              : DateTime.now().difference(match.lastDate).inDays > 0
                                                  ? DateFormat.yMd().format(match.lastDate)
                                                  : DateFormat.jm().format(match.lastDate),
                                          style: TextStyle(color: Theme.of(context).accentColor)),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Text(erased ? "" : match?.lastMessage ?? "",
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
