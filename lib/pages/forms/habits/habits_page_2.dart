/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class HabitsFormPageTwo extends StatelessWidget with FormSection {

  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<Habits>(
        stream: bloc.habitsStream,
        initialData: bloc.user.habits,
        builder: (BuildContext context, AsyncSnapshot<Habits> snapshot) {
          infoComplete = snapshot.data?.likeSmoke != null && snapshot.data?.likeDrink != null && snapshot.data?.likeSport != null;
          return Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te molesta que tu pareja fume?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions2,
                    optionSelected: snapshot.data.likeSmoke,
                    onSelected: (selected) {
                      final habits = snapshot.data;
                      habits.likeSmoke = selected;
                      bloc.habits(habits);
                    }),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te molesta que tu pareja tome bebidas alcholicas?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions2,
                    optionSelected: snapshot.data.likeDrink,
                    onSelected: (selected) {
                      final habits = snapshot.data;
                      habits.likeDrink = selected;
                      bloc.habits(habits);
                    }),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Es importante que tu pareja se ejercite?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions1,
                    optionSelected: snapshot.data.likeSport,
                    onSelected: (selected) {
                      final habits = snapshot.data;
                      habits.likeSport = selected;
                      bloc.habits(habits);
                    }),
              ])),
            ],
          );
        });
  }
}
