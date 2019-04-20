/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageSeven extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text("¿A qué tipo de lugares te gusta ir?")),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            child: StreamBuilder<List<String>>(
              stream: bloc.specificsStream,
              initialData: bloc.user.specifics,
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                return ListView.separated(
                  itemCount: PlaceType.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => bloc.specifics(10, PlaceType[index]),
                      title: Text(
                        PlaceType[index],
                        style: TextStyle(
                            color: (snapshot?.data[10] == PlaceType[index]
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
