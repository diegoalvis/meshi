/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
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

class SettingsPage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override
  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text(strings.homeSections[4]);
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final SessionManager sessionManager = InjectorWidget.of(context).get();
    return SettingsContainer(sessionManager);
  }
}

class SettingsContainer extends StatefulWidget {
  final SessionManager sessionManager;

  SettingsContainer(this.sessionManager);

  @override
  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text(strings.homeSections[4]);
  }

  @override
  State<StatefulWidget> createState() => SettingsPageState(sessionManager);
}

class SettingsPageState extends State<SettingsContainer> {
  final SessionManager sessionManager;
  bool sessionMessage;
  bool sessionInterest;
  bool sessionReward;

  SettingsPageState(this.sessionManager) {
    setNotificationPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(strings.notifications,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.left),
            ),
          ),
          rowSettings(context, strings.newMessage, sessionMessage, "messageNotification"),
          rowSettings(context, strings.newInterested, sessionInterest, "interestsNotification"),
          rowSettings(context, strings.newDraw, sessionReward, "rewardNotification"),
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
    sessionManager.clear();
    sessionManager.setLogged(false);
    Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (Route<dynamic> route) => false);
  }

  Widget rowSettings(BuildContext context, String rowName, bool notificationType, String key) {
    setNotificationPreferences();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child:
                Text(rowName, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
          ),
          //Spacer(),
          Expanded(
            child: OptionSelector(
                options: YesNoOptions,
                optionSelected:
                    (notificationType == null ? null : notificationType == true ? YesNoOptions[0] : YesNoOptions[1]),
                onSelected: (selected) {
                  final enable = selected == "yes";
                  notificationType = enable;
                  sessionManager.setSettingsNotification(enable, key);
                }),
          ),
        ],
      ),
    );
  }

  void setNotificationPreferences() {
    sessionManager.getSettingsNotification("messageNotification").then((value) => setState(() => sessionMessage = value));
    sessionManager.getSettingsNotification("interestsNotification").then((value) => setState(() => sessionInterest = value));
    sessionManager.getSettingsNotification("rewardNotification").then((value) => setState(() => sessionReward = value));
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
              child: Text(itemName,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
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
