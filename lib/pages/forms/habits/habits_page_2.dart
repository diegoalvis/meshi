/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/habits.dart';
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
        initialData: bloc.session.user.habits,
        builder: (BuildContext context, AsyncSnapshot<Habits> snapshot) {
          final habits = snapshot.data;
          infoComplete = habits?.likeSmoke != null && habits?.likeDrink != null && habits?.likeSport != null;
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
                    options: UserHabits.values,
                    optionSelected: habits.likeSmoke,
                    onSelected: (selected) {
                      habits.likeSmoke = selected;
                      bloc.updateHabits(habits);
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
                    options: UserHabits.values,
                    optionSelected: habits.likeDrink,
                    onSelected: (selected) {
                      habits.likeDrink = selected;
                      bloc.updateHabits(habits);
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
                    options: UserHabits.values,
                    optionSelected: habits.likeSport,
                    onSelected: (selected) {
                      habits.likeSport = selected;
                      bloc.updateHabits(habits);
                    }),
              ])),
            ],
          );
        });
  }
}
