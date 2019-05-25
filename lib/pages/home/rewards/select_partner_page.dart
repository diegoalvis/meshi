/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshi/bloc/select_partner_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/utils/base_state.dart';
import 'package:meshi/utils/localiztions.dart';

class SelectPartnerPage extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final bloc = SelectPartnerBloc(injector.get<UserRepository>(), injector.get<SessionManager>());
    final strings = MyLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Información",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is SuccessState<List<User>>) {
            return Column(
              children: <Widget>[
                Text("Escoje con quien te gustaria ir y no te preocupes que esa persona no lo sabra."),
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final item = state.data.elementAt(index);
                    return ListTile(
                      onTap: () {},
                      title: Row(children: [
                        ClipOval(
                          child: Container(
                              height: 50.0,
                              width: 50.0,
                              child: Image.network(
                                  item.images?.elementAt(0) ??
                                      "https://image.shutterstock.com/image-photo/brunette-girl-long-shiny-wavy-260nw-639921919.jpg",
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(width: 10),
                        Align(alignment: Alignment.topLeft, child: Text(item.name)),
                      ]),
                    );
                  },
                ),
                FlatButton(
                  onPressed: () => bloc.dispatch(SelectPartnerEvent.updateInscription),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: Text("PARTICIPA POR LA CITA"),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
