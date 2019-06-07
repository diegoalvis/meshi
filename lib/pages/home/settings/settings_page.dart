/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/main.dart';
import 'package:meshi/utils/widget_util.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';

class SettingsPage extends StatelessWidget with HomeSection {
  SessionManager session;

  @override
  Widget get title => Text('Información sobre mi');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: Theme.of(context).dividerColor,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Notificaciones',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.left),
          ),
        ),
        rowSettings(context, 'Nuevo mensaje', true),
        rowSettings(context, 'Nuevo interesad@', true),
        rowSettings(context, 'Nuevo sorteo', false),
        rowSettings(context, 'Premiación', true),
        Divider(
          color: Theme.of(context).dividerColor,
        ),
        settingItem(context, 'Contactanos', 'Contáctanos'),
        settingItem(context, 'Términos y condiciones', 'Términos y condiciones'),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              onWidgetDidBuild(() {
                clearSession(context);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
              child: Text('Cerrar sesión',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }

  void clearSession(BuildContext context) async {
    session = InjectorWidget.of(context).get<SessionManager>();
    session.clear();
    session.setLogged(false);
    Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (Route<dynamic> route) => false);
  }

  Widget rowSettings(BuildContext context, String rowName, bool notification) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Text(rowName,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
          Spacer(),
          OptionSelector(
              options: YesNoOptions,
              optionSelected: (notification == null
                  ? null
                  : notification == true ? YesNoOptions[0] : YesNoOptions[1]),
              onSelected: (selected) => null),
        ],
      ),
    );
  }

  Widget settingItem(BuildContext context, String route, String itemName) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              //Navigator.pushReplacementNamed(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 6.0, bottom: 6.0),
              child: Text(itemName,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }
}
