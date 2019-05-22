/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/enum_helper.dart';

class SpecificsFormPageEight extends StatelessWidget with FormSection {
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
        Container(alignment: Alignment.centerLeft, child: Text("¿Cuál es tu ideología política?")),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<Deepening>(
              stream: bloc.deepeningStream,
              initialData: bloc.session.user.deepening,
              builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
                final deepening = snapshot.data;
                infoComplete = deepening?.politics != null;
                return ListView.separated(
                  itemCount: UserPolitics.values.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        deepening?.politics = enumValue(UserPolitics.values[index]);
                        bloc.updateDeepening(deepening);
                      },
                      title: Text(
                        strings.getEnumDisplayName(enumValue(UserPolitics.values[index])),
                        style: TextStyle(
                          color: (deepening?.politics == enumValue(UserPolitics.values[index])
                              ? Theme.of(context).accentColor
                              : Colors.black),
                        ),
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
