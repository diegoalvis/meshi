import 'package:flutter/material.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class SpecificsFormPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context)?.bloc ?? FormBloc();
    return StreamBuilder<List<String>>(
        stream: bloc.specificsStream,
        initialData: bloc.user.specifics,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          return Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te gustaria casarte?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions3,
                    optionSelected: snapshot.data[0],
                    onSelected: (selected) => bloc.specifics(0, selected)),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Tienes hijos?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: YesNoOptions,
                    optionSelected: snapshot.data[1],
                    onSelected: (selected) => bloc.specifics(1, selected)),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te gustaria tener ${snapshot.data[1] == 'Si' ? 'mas ' : ''}hijos?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: GenericFormOptions3,
                    optionSelected: snapshot.data[2],
                    onSelected: (selected) => bloc.specifics(2, selected)),
              ])),
              Expanded(
                  child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("¿Te molesta que tu pareja tenga hijos?"),
                ),
                SizedBox(height: 20),
                OptionSelector(
                    options: YesNoOptions,
                    optionSelected: snapshot.data[3],
                    onSelected: (selected) => bloc.specifics(3, selected)),
              ])),
            ],
          );
        });
  }
}
