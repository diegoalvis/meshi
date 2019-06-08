/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/base_bloc.dart';
import 'package:meshi/bloc/profile_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/register/basic/basic_register_page.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:path/path.dart';



class ProfilePage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override

  final strings = MyLocalizations.of(context);
  Widget get title {
    return Text(strings.aboutMe);
  }

  @override

  Widget buildWithInjector(BuildContext context, Injector injector) {


    final bloc = ProfileBloc(injector.get<UserRepository>(), injector.get<SessionManager>());
    return StreamBuilder<bool>(
        stream: bloc.progressSubject.stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? Center(child: CircularProgressIndicator())
              : StreamBuilder<User>(
                  stream: bloc.userStream,
                  initialData: bloc.session.user,
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.data?.images != null) {
                      List.generate(4 - (snapshot.data?.images?.length ?? 0), (index) => null)
                          .forEach((item) => snapshot.data?.images?.add(item));
                    }
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ListView(children: [
                        Column(
                          children: [
                            Text(
                              "Mis fotos",
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                ImageSelector(
                                    snapshot.data?.images?.elementAt(0) ?? null,
                                    (image) => bloc.addImage(image, 0),
                                    (image) => bloc.deleteImage(image, 0)),
                                SizedBox(width: 12),
                                ImageSelector(
                                    snapshot.data?.images?.elementAt(1) ?? null,
                                    (image) => bloc.addImage(image, 1),
                                    (image) => bloc.deleteImage(image, 0)),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                ImageSelector(
                                    snapshot.data?.images?.elementAt(2) ?? null,
                                    (image) => bloc.addImage(image, 2),
                                    (image) => bloc.deleteImage(image, 0)),
                                SizedBox(width: 12),
                                ImageSelector(
                                    snapshot.data?.images?.elementAt(3) ?? null,
                                    (image) => bloc.addImage(image, 3),
                                    (image) => bloc.deleteImage(image, 0)),
                              ],
                            ),
                          ],
                        ),
                        buildProfileDetails(context, snapshot?.data),
                        buildCompleteProfileBanner(context),
                      ]),
                    );
                  });
        });
  }

  Widget buildCompleteProfileBanner(BuildContext context) {
    String route = FORM_ROUTE;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Divider(height: 50.0, color: Colors.grey),
          Text(
            "Completa tu perfil para que Meshi pueda encontrar tu pareja ideal",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.0,
          ),
          FlatButton(
              onPressed: () => Navigator.of(context).pushNamed(route),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              color: Theme.of(context).accentColor,
              child: Text("COMPLETAR PERFIL")),
        ],
      ),
    );
  }

  Widget buildProfileDetails(BuildContext context, User user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Divider(height: 50.0, color: Colors.grey),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BasicRegisterPage(doWhenFinish: BaseBloc.POP_PAGE))),
              child: Text("EDITAR", style: TextStyle(color: Theme.of(context).accentColor)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "¿Como te describes?",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
              user?.description ??
                  "skajdlksadlksajdjlkjsa dlksa jdlksa jdlksa dlksa jdlk jsdlk jsalkd jsald",
              textAlign: TextAlign.left),
          SizedBox(height: 30.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "¿Que te gusta hacer en tus tiempos libres?",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
              user?.freeTime ??
                  "skajdlksadlksajdjlkjsa dlksa jdlksa jdlksa dlksa jdlk jsdlk jsalkd jsald",
              textAlign: TextAlign.left),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
