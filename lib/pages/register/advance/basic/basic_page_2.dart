/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/utils/enum_helper.dart';
import 'package:meshi/utils/localiztions.dart';

import '../advanced_register_page.dart';
import '../form_section.dart';

class BasicFormPageTwo extends StatelessWidget with FormSection {
  bool infoComplete;

  @override
  bool isInfoComplete() => infoComplete;

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    final TextEditingController _controller = TextEditingController();
    _controller.text = bloc.session.user?.height?.toString() ?? "";
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(alignment: Alignment.centerLeft, child: Text(strings.yourPhysical)),
          SizedBox(height: 20),
          Container(
            height: 40,
            child: StreamBuilder<User>(
              stream: bloc.userStream,
              initialData: bloc.session.user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                infoComplete = snapshot.data?.bodyShape != null && snapshot.data?.height != null;
                return Row(
                    //TODO: (value) => strings.getEnum(enumName(value))
                    children: UserShape.values.map((value) => enumValue(value)).map((item) {
                  return Expanded(
                    child: FlatButton(
                        onPressed: () => bloc.shape = item,
                        child: Text(strings.getEnumDisplayName(item)),
                        textColor: snapshot?.data?.bodyShape == item ? Theme.of(context).accentColor : Colors.grey[400]),
                  );
                }).toList());
              },
            ),
          ),
          SizedBox(height: 50),
          Container(alignment: Alignment.centerLeft, child: Text(strings.howTall)),
          SizedBox(height: 20),
          StreamBuilder<User>(
            stream: bloc.userStream,
            initialData: bloc.session.user,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Padding(
                padding: EdgeInsets.only(right: 80.0),
                child: TextField(
                  controller: _controller,
                  onChanged: (text) => bloc.height = int.tryParse(text) ?? snapshot.data.height,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "cm", hintText: "123"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
