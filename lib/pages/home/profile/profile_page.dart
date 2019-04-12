/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/blocs/register_bloc.dart';
import 'package:meshi/blocs/rewards_bloc.dart';
import 'package:meshi/data/models/reward_model.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/register/photos_section.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class ProfilePage extends StatelessWidget with HomeSection {
  @override
  Widget get title {
    return Text("Sobre mi");
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    final bloc = RegisterBloc();

    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
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
                          snapshot.data?.photos[0] ?? null, (image) => bloc.addImage(image, 0)),
                      SizedBox(width: 12),
                      ImageSelector(
                          snapshot.data?.photos[1] ?? null, (image) => bloc.addImage(image, 1)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ImageSelector(
                          snapshot.data?.photos[2] ?? null, (image) => bloc.addImage(image, 2)),
                      SizedBox(width: 12),
                      ImageSelector(
                          snapshot.data?.photos[3] ?? null, (image) => bloc.addImage(image, 3)),
                    ],
                  ),
                ],
              )
            ]),
          );
        });
  }
}
