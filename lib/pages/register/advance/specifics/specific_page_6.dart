/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import '../advanced_register_container_page.dart';
import '../../form_section.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/enum_utils.dart';

class SpecificsFormPageSix extends StatelessWidget with FormSection {
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
        Container(alignment: Alignment.centerLeft, child: Text(strings.placesLike)),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<Deepening>(
              stream: bloc.deepeningStream,
              initialData: bloc.session.user.deepening ?? Deepening(),
              builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
                final deepening = snapshot.data;
                infoComplete = deepening?.places != null;
                return ListView.separated(
                  itemCount: UserPlaces.values.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        deepening.places = enumValue(UserPlaces.values[index]);
                        bloc.updateDeepening(deepening);
                      },
                      title: Text(
                        strings.getEnumDisplayName(enumValue(UserPlaces.values[index])),
                        style: TextStyle(
                            color: (deepening?.places == enumValue(UserPlaces.values[index])
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
