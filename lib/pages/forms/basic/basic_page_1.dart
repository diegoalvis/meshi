/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicFormPageOne extends StatelessWidget {
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
              initialData: bloc.user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
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
