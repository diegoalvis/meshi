/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/register/register_page.dart';
import 'package:meshi/pages/register/register_section.dart';
import 'package:meshi/utils/custom_widgets/gender_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageTwo extends StatelessWidget with RegisterSection {
  @override
  bool isInfoComplete() {
    return true;
  }

  formatDate(DateTime date) {
    DateTime currentDate = DateTime.now();
    return "${date?.day ?? currentDate.day}/${date?.month ?? currentDate.month}/${date?.year ?? currentDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = RegisterBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return ListView(
            children: [
              Text(
                strings.tellUsAboutYou,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                initialValue: snapshot.data?.email ?? "",
                decoration: InputDecoration(labelText: strings.email, hintText: "usuario@example.com"),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () => showDatePicker(
                        context: context,
                        initialDate: snapshot.data?.birthDate ?? DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now())
                    .then<DateTime>(
                        (DateTime pickedDate) => bloc.birthday = pickedDate ?? snapshot.data.birthDate),
                child: Container(
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: TextEditingController(text: formatDate(snapshot.data?.birthDate)),
                      decoration: InputDecoration(
                        labelText: strings.birthDate,
                        hintText: "dd/mm/aa",
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                      child: Text(strings.self,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).primaryColor))),
                  Expanded(
                    flex: 2,
                    child: GenderSelector(
                      data: [snapshot.data?.gender]?.toSet(),
                      onGenderSelected: (gender) => bloc.userGender = gender,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      strings.interested,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GenderSelector(
                        data: snapshot.data?.likeGenders,
                        onGenderSelected: (gender) {
                          if (snapshot.data?.likeGenders?.contains(gender) == true) {
                            bloc.removeGender(gender);
                          } else {
                            bloc.addGender(gender);
                          }
                        }),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
