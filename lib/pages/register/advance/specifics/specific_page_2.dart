/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';
import '../advanced_register_page.dart';
import '../form_section.dart';

class SpecificsFormPageTwo extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
            alignment: Alignment.centerLeft,
            child: Text("Escoge tres de estas opciones para determinar qué es lo más importante en tu vida en este momento")),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<Deepening>(
              stream: bloc.deepeningStream,
              initialData: bloc.session.user.deepening,
              builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
                final deepening = snapshot.data;
                infoComplete = deepening?.priorities?.length == 3;
                return ListView.separated(
                  itemCount: LifeGoals.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onTap: () {
                        String selected = LifeGoals[index];
                        var hold = deepening?.priorities ?? [];
                        if (hold.contains(selected)) {
                          hold.remove(selected);
                        } else {
                          if (hold.length == 3) {
                            hold.removeAt(0);
                          }
                          hold.add(selected);
                        }
                        deepening.priorities = hold;
                        bloc.updateDeepening(deepening);
                      },
                      title: Row(
                        children: <Widget>[
                          Icon(deepening?.priorities?.contains(LifeGoals[index]) == true ? Icons.check : null,
                              color: deepening?.priorities?.contains(LifeGoals[index]) == true
                                  ? Theme.of(context).accentColor
                                  : Colors.black),
                          SizedBox(width: 5),
                          Text(
                            LifeGoals[index],
                            style: TextStyle(
                                color: deepening?.priorities?.contains(LifeGoals[index]) == true
                                    ? Theme.of(context).accentColor
                                    : Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}