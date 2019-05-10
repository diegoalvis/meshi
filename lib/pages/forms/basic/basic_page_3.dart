/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:meshi/bloc/form_bloc.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicFormPageThree extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
      stream: bloc.userStream,
      initialData: bloc.user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        infoComplete = snapshot.data?.income != null && snapshot.data?.minAgePreferred != null && snapshot.data?.maxAgePreferred != null;
        return Column(
          children: [
            SizedBox(height: 20),
            Container(alignment: Alignment.centerLeft, child: Text("¿Cual es tu nivel de ingresos?")),
            SizedBox(height: 20),
            Container(
                height: 40,
                child: Row(
                  children: [
                    Text("${FormBloc.MIN_INCOME.toInt()}\n o menos", textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                    Expanded(
                        child: Slider(
                            label: snapshot.data?.income?.toInt()?.toString() ?? "",
                            min: FormBloc.MIN_INCOME,
                            max: FormBloc.MAX_INCOME,
                            divisions: (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                            value: snapshot.data?.income ?? (FormBloc.MIN_INCOME + FormBloc.MAX_INCOME) / 2,
                            onChanged: (newUpperValue) => bloc.income = newUpperValue)),
                    Text("${FormBloc.MAX_INCOME.toInt()}\n o mas", textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                  ],
                )),
            SizedBox(height: 80),
            Container(alignment: Alignment.centerLeft, child: Text("¿Que edades prefieres para tu pareja?")),
            SizedBox(height: 40),
            Container(
              height: 40,
              child: Row(children: [
                SizedBox(width: 20),
                Text((snapshot.data?.minAgePreferred ?? FormBloc.MIN_AGE).toString()),
                Expanded(
                  child: RangeSlider(
                      min: FormBloc.MIN_AGE.toDouble(),
                      max: FormBloc.MAX_AGE.toDouble(),
                      lowerValue: (snapshot.data?.minAgePreferred ?? (FormBloc.MIN_AGE + 5)).toDouble(),
                      upperValue: (snapshot.data?.maxAgePreferred ?? (FormBloc.MAX_AGE - 5)).toDouble(),
                      showValueIndicator: true,
                      divisions: FormBloc.MAX_AGE - FormBloc.MIN_AGE,
                      valueIndicatorMaxDecimals: 0,
                      onChanged: (double newLowerValue, double newUpperValue) =>
                          bloc.ageRangePreferred(newLowerValue.toInt(), newUpperValue.toInt())),
                ),
                Text((snapshot.data?.maxAgePreferred ?? FormBloc.MAX_AGE).toString()),
              ]),
            ),
            SizedBox(width: 20),
          ],
        );
      },
    );
  }
}
