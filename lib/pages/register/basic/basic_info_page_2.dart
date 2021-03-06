/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/form_section.dart';
import 'package:meshi/pages/register/basic/basic_info_container_page.dart';
import 'package:meshi/utils/custom_widgets/gender_selector.dart';
import 'package:meshi/utils/gender.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageTwo extends StatelessWidget with FormSection {
  bool infoComplete;
  final _focusEmail = FocusNode();
  final _focusName = FocusNode();
  final _focusDate = FocusNode();

  @override
  bool isInfoComplete() => infoComplete;

  formatDate(DateTime date) {
    if (date == null) return "";
    return "${date?.day}/${date?.month}/${date?.year}";
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = BasicInfoBlocProvider.of(context).bloc;
    return StreamBuilder<User>(
        stream: bloc.userStream,
        initialData: bloc.session.user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          TextEditingController emailController = TextEditingController();
          emailController.text = snapshot.data?.email ?? "";
          emailController.addListener(() => bloc.email = emailController.text);

          TextEditingController nameController = TextEditingController();
          nameController.text = snapshot.data?.name ?? "";
          nameController.addListener(() => bloc.name = nameController.text);

          infoComplete = emailController.text.trim().length > 0 &&
              nameController.text.trim().length > 0 &&
              snapshot.data?.birthdate != null &&
              snapshot.data?.gender != null &&
              snapshot.data?.likeGender != null &&
              snapshot.data.likeGender.length > 0;

          return ListView(
            children: [
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: strings.name),
                focusNode: _focusName,
                onEditingComplete: () {
                  _focusName.unfocus();
                  FocusScope.of(context).requestFocus(_focusEmail);
                },
              ),
              SizedBox(height: 18),
              TextField(
                controller: emailController,
                focusNode: _focusEmail,
                decoration: InputDecoration(labelText: strings.email, hintText: "usuario@example.com"),
                onEditingComplete: () {
                  _focusEmail.unfocus();
                  FocusScope.of(context).requestFocus(_focusDate);
                },
              ),
              SizedBox(height: 18),
              GestureDetector(
                onTap: () => showDatePicker(
                        context: context,
                        initialDate: snapshot.data?.birthdate ?? DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now())
                    .then<DateTime>((DateTime pickedDate) => bloc.birthDate = pickedDate ?? snapshot.data.birthdate),
                child: Container(
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: TextField(
                      focusNode: _focusDate,
                      controller: TextEditingController(text: formatDate(snapshot.data?.birthdate)),
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
              Row(
                children: [
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Text(strings.self,
                          textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor)),
                      Text(setGenderLabel(snapshot), style: TextStyle(color: Theme.of(context).primaryColor))
                    ],
                  )),
                  Expanded(
                    flex: 2,
                    child: GenderSelector(
                        data: [snapshot.data?.gender].toSet(),
                        onGenderSelected: (gender) {
                          bloc.userGender = gender;
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          strings.interested,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Text(setLikeGenderLabel(snapshot), style: TextStyle(color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GenderSelector(
                        data: snapshot.data?.likeGender?.toSet(),
                        onGenderSelected: (gender) {
                          if (snapshot.data?.likeGender?.contains(gender) == true) {
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

  String setLikeGenderLabel(AsyncSnapshot<User> snapshot) {
    if (snapshot.data?.likeGender == null || snapshot.data?.likeGender?.length == 0) {
      return "";
    }
    if (snapshot.data.likeGender.contains(Gender.male.name) && snapshot.data.likeGender.contains(Gender.female.name))
      return "Hombres\n\  Mujeres";
    if (snapshot.data.likeGender.contains(Gender.female.name)) {
      return "Mujeres";
    }
    if (snapshot.data.likeGender.contains(Gender.male.name)) {
      return "Hombres";
    }
    return "";
  }

  String setGenderLabel(AsyncSnapshot<User> snapshot) {
    if (snapshot.data?.gender.toString() == Gender.male.name) {
      return "Hombre";
    }
    if (snapshot.data?.gender.toString() == Gender.female.name) {
      return "Mujer";
    }
    return "";
  }
}
