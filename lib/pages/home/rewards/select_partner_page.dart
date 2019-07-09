/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/pages/home/rewards/select_partner_bloc.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

class SelectPartnerPage extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final strings = MyLocalizations.of(context);
    final int rewardId = ModalRoute.of(context).settings.arguments;
    final bloc = SelectPartnerBloc(rewardId, injector.get(), injector.get());
    List<UserMatch> matches;
    UserMatch matchSelected;
    bool showSmallProgress;
    final dialog = AlertDialog(
      title: Text("Gracias por participar!"),
      content: Text(
          "Te avisaremos si ganaste la cita una vez se realice el sorteo."),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.SelectYourPartner),
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            showSmallProgress = state is PerformingRequestState;

            if (state is InitialState) {
              bloc.dispatch(
                  SelectPartnerEvent(SelectPartnerEventType.getMatches));
            }
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SuccessState<List<UserMatch>>) {
              matches = state.data;
            }
            if (state is SuccessState<bool> && state.data) {
              Future.delayed(Duration(seconds: 3),
                  () => Navigator.removeRoute(context, ModalRoute.of(context)));
              onWidgetDidBuild(() {
                showDialog(context: context, builder: (cxt) => dialog);
              });
            }

            if (state is PartnerSelectedState) {
              matchSelected = state.match;
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: matches == null
                  ? SizedBox()
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            strings.ChooseWhoYouWould,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: matches.length,
                            itemBuilder: (context, index) {
                              final item = matches.elementAt(index);
                              return ListTile(
                                onTap: () {
                                  bloc.dispatch(SelectPartnerEvent(
                                      SelectPartnerEventType.selectPartner,
                                      data: item));
                                },
                                title: Row(children: [
                                  ClipOval(
                                    child: Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Image.network(
                                          BaseApi.IMAGES_URL_DEV +
                                                  item.images?.elementAt(0) ??
                                              "",
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(item.name)),
                                  Spacer(),
                                  matchSelected?.id == item.id
                                      ? Icon(
                                          AppIcons.logo,
                                          color: Theme.of(context).primaryColor,
                                          size: 30,
                                        )
                                      : SizedBox()
                                ]),
                              );
                            },
                          ),
                        ),
                        matchSelected == null
                            ? SizedBox()
                            : Align(
                                alignment: Alignment.centerRight,
                                child: showSmallProgress
                                    ? Center(child: CircularProgressIndicator())
                                    : FlatButton(
                                        onPressed: () => matchSelected == null
                                            ? null
                                            : bloc.dispatch(SelectPartnerEvent(
                                                SelectPartnerEventType
                                                    .updateInscription,
                                                data: matchSelected)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        color: Theme.of(context).accentColor,
                                        child: Text(
                                            strings.participateByAppointment),
                                      ),
                              ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
