/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/data/models/my_likes.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/pages/home/home_section.dart';
import 'package:meshi/pages/home/profile/profile_bloc.dart';
import 'package:meshi/pages/register/advance/advanced_register_container_page.dart';
import 'package:meshi/pages/register/basic/basic_info_container_page.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/date_utils.dart';
import 'package:meshi/utils/localiztions.dart';

class ProfilePage extends StatelessWidget with HomeSection, InjectorWidgetMixin {
  @override
  Widget getTitle(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Text(strings.aboutMe);
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final strings = MyLocalizations.of(context);
    final bloc = ProfileBloc(injector.get<UserRepository>(), injector.get<SessionManager>());
    return StreamBuilder<bool>(
        stream: bloc.progressSubject.stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? Center(child: CircularProgressIndicator())
              : StreamBuilder<User>(
                  stream: bloc.userStream,
                  initialData: bloc.session.user,
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.data?.images != null) {
                      List.generate(4 - (snapshot.data?.images?.length ?? 0), (index) => null)
                          .forEach((item) => snapshot.data?.images?.add(item));
                    }
                    return ListView(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0, top: 8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${(snapshot.data?.name ?? "")}",
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                ImageSelector(snapshot.data?.images?.elementAt(0) ?? null,
                                    (image) => bloc.addImage(image, 0), (image) => bloc.deleteImage(image, 0)),
                                SizedBox(width: 12),
                                ImageSelector(snapshot.data?.images?.elementAt(1) ?? null,
                                    (image) => bloc.addImage(image, 1), (image) => bloc.deleteImage(image, 0)),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                ImageSelector(snapshot.data?.images?.elementAt(2) ?? null,
                                    (image) => bloc.addImage(image, 2), (image) => bloc.deleteImage(image, 0)),
                                SizedBox(width: 12),
                                ImageSelector(snapshot.data?.images?.elementAt(3) ?? null,
                                    (image) => bloc.addImage(image, 3), (image) => bloc.deleteImage(image, 0)),
                              ],
                            ),
                            buildPremiumSection(context, snapshot?.data),
                            buildProfileDetails(context, snapshot?.data),
                            buildCompleteProfileBanner(context),
                          ],
                        ),
                      ),
                    ]);
                  });
        });
  }

  Widget buildCompleteProfileBanner(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Column(
      children: [
        Divider(height: 50.0, color: Colors.grey),
        Text(
          strings.completeYourProfile,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.0),
        FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdvancedRegisterContainerPage(doWhenFinish: BaseBloc.ACTION_POP_PAGE)));
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            color: Theme.of(context).accentColor,
            child: Text(strings.completeProfileButton)),
      ],
    );
  }

  Widget buildPremiumSection(BuildContext context, User user) {
    final subscriptionTime = user?.planStartDate?.difference(user?.planEndDate);
    final subscriptionDaysLeft = subscriptionTime?.inDays;
    final strings = MyLocalizations.of(context);

    final isPremium = user?.type == TYPE_PREMIUM;
    return isPremium
        ? Column(
            children: <Widget>[
              Divider(height: 50.0, color: Colors.grey),
              Row(
                children: <Widget>[
                  Spacer(),
                  Icon(
                    AppIcons.crown,
                    color: Theme.of(context).primaryColorLight,
                    size: 18,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    strings.youArePremium,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 8.0),
              subscriptionDaysLeft != null
                  ? Text(
                      'Te quedan $subscriptionDaysLeft días de suscripción Premium',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 10),
                    )
                  : SizedBox(),
            ],
          )
        : SizedBox();
  }

  Widget buildProfileDetails(BuildContext context, User user) {
    final strings = MyLocalizations.of(context);
    return Column(
      children: [
        Divider(height: 50.0, color: Colors.grey),
        Align(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => BasicInfoContainerPage(doWhenFinish: BaseBloc.ACTION_POP_PAGE))),
            child: Text(strings.editButton, style: TextStyle(color: Theme.of(context).accentColor)),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            strings.howDescribeYourself,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.0),
        Text(user?.description ?? "",
            textAlign: TextAlign.left),
        SizedBox(height: 30.0),
//        Align(
//          alignment: Alignment.centerLeft,
//          child: Text(
//            strings.hobbiesCaption,
//            textAlign: TextAlign.left,
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//        ),
        SizedBox(height: 8.0),
        Text(user?.freeTime ?? "",
            textAlign: TextAlign.left),
        SizedBox(height: 16.0),
      ],
    );
  }
}
