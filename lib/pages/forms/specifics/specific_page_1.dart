/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:flutter_counter/flutter_counter.dart';

class SpecificsFormPageOne extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context)?.bloc ?? FormBloc();
    return StreamBuilder<Deepening>(
        stream: bloc.deepeningStream,
        initialData: bloc.user.deepening,
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
                    options: GenericFormOptions3,
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
                    initialValue: deepening.children,
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
                  child: Text("¿Te gustaria tener ${deepening.children == YesNoOptions.first ? 'mas ' : ''}hijos?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions3,
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
