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

class HabitsFormPageOne extends StatelessWidget with FormSection {

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
          infoComplete = snapshot.data?.smoke != null && snapshot.data?.drink != null && snapshot.data?.sport != null;
          return Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Fumas?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions1,
                    optionSelected: snapshot.data?.smoke,
                    onSelected: (selected) {
                      final habits = snapshot.data;
                      habits.smoke = selected;
                      bloc.habits(habits);
                    }),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Tomas alcohol?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions1,
                    optionSelected: snapshot.data?.drink,
                    onSelected: (selected) {
                      final habits = snapshot.data;
                      habits.drink = selected;
                      bloc.habits(habits);
                    }),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Haces ejercicio?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions1,
                    optionSelected: snapshot.data?.sport,
                    onSelected: (selected) {
                      final habits = snapshot.data;
                      habits.sport = selected;
                      bloc.habits(habits);
                    }),
              ])),
            ],
          );
        });
  }
}
