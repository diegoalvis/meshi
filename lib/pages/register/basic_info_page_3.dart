/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/pages/register/register_section.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageThree extends StatelessWidget with RegisterSection {
  @override
  bool isInfoComplete() {
    // TODO implement
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = RegisterBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          TextEditingController descriptionController = new TextEditingController();
          TextEditingController occupationController = new TextEditingController();
          TextEditingController freeTimeController = new TextEditingController();
          TextEditingController interestsController = new TextEditingController();
          descriptionController.text = snapshot.data?.description ?? "";
          freeTimeController.text = snapshot.data?.freeTime ?? "";
          occupationController.text = snapshot.data?.occupation ?? "";
          interestsController.text = snapshot.data?.interests ?? "";

          return SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  strings.tellUsAboutYou,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                TextField(
                  onChanged: (text) => bloc.description = text,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.howDescribeYourself,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (text) => bloc.freeTime = text,
                  controller: freeTimeController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.hobbiesCaption,
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  onChanged: (text) => bloc.occupation = text,
                  controller: occupationController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.whatYouDo,
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  onChanged: (text) => bloc.interests = text,
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
