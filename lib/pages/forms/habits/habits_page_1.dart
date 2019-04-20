/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class HabitsFormPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<List<String>>(
        stream: bloc.habitsStream,
        initialData: bloc.user.habits,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
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
                    optionSelected: snapshot.data[0],
                    onSelected: (selected) => bloc.habits(0, selected)),
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
                    optionSelected: snapshot.data[1],
                    onSelected: (selected) => bloc.habits(1, selected)),
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
                    optionSelected: snapshot.data[2],
                    onSelected: (selected) => bloc.habits(2, selected)),
              ])),
            ],
          );
        });
  }
}
