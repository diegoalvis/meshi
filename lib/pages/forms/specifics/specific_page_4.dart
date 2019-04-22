/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<List<String>>(
      stream: bloc.specificsStream,
      initialData: bloc.user.deepening,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        return Column(
          children: [
            SizedBox(height: 20),
            Container(
                alignment: Alignment.centerLeft,
                child: Text("¿Es importante para ti el estilo de vestir de tu pareja?")),
            SizedBox(height: 20),
            OptionSelector(
                options: YesNoOptions,
                optionSelected: snapshot.data[6],
                onSelected: (selected) => bloc.specifics(6, selected)),
            SizedBox(height: 20),
            Container(
                alignment: Alignment.centerLeft,
                child: snapshot.data[6] != YesNoOptions.first
                    ? SizedBox()
                    : Text("¿Qué estilo de vestir prefieres en tu pareja?")),
            SizedBox(height: 20),
            Expanded(
              child: snapshot.data[6] != YesNoOptions.first
                  ? SizedBox()
                  : ListView.separated(
                      itemCount: DressStyle.length,
                      separatorBuilder: (BuildContext context, int index) => Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          onTap: () {
                            String selected = DressStyle[index];
                            var hold = snapshot?.data[7]?.split(",") ?? [];
                            if (hold.contains(selected)) {
                              hold.remove(selected);
                            } else {
                              hold.add(selected);
                            }
                            bloc.specifics(7, hold.join(","));
                          },
                          title: Row(
                            children: <Widget>[
                              Icon(
                                  snapshot?.data[7]?.contains(DressStyle[index]) == true
                                      ? Icons.check
                                      : null,
                                  color: snapshot?.data[7]?.contains(DressStyle[index]) == true
                                      ? Theme.of(context).accentColor
                                      : Colors.black),
                              SizedBox(width: 5),
                              Text(
                                DressStyle[index],
                                style: TextStyle(
                                    color: snapshot?.data[7]?.contains(DressStyle[index]) == true
                                        ? Theme.of(context).accentColor
                                        : Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
