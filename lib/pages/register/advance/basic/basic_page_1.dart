/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/enum_utils.dart';

import '../advanced_register_container_page.dart';
import '../../form_section.dart';

class BasicFormPageOne extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  int requiredOptions() => 1;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text(strings.educationalLevelCaption)),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<User>(
              stream: bloc.userStream,
              initialData: bloc.session.user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                infoComplete = snapshot?.data?.eduLevel != null;
                return ListView.separated(
                  itemCount: UserEducation.values.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => bloc.eduLevel = enumValue(UserEducation.values[index]),
                      title: Text(
                        strings.getEnumDisplayName(enumValue(UserEducation.values[index])),
                        style: TextStyle(
                            color: (snapshot?.data?.eduLevel == enumValue(UserEducation.values[index])
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
