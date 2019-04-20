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

class HabitsFormPageTwo extends StatelessWidget {
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
                  child: Text("¿Te molesta que tu pareja fume?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions2,
                    optionSelected: snapshot.data[3],
                    onSelected: (selected) => bloc.habits(3, selected)),
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
                    optionSelected: snapshot.data[4],
                    onSelected: (selected) => bloc.habits(4, selected)),
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
                    optionSelected: snapshot.data[5],
                    onSelected: (selected) => bloc.habits(5, selected)),
              ])),
            ],
          );
        });
  }
}
