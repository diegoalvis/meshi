/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicFormPageOne extends StatelessWidget with FormSection {

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
                  itemCount: EducationalLevels.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => bloc.eduLevel = EducationalLevels[index],
                      title: Text(
                        EducationalLevels[index],
                        style: TextStyle(
                            color: (snapshot?.data?.eduLevel == EducationalLevels[index]
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
