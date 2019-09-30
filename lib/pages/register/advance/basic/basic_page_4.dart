/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/advance/form_bloc.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/enum_utils.dart';
import 'package:meshi/utils/localiztions.dart';

import '../advanced_register_container_page.dart';
import '../../form_section.dart';

class BasicFormPageFour extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
      stream: bloc.userStream,
      initialData: bloc.session.user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        infoComplete = snapshot.data?.bodyShapePreferred != null &&
            snapshot.data.bodyShapePreferred.isNotEmpty &&
            (snapshot.data?.isIncomeImportant == false ||
                (snapshot.data?.minIncomePreferred != null && snapshot.data?.maxIncomePreferred != null));
        return Column(
          children: [
            SizedBox(height: 20),
            Container(alignment: Alignment.centerLeft, child: Text(strings.physicalPrefer)),
            SizedBox(height: 20),
            Row(
                children: UserShape.values.map((value) => enumValue(value)).map((item) {
              return Expanded(
                //flex: item.length,
                child: FlatButton(
                    onPressed: () => bloc.updateBodyShapePreferred(item),
                    child: Text(strings.getEnumDisplayName(item)),
                    textColor: snapshot?.data?.bodyShapePreferred?.contains(item) == true
                        ? Theme.of(context).accentColor
                        : Colors.grey[400]),
              );
            }).toList()),
            SizedBox(height: 20),
            Container(alignment: Alignment.centerLeft, child: Text(strings.levelncomeImport)),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  OptionSelector(
                      options: YesNoOptions,
                      optionSelected: (snapshot.data?.isIncomeImportant == null
                          ? null
                          : snapshot.data?.isIncomeImportant == true ? YesNoOptions[0] : YesNoOptions[1]),
                      onSelected: (selected) => bloc.isIncomeImportant = (selected == YesNoOptions[0])),
                  SizedBox(height: 40),
                  snapshot?.data?.isIncomeImportant != true
                      ? SizedBox()
                      : Row(
                          children: [
                            Text("${FormBloc.MIN_INCOME.toInt()}\n ${strings.orLess}",
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                            Expanded(
                              child: RangeSlider(
                                min: FormBloc.MIN_INCOME,
                                max: FormBloc.MAX_INCOME,
                                labels: RangeLabels(
                                  (snapshot.data?.minIncomePreferred?.toString() ??
                                      (FormBloc.MIN_INCOME + FormBloc.STEP_INCOME).toString()),
                                  (snapshot.data?.maxIncomePreferred?.toString() ??
                                      (FormBloc.MAX_INCOME - FormBloc.STEP_INCOME).toString()),
                                ),
                                values: RangeValues(
                                  (snapshot.data?.minIncomePreferred ?? (FormBloc.MIN_INCOME + FormBloc.STEP_INCOME))
                                      .toDouble(),
                                  (snapshot.data?.maxIncomePreferred ?? (FormBloc.MAX_INCOME - FormBloc.STEP_INCOME))
                                      .toDouble(),
                                ),
                                divisions: (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                                onChanged: (values) => bloc.incomeRangePreferred(values.start, values.end),
                              ),
                            ),
                            Text("${FormBloc.MAX_INCOME.toInt()}\n ${strings.orMore}",
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                          ],
                        ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
