import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:meshi/pages/welcome_page.dart';
import 'package:meshi/utils/gender.dart';
import 'package:meshi/utils/localiztions.dart';

class BasicFormPage extends StatefulWidget {
  @override
  _BasicFormPageState createState() => _BasicFormPageState();
}

class _BasicFormPageState extends State<BasicFormPage> {
  int currentPage = 1;
  int educationalLevelSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    List<String> educationalLevels = ["Bachiller", "Tecnico", "Tecnologo", "Profesional", "Posrado"];

    /** Section 1 **/
    Widget _buildPageOne = Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(strings.educationalLevelCaption, textAlign: TextAlign.center),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Container(
            child: ListView.separated(
              itemCount: educationalLevels.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    educationalLevels[index] != null ? educationalLevels[index] : '',
                    style: TextStyle(
                        color: (educationalLevelSelected == index
                            ? Theme.of(context).accentColor
                            : Colors.black)),
                  ),
                  onTap: () => setState(() {
                        educationalLevelSelected = index;
                      }),
                );
              },
            ),
          ),
        ),
      ],
    );

    /** Navigation buttons **/
    Widget _buildBottomButtons = Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => setState(() {
                    currentPage--;
                    if (currentPage < 1) currentPage = 1;
                  }),
              child: Text(
                (currentPage == 1 ? '' : strings.back).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
          child: Text("$currentPage ${strings.ofLabel} 3", textAlign: TextAlign.center),
        )),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => setState(() {
                    currentPage++;
                    if (currentPage > 3) {
                      currentPage = 3;
                    }
                  }),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              color: currentPage == 4 ? Theme.of(context).accentColor : Colors.transparent,
              child: Text(
                (currentPage == 3 ? strings.finish : strings.next).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    Widget _buildPage() {
      switch (currentPage) {
        case 1:
          return _buildPageOne;
        default:
          return _buildPageOne;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                "res/icons/logo.png",
                scale: 4,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
        title: Text(
          "Cuestionario",
          textAlign: TextAlign.start,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: _buildPage(),
            ),
            SizedBox(height: 20),
            _buildBottomButtons,
          ],
        ),
      ),
    );
  }
}
