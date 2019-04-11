/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicFormPageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;

    return Column(
      children: [
        SizedBox(height: 20),
        Container(
            alignment: Alignment.centerLeft,
            child: Text("¿Que contextura fisica prefieres para tu pareja?")),
        SizedBox(height: 20),
        Container(
          height: 40,
          child: StreamBuilder<User>(
            stream: bloc.userStream,
            initialData: bloc.user,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Row(
                  children: BodyShapeList.map((item) {
                return Expanded(
                  child: FlatButton(
                      onPressed: () => bloc.updateBodyShapePreferred(item),
                      child: Text(item),
                      textColor: snapshot?.data?.bodyShapePreferred?.contains(item) == true
                          ? Theme.of(context).accentColor
                          : Colors.grey[400]),
                );
              }).toList());
            },
          ),
        ),
        SizedBox(height: 50),
        Container(alignment: Alignment.centerLeft, child: Text("¿Es importante el nivel de ingresos?")),
        SizedBox(height: 20),
        StreamBuilder<User>(
          stream: bloc.userStream,
          initialData: bloc.user,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            return Column(
              children: [
                OptionSelector(
                    options: YesNoOptions,
                    optionSelected:
                        (snapshot.data?.isIncomeImportant == true ? YesNoOptions[0] : YesNoOptions[1]),
                    onSelected: (selected) => bloc.isIncomeImportant = (selected == YesNoOptions[0])),
                SizedBox(height: 40),
                snapshot?.data?.isIncomeImportant != true
                    ? SizedBox()
                    : Row(
                        children: [
                          Text("${FormBloc.MIN_INCOME.toInt()}\n o menos",
                              textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                          Expanded(
                            child: RangeSlider(
                              min: FormBloc.MIN_INCOME,
                              max: FormBloc.MAX_INCOME,
                              lowerValue: (snapshot.data?.minIncomePreferred ??
                                      (FormBloc.MIN_INCOME + FormBloc.STEP_INCOME))
                                  .toDouble(),
                              upperValue: (snapshot.data?.maxIncomePreferred ??
                                      (FormBloc.MAX_INCOME - FormBloc.STEP_INCOME))
                                  .toDouble(),
                              showValueIndicator: true,
                              divisions:
                                  (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                              valueIndicatorMaxDecimals: 0,
                              onChanged: (double newLowerValue, double newUpperValue) =>
                                  bloc.incomeRangePreferred(newLowerValue, newUpperValue),
                            ),
                          ),
                          Text("${FormBloc.MAX_INCOME.toInt()}\n o mas",
                              textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ],
                      ),
              ],
            );
          },
        ),
      ],
    );
  }
}