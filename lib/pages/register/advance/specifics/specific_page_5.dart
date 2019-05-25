/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import '../advanced_register_page.dart';
import '../form_section.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageFive extends StatelessWidget with FormSection {

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
            child: Text("¿Qué actividades prefieres compartir en pareja?\nElige 3.")),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<Deepening>(
              stream: bloc.deepeningStream,
              initialData: bloc.session.user.deepening,
              builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
                final deepening = snapshot.data;
                infoComplete = deepening?.activities?.length == 3;
                return ListView.separated(
                  itemCount: CoupleActivities.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onTap: () {
                        String selected = CoupleActivities[index];
                        var hold = snapshot?.data?.activities ?? [];
                        if (hold.contains(selected)) {
                          hold.remove(selected);
                        } else {
                          if (hold.length == 3) {
                            hold.removeAt(0);
                          }
                          hold.add(selected);
                        }
                        deepening.activities = hold;
                        bloc.updateDeepening(deepening);
                      },
                      title: Row(
                        children: <Widget>[
                          Icon(
                              deepening?.activities?.contains(CoupleActivities[index]) == true
                                  ? Icons.check
                                  : null,
                              color: deepening?.activities?.contains(CoupleActivities[index]) == true
                                  ? Theme.of(context).accentColor
                                  : Colors.black),
                          SizedBox(width: 5),
                          Text(
                            CoupleActivities[index],
                            style: TextStyle(
                                color: deepening?.activities?.contains(CoupleActivities[index]) == true
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
