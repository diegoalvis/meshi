/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/main.dart';

class ListPremium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO construir aqui la vista
    final strings = MyLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(

          border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,  //pense que con esto reconoceria un limite inferior
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xff6FCF97),
              child: Text("1"),
            ),
            title: Text('Un Mes'),
            trailing: Text("9.000"),
            selected: true,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffc4c4c4),
              child: Text("6"),
            ),
            title: Text('Seis Meses'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("48.000"),
                Text(
                  "Ahorra 6.000",
                  style: TextStyle(color: Color(0xff6E6E6E), fontSize: 11),
                )
              ],
            ),
            selected: true,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffc4c4c4),
              child: Text("12"),
            ),
            title: Text('Un Año'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("84.000"),
                Text(
                  "Ahorra 24.000",
                  style: TextStyle(color: Color(0xff6E6E6E), fontSize: 11),
                )
              ],
            ),
            selected: true,
          ),
         SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,    //creo que no lo reconoce porque no tiene un limite inferior
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: (null),
                    child: Text(
                      "PROBAR MES GRATIS",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: FlatButton(

                    onPressed: (){} ,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    color: Theme.of(context).accentColor,   //no se como me reconoce el color
                    child: Text(

                      "CONTINUAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox())
        ],
      ),
    );
  }
}
