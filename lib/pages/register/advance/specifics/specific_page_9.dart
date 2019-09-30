/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import '../advanced_register_container_page.dart';
import '../../form_section.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/enum_utils.dart';

class SpecificsFormPageNine extends StatelessWidget with FormSection {
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
        Container(alignment: Alignment.centerLeft, child: Text(strings.musicalGenre)),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<Deepening>(
              stream: bloc.deepeningStream,
              initialData: bloc.session.user.deepening ?? Deepening(),
              builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
                final deepening = snapshot.data;
                infoComplete = deepening?.music != null;
                return ListView.separated(
                  itemCount: UserMusic.values.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        deepening?.music = enumValue(UserMusic.values[index]);
                        bloc.updateDeepening(deepening);
                      },
                      title: Text(
                        strings.getEnumDisplayName(enumValue(UserMusic.values[index])),
                        style: TextStyle(
                            color: (deepening?.music == enumValue(UserMusic.values[index])
                                ? Theme.of(context).accentColor
                                : Colors.black)),
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
