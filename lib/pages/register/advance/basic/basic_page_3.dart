/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/advance/form_bloc.dart';
import 'package:meshi/utils/localiztions.dart';

import '../advanced_register_container_page.dart';
import '../../form_section.dart';

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
      initialData: bloc.session.user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        infoComplete = snapshot.data?.income != null &&
            snapshot.data?.minAgePreferred != null &&
            snapshot.data?.maxAgePreferred != null;
        return Column(
          children: [
            SizedBox(height: 20),
            Container(alignment: Alignment.centerLeft, child: Text(strings.yourIncome)),
            SizedBox(height: 20),
            Container(
                height: 40,
                child: Row(
                  children: [
                    Text("${FormBloc.MIN_INCOME.toInt()}\n ${strings.orLess}",
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                    Expanded(
                        child: Slider(
                            label: snapshot.data?.income?.toInt()?.toString() ?? "",
                            min: FormBloc.MIN_INCOME,
                            max: FormBloc.MAX_INCOME,
                            divisions: (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                            value: snapshot.data?.income ?? (FormBloc.MIN_INCOME + FormBloc.MAX_INCOME) / 2,
                            onChanged: (newUpperValue) => bloc.income = newUpperValue)),
                    Text("${FormBloc.MAX_INCOME.toInt()}\n ${strings.orMore}",
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                  ],
                )),
            SizedBox(height: 80),
            Container(alignment: Alignment.centerLeft, child: Text(strings.agesPrefer)),
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
                      values: RangeValues(
                        (snapshot.data?.minAgePreferred ?? (FormBloc.MIN_AGE + 5)).toDouble(),
                        (snapshot.data?.maxAgePreferred ?? (FormBloc.MAX_AGE - 5)).toDouble(),
                      ),
                      divisions: FormBloc.MAX_AGE - FormBloc.MIN_AGE,
                      onChanged: (values) => bloc.ageRangePreferred(values.start.toInt(), values.end.toInt())),
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
