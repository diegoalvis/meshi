/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

import '../advanced_register_page.dart';
import '../form_section.dart';

class SpecificsFormPageOne extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<Deepening>(
        stream: bloc.deepeningStream,
        initialData: bloc.session.user.deepening,
        builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
          final deepening = snapshot.data;
          infoComplete = deepening != null &&
              deepening.marriage != null &&
              deepening.children != null &&
              deepening.planChildren != null &&
              deepening.likeChildren != null;
          return Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te gustaria casarte?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: UserMarriage.values,
                    optionSelected: deepening.marriage,
                    onSelected: (selected) {
                      deepening.marriage = selected;
                      bloc.updateDeepening(deepening);
                    }),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Cuantos hijos tienes?"),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Counter(
                    initialValue: deepening?.children ?? 0,
                    minValue: 0,
                    maxValue: 99,
                    decimalPlaces: 0,
                    step: 1,
                    onChanged: (selected) {
                      deepening.children = selected;
                      bloc.updateDeepening(deepening);
                    },
                  ),
                ),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child:
                      Text("¿Te gustaria tener ${deepening?.children != null && (deepening.children > 0) ? 'mas ' : ''}hijos?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: UserPlanChildren.values,
                    optionSelected: deepening.planChildren,
                    onSelected: (selected) {
                      deepening.planChildren = selected;
                      bloc.updateDeepening(deepening);
                    }),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te molesta que tu pareja tenga hijos?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: YesNoOptions,
                    optionSelected: (deepening?.likeChildren == null
                        ? null
                        : deepening?.likeChildren == true ? YesNoOptions[0] : YesNoOptions[1]),
                    onSelected: (selected) {
                      deepening.likeChildren = selected == YesNoOptions.first;
                      bloc.updateDeepening(deepening);
                    }),
              ])),
            ],
          );
        });
  }
}