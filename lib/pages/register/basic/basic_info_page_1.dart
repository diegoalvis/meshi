/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/form_section.dart';
import 'package:meshi/pages/register/basic/basic_info_container_page.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/localiztions.dart';

// Widget
class BasicInfoPageOne extends StatelessWidget with FormSection {
  bool imagesNotEmpty;

  @override
  bool isInfoComplete() => imagesNotEmpty;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = BasicInfoBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.session.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          imagesNotEmpty = snapshot.data?.images != null &&
              snapshot.data?.images?.firstWhere((image) => image?.isNotEmpty ?? false, orElse: () => null) != null;

          if(snapshot.data?.images != null) {
            List.generate(4 - (snapshot.data?.images?.length ?? 0), (index) => null).forEach((item) => snapshot.data?.images?.add(item));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  strings.pictureSelectCaption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    ImageSelector(snapshot.data?.images?.elementAt(0), (image) => bloc.addImage(image, 0),
                        (image) => bloc.deleteImage(image, 0)),
                    SizedBox(width: 12),
                    ImageSelector(snapshot.data?.images?.elementAt(1), (image) => bloc.addImage(image, 1),
                        (image) => bloc.deleteImage(image, 1)),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    ImageSelector(snapshot.data?.images?.elementAt(2), (image) => bloc.addImage(image, 2),
                        (image) => bloc.deleteImage(image, 2)),
                    SizedBox(width: 12),
                    ImageSelector(snapshot.data?.images?.elementAt(3), (image) => bloc.addImage(image, 3),
                        (image) => bloc.deleteImage(image, 3)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
