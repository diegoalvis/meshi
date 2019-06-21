/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/custom_widgets/option_selector.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

class SettingsPage extends StatelessWidget with HomeSection {
  @override
  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text(strings.homeSections[4]);
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(strings.notifications,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.left),
            ),
          ),
          rowSettings(context, strings.newMessage, true),
          rowSettings(context, strings.newInterested, true),
          rowSettings(context, strings.newDraw, false),
          rowSettings(context, strings.awards, true),
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          settingItem(context, CONTACT_ROUTE, strings.contactUs),
          settingItem(context, TERM_AND_CONDITIONS, strings.termsAndConditions),
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
                child: Text(strings.signOut,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
          )
        ],
      ),
    );
  }

  void deactivateAccount(BuildContext context) async {
    final userRepository = InjectorWidget.of(context).get<UserRepository>();
    await userRepository.deactivateAccount();
    clearSession(context);
  }

  void clearSession(BuildContext context) async {
    final session = InjectorWidget.of(context).get<SessionManager>();
    session.clear();
    session.setLogged(false);
    Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (Route<dynamic> route) => false);
  }

  Widget rowSettings(BuildContext context, String rowName, bool notification) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(rowName, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
          ),
          //Spacer(),
          Expanded(
            child: OptionSelector(
                options: YesNoOptions,
                optionSelected: (notification == null ? null : notification == true ? YesNoOptions[0] : YesNoOptions[1]),
                onSelected: (selected) => null),
          ),
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
              Navigator.pushNamed(context, route);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 6.0, bottom: 6.0),
              child:
                  Text(itemName, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
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
