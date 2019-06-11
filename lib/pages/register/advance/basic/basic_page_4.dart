/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:meshi/bloc/form_bloc.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/enum_helper.dart';
import 'package:meshi/utils/localiztions.dart';

import '../advanced_register_page.dart';
import '../form_section.dart';

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
              return Container(
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
                                lowerValue: (snapshot.data?.minIncomePreferred ?? (FormBloc.MIN_INCOME + FormBloc.STEP_INCOME))
                                    .toDouble(),
                                upperValue: (snapshot.data?.maxIncomePreferred ?? (FormBloc.MAX_INCOME - FormBloc.STEP_INCOME))
                                    .toDouble(),
                                showValueIndicator: true,
                                divisions: (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                                valueIndicatorMaxDecimals: 0,
                                onChanged: (double newLowerValue, double newUpperValue) =>
                                    bloc.incomeRangePreferred(newLowerValue, newUpperValue),
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
