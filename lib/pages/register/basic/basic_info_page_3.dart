/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/advance/form_section.dart';
import 'package:meshi/pages/register/basic/basic_register_page.dart';

import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageThree extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = RegisterBlocProvider
        .of(context)
        .bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.session.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          TextEditingController descriptionController = TextEditingController();
          descriptionController.text = snapshot.data?.description ?? "";
          descriptionController.addListener(() => bloc.session.user.description = descriptionController.text);

          TextEditingController occupationController = TextEditingController();
          occupationController.text = snapshot.data?.occupation ?? "";
          occupationController.addListener(() => bloc.session.user.occupation = occupationController.text);

          TextEditingController freeTimeController = TextEditingController();
          freeTimeController.text = snapshot.data?.freeTime ?? "";
          freeTimeController.addListener(() => bloc.session.user.freeTime = freeTimeController.text);

          TextEditingController interestsController = TextEditingController();
          interestsController.text = snapshot.data?.interests ?? "";
          interestsController.addListener(() => bloc.session.user.interests = interestsController.text);

          infoComplete = descriptionController.text
              .trim()
              .length > 0 &&
              occupationController.text
                  .trim()
                  .length > 0 &&
              freeTimeController.text
                  .trim()
                  .length > 0 &&
              interestsController.text
                  .trim()
                  .length > 0;

          return SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  strings.tellUsAboutYou,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.howDescribeYourself,
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: freeTimeController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.hobbiesCaption,
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: occupationController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.whatYouDo,
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: interestsController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.whatYouLookingFor,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          );
        });
  }
}