/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';

class ListPremium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO construir aqui la vista
    return Column(

      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xff6FCF97),
            child: Text("1"),
          ),
          title: Text('Un Mes'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xffc4c4c4),
            child: Text("6"),
          ),
          title: Text('Seis Meses'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xffc4c4c4),
            child: Text("12"),
          ),
          title: Text('Un Año'),
        ),
      ],
    );
  }
}
