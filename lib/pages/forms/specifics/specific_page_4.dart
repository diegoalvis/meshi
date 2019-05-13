/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageFour extends StatelessWidget with FormSection {

  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<Deepening>(
      stream: bloc.deepeningStream,
      initialData: bloc.session.user.deepening,
      builder: (BuildContext context, AsyncSnapshot<Deepening> snapshot) {
        final deepening = snapshot.data;
        infoComplete = deepening.isImportantAppearance != null && deepening.isImportantClothing != null && (deepening.isImportantClothing != true || deepening.likeClothing?.isNotEmpty == true);
        return Column(
          children: [
            SizedBox(height: 20),
            Container(
                alignment: Alignment.centerLeft,
                child: Text("¿Es importante para ti la apariencia física de tu pareja?")),
            SizedBox(height: 10),
            OptionSelector(
                options: ImportanceLevels,
                optionSelected: deepening?.isImportantAppearance,
                onSelected: (selected) {
                  deepening.isImportantAppearance = selected;
                  bloc.updateDeepening(deepening);
                }),
            SizedBox(height: 20),
            Container(
                alignment: Alignment.centerLeft,
                child: Text("¿Es importante para ti el estilo de vestir de tu pareja?")),
            SizedBox(height: 10),
            OptionSelector(
                options: YesNoOptions,
                optionSelected: (deepening?.isImportantClothing == null ? null : deepening?.isImportantClothing == true ? YesNoOptions[0] : YesNoOptions[1]),
                onSelected: (selected) {
                  deepening.isImportantClothing = selected == YesNoOptions.first;
                  bloc.updateDeepening(deepening);
                }),
            SizedBox(height: 10),
            Container(
                alignment: Alignment.centerLeft,
                child: deepening.isImportantClothing != true
                    ? SizedBox()
                    : Text("¿Qué estilo de vestir prefieres en tu pareja?")),
            Expanded(
              child: deepening.isImportantClothing != true
                  ? SizedBox()
                  : ListView.separated(
                      itemCount: DressStyle.length,
                      separatorBuilder: (BuildContext context, int index) => Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          onTap: () {
                            String selected = DressStyle[index];
                            var hold = snapshot?.data?.likeClothing ?? [];
                            if (hold.contains(selected)) {
                              hold.remove(selected);
                            } else {
                              hold.add(selected);
                            }
                            deepening.likeClothing = hold;
                            bloc.updateDeepening(deepening);
                          },
                          title: Row(
                            children: <Widget>[
                              Icon(
                                  snapshot?.data?.likeClothing?.contains(DressStyle[index]) == true
                                      ? Icons.check
                                      : null,
                                  color: snapshot?.data?.likeClothing?.contains(DressStyle[index]) == true
                                      ? Theme.of(context).accentColor
                                      : Colors.black),
                              SizedBox(width: 5),
                              Text(
                                DressStyle[index],
                                style: TextStyle(
                                    color: snapshot?.data?.likeClothing?.contains(DressStyle[index]) == true
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
