/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/deepening.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/forms/form_page.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/strings.dart';

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
          Container(alignment: Alignment.centerLeft, child: Text("¿Cual es tu contextura fisica?")),
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
                    children: UserShape.values.map((value) => enumName(value)).map((item) {
                  return Expanded(
                    child: FlatButton(
                        onPressed: () => bloc.shape = item,
                        child: Text(item),
                        textColor: snapshot?.data?.bodyShape == item ? Theme.of(context).accentColor : Colors.grey[400]),
                  );
                }).toList());
              },
            ),
          ),
          SizedBox(height: 50),
          Container(alignment: Alignment.centerLeft, child: Text("¿Cual es tu altura?")),
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
                  decoration: InputDecoration(labelText: "Centimetros", hintText: "123"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
