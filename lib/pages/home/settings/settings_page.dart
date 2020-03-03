/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_version/get_version.dart';
import 'package:meshi/data/models/user_preferences.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/notification_manager.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/settings/settings_bloc.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/base_state.dart';
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
    return SettingsContainer(SettingsBloc(injector.get(), injector.get(), injector.get()));
  }
}

class SettingsContainer extends StatefulWidget {
  final SettingsBloc _bloc;

  SettingsContainer(this._bloc);

  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text(strings.homeSections[4]);
  }

  @override
  State<StatefulWidget> createState() => SettingsPageState(_bloc);
}

class SettingsPageState extends State<SettingsContainer> {
  final SettingsBloc _bloc;
  UserPreferences userPreferences;

  String _appVersionName = "";

  SettingsPageState(this._bloc);

  @override
  void initState() {
    GetVersion.projectVersion.then((versionName) {
      setState(() => _appVersionName = versionName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(SettingsEvent(SettingsEventType.getUserPreferences));
          }

          if (state is SuccessState<UserPreferences>) {
            userPreferences = state.data;
          }

          return userPreferences == null
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(strings.newMessage,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
                          ),
                          //Spacer(),
                          Expanded(
                            child: OptionSelector(
                                options: YesNoOptions,
                                optionSelected: userPreferences.chat ? YesNoOptions[0] : YesNoOptions[1],
                                onSelected: (selected) {
                                  final enable = selected == "yes";
                                  userPreferences.chat = enable;
                                  _bloc.dispatch(SettingsEvent(SettingsEventType.updateUserPreferences, data: userPreferences));
                                }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(strings.newInterested,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
                          ),
                          //Spacer(),
                          Expanded(
                            child: OptionSelector(
                                options: YesNoOptions,
                                optionSelected: userPreferences.match ? YesNoOptions[0] : YesNoOptions[1],
                                onSelected: (selected) {
                                  final enable = selected == "yes";
                                  userPreferences.match = enable;
                                  _bloc.dispatch(SettingsEvent(SettingsEventType.updateUserPreferences, data: userPreferences));
                                }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(strings.newDraw,
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
                          ),
                          //Spacer(),
                          Expanded(
                            child: OptionSelector(
                                options: YesNoOptions,
                                optionSelected: userPreferences.reward ? YesNoOptions[0] : YesNoOptions[1],
                                onSelected: (selected) {
                                  final enable = selected == "yes";
                                  userPreferences.reward = enable;
                                  _bloc.dispatch(SettingsEvent(SettingsEventType.updateUserPreferences, data: userPreferences));
                                  if (enable) {
                                    _bloc.notificationManager.subscribeToTopic(TOPIC_REWARD);
                                  } else {
                                    _bloc.notificationManager.unsubscribeFromTopic(TOPIC_REWARD);
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    settingItem(context, CONTACT_ROUTE, strings.contactUs),
                    settingItem(context, TERM_AND_CONDITIONS, strings.termsAndConditions),
                    InkWell(
                      onTap: () {
                        onWidgetDidBuild(() {
                          deactivateAccount(context);
                        });
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                          child: Text(strings.deactivateAccount,
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
                        ),
                      ),
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    InkWell(
                      onTap: () {
                        onWidgetDidBuild(() {
                          clearSession(context);
                        });
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 6.0),
                          child: Text(strings.signOut,
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.normal)),
                        ),
                      ),
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    Spacer(),
                    Center(child: Text("v$_appVersionName", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)))
                  ],
                );
        });
  }

  void deactivateAccount(BuildContext context) async {
    final strings = MyLocalizations.of(context);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(strings.confirmDeactivateAccount),
              actions: <Widget>[
                FlatButton(
                  child: Text(strings.deactivateText),
                  onPressed: () {
                    final userRepository = InjectorWidget.of(context).get<UserRepository>();
                    userRepository.deactivateAccount();
                    clearSession(context);
                  },
                ),
                FlatButton(
                  child: Text(strings.cancelButtonMay),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ));
  }

  void clearSession(BuildContext context) async {
    await _bloc.closeSession();
    Future.delayed(Duration(milliseconds: 500),
        () => Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (Route<dynamic> route) => false));
  }

  Widget settingItem(BuildContext context, String route, String itemName) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Align(
            alignment: Alignment.centerLeft,
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
