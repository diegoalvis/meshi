/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/utils/enum_utils.dart';
import '../advanced_register_container_page.dart';
import '../../form_section.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageThree extends StatelessWidget with FormSection {

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
            alignment: Alignment.centerLeft, child: Text(strings.stylePrefer)),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<Deepening>(
              stream: bloc.deepeningStream,
              initialData: bloc.session.user.deepening ?? Deepening(),
              builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
                final deepening = snapshot.data;
                infoComplete = deepening?.clothingStyle != null;
                return ListView.separated(
                  itemCount: UserDressStyle.values.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onTap: () {
                        String selected = enumValue(UserDressStyle.values[index]);
                        var hold = snapshot?.data?.clothingStyle ?? [];
                        if (hold.contains(selected)) {
                          hold.remove(selected);
                        } else {
                          hold.add(selected);
                        }
                        deepening.clothingStyle = hold;
                        bloc.updateDeepening(deepening);
                      },
                      title: Row(
                        children: <Widget>[
                          Icon(
                              snapshot?.data?.clothingStyle?.contains(enumValue(UserDressStyle.values[index])) == true
                                  ? Icons.check
                                  : null,
                              color: snapshot?.data?.clothingStyle?.contains(enumValue(UserDressStyle.values[index])) == true
                                  ? Theme.of(context).accentColor
                                  : Colors.black),
                          SizedBox(width: 5),
                          Text(
                            strings.getCompatibilityDisplayName(enumValue(UserDressStyle.values[index])),
                            style: TextStyle(
                                color: snapshot?.data?.clothingStyle?.contains(enumValue(UserDressStyle.values[index])) == true
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
