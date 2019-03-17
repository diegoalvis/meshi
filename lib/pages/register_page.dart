import 'package:flutter/material.dart';
import 'package:meshi/blocs/login_bloc.dart';
import 'package:meshi/main.dart';
import 'package:meshi/utils/localiztions.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    Widget _buildPageOne = Column(
      children: [
        Expanded(
          child: Text(
            "Selecciona las fotos...",
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(alignment: Alignment.bottomCenter, child: Text("Fotos aqui")),
        ),
      ],
    );

    Widget _buildBottomButtons = new Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              child: Text(
                'Atras',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            "1 de 3",
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              child: Text(
                'Siguiente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Como Eres?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 45,
                    fontFamily: 'BettyLavea',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: _buildPageOne,
            ),
            _buildBottomButtons,
          ],
        ),
      ),
    );
  }
}
