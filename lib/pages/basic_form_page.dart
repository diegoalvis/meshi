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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    /** Section 1 **/
    Widget _buildPageOne = Column(
      children: [],
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
        title: Text(
          "Cuestionario",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        elevation: 0,
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
