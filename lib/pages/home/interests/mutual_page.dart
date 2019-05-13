/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/utils/localiztions.dart';

import 'interests_main_page.dart';

class MutualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = InterestsBlocProvider.of(context).bloc;
    return ListView.separated(
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 20),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: Row(children: [
              ClipOval(
                child: Container(
                    height: 50.0,
                    width: 50.0,
                    child: Image.network(
                        "https://image.shutterstock.com/image-photo/brunette-girl-long-shiny-wavy-260nw-639921919.jpg",
                        fit: BoxFit.cover)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text("Nombre")),
                    Row(children: [
                      Text("7:00 pm", style: TextStyle(color: Theme.of(context).accentColor)),
                      SizedBox(width: 10),
                      Expanded(child: Text("Ultimo mensajesad", overflow: TextOverflow.ellipsis)),
                    ])
                  ],
                ),
              )
            ]),
          );
        });
  }
}
