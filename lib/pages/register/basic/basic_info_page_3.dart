/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/form_section.dart';
import 'package:meshi/pages/register/basic/basic_info_container_page.dart';

import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageThree extends StatefulWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  _BasicInfoPageThreeState createState() => _BasicInfoPageThreeState();
}

class _BasicInfoPageThreeState extends State<BasicInfoPageThree> {

  final _focusDescription = FocusNode();
  final _focusOccupation = FocusNode();
  final _focusFreeTime = FocusNode();
  final _focusInterests = FocusNode();

  @override
  void didUpdateWidget(BasicInfoPageThree oldWidget) {
    _focusDescription.unfocus();
    _focusOccupation.unfocus();
    _focusFreeTime.unfocus();
    _focusInterests.unfocus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = BasicInfoBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.session.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          TextEditingController descriptionController = TextEditingController();
          descriptionController.text = snapshot.data?.description ?? "";
          descriptionController
              .addListener(() => bloc.session.user.description = descriptionController.text);

          TextEditingController occupationController = TextEditingController();
          occupationController.text = snapshot.data?.occupation ?? "";
          occupationController
              .addListener(() => bloc.session.user.occupation = occupationController.text);

          TextEditingController freeTimeController = TextEditingController();
          freeTimeController.text = snapshot.data?.freeTime ?? "";
          freeTimeController.addListener(() => bloc.session.user.freeTime = freeTimeController.text);

          TextEditingController interestsController = TextEditingController();
          interestsController.text = snapshot.data?.interests ?? "";
          interestsController.addListener(() => bloc.session.user.interests = interestsController.text);

          widget.infoComplete = descriptionController.text.trim().length > 0 &&
              occupationController.text.trim().length > 0 &&
              freeTimeController.text.trim().length > 0 &&
              interestsController.text.trim().length > 0;

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
                  focusNode: _focusDescription,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    _focusDescription.unfocus();
                    FocusScope.of(context).requestFocus(_focusFreeTime);
                  },
                ),
                SizedBox(height: 25),
                TextField(
                  controller: freeTimeController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.hobbiesCaption,
                  ),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  focusNode: _focusFreeTime,
                  onEditingComplete: () {
                    _focusFreeTime.unfocus();
                    FocusScope.of(context).requestFocus(_focusOccupation);
                  },
                ),
                SizedBox(height: 25),
                TextField(
                  controller: occupationController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.whatYouDo,
                  ),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  focusNode: _focusOccupation,
                  onEditingComplete: () {
                    _focusOccupation.unfocus();
                    FocusScope.of(context).requestFocus(_focusInterests);
                  },
                ),
                SizedBox(height: 25),
                TextField(
                  controller: interestsController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: strings.whatYouLookingFor,
                  ),
                  focusNode: _focusInterests,
                  textCapitalization: TextCapitalization.sentences,
                ),
                SizedBox(height: 25),
              ],
            ),
          );
        });
  }
}
