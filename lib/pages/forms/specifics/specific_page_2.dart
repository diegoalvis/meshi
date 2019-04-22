/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
            alignment: Alignment.centerLeft,
            child: Text(
                "Escoge tres de estas opciones para determinar qué es lo más importante en tu vida en este momento")),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<List<String>>(
              stream: bloc.specificsStream,
              initialData: bloc.user.deepening,
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                return ListView.separated(
                  itemCount: LifeGoals.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onTap: () {
                        String selected = LifeGoals[index];
                        var hold = snapshot?.data[4]?.split(",") ?? [];
                        if (hold.contains(selected)) {
                          hold.remove(selected);
                        } else {
                          if (hold.length == 3) {
                            hold.removeAt(0);
                          }
                          hold.add(selected);
                        }
                        bloc.specifics(4, hold.join(","));
                      },
                      title: Row(
                        children: <Widget>[
                          Icon(
                              snapshot?.data[4]?.contains(LifeGoals[index]) == true ? Icons.check : null,
                              color: snapshot?.data[4]?.contains(LifeGoals[index]) == true
                                  ? Theme.of(context).accentColor
                                  : Colors.black),
                          SizedBox(width: 5),
                          Text(
                            LifeGoals[index],
                            style: TextStyle(
                                color: snapshot?.data[4]?.contains(LifeGoals[index]) == true
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
