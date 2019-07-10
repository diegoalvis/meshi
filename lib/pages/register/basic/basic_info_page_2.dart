/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/data/models/user.dart';
import 'package:meshi/pages/register/advance/form_section.dart';
import 'package:meshi/pages/register/basic/basic_register_page.dart';
import 'package:meshi/utils/custom_widgets/gender_selector.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicInfoPageTwo extends StatelessWidget with FormSection {
  bool infoComplete;
  final _focusEmail = FocusNode();
  final _focusName = FocusNode();
  final _focusDate = FocusNode();
  bool showLikeGenderText = false;
  bool showGenderText = false;

  @override
  bool isInfoComplete() => infoComplete;

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
                    .then<DateTime>(
                        (DateTime pickedDate) => bloc.birthDate = pickedDate ?? snapshot.data.birthdate),
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
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Theme.of(context).primaryColor)),
                          showGenderText ?
                          Text(snapshot.data?.gender.toString() == "male" ? "Hombre" : "Mujer",
                              style: TextStyle(color: Theme.of(context).primaryColor))
                              : SizedBox()
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: GenderSelector(
                      data: [snapshot.data?.gender].toSet(),
                      onGenderSelected: (gender) {
                        showGenderText = true;
                        bloc.userGender = gender;
                      }
                    ),
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
                        showLikeGenderText ?
                        Text(
                          (snapshot.data.likeGender.contains("male") && snapshot.data.likeGender.contains("female")) ? "Hombres\n\Mujeres" : snapshot.data.likeGender.contains("female") ? "Mujeres" : snapshot.data.likeGender.contains("male")  ? "Hombres" : "" ,
                          style: TextStyle(color: Theme.of(context).primaryColor))
                            : SizedBox()
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GenderSelector(
                        data: snapshot.data?.likeGender?.toSet(),
                        onGenderSelected: (gender) {
                          showLikeGenderText = true;
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
}
