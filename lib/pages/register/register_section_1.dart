import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/localiztions.dart';

// Widget
class RegisterSectionOne extends StatelessWidget {
  final List<File> images;

  const RegisterSectionOne({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = RegisterBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return Column(
            children: [
              Text(
                strings.pictureSelectCaption,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  ImageSelector(snapshot.data?.photos[0] ?? null, (image) => bloc.addImage(image, 0)),
                  SizedBox(width: 12),
                  ImageSelector(snapshot.data?.photos[1] ?? null, (image) => bloc.addImage(image, 1)),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  ImageSelector(snapshot.data?.photos[2] ?? null, (image) => bloc.addImage(image, 2)),
                  SizedBox(width: 12),
                  ImageSelector(snapshot.data?.photos[3] ?? null, (image) => bloc.addImage(image, 3)),
                ],
              ),
            ],
          );
        });
  }
}
