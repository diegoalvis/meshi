/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:meshi/blocs/register_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/register/basic_info_page_1.dart';
import 'package:meshi/pages/register/basic_info_page_2.dart';
import 'package:meshi/pages/register/basic_info_page_3.dart';
import 'package:meshi/pages/register/register_section.dart';
import 'package:meshi/pages/register/welcome_page.dart';
import 'package:meshi/utils/localiztions.dart';

class RegisterBlocProvider extends InheritedWidget {
  final RegisterBloc bloc;
  final Widget child;

  RegisterBlocProvider({Key key, @required this.bloc, this.child}) : super(key: key, child: child);

  static RegisterBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(RegisterBlocProvider) as RegisterBlocProvider);
  }

  @override
  bool updateShouldNotify(RegisterBlocProvider oldWidget) => true;
}

// Widget
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState(RegisterBloc());
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _bloc;
  RegisterSection currentPage;
  List<RegisterSection> pages = [BasicInfoPageOne(), BasicInfoPageTwo(), BasicInfoPageThree()];

  _RegisterPageState(this._bloc);

  @override
  void initState() {
    super.initState();
    setState(() => currentPage = pages[0]);
    _bloc.loadFacebookProfile();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    /** Navigation buttons **/
    Widget _buildBottomButtons() {
      int currentPageIndex = pages.indexOf(currentPage) + 1;
      return Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () => setState(() {
                      currentPageIndex--;
                      if (currentPageIndex < 1) currentPageIndex = 1;
                      currentPage = pages[currentPageIndex - 1];
                    }),
                child: Text(
                  (currentPageIndex == 1 ? '' : strings.back).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Text("$currentPageIndex ${strings.ofLabel} ${pages.length}",
                textAlign: TextAlign.center),
          )),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: StreamBuilder<bool>(
                  stream: _bloc.progressSubject.stream,
                  initialData: false,
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return snapshot.data
                        ? CircularProgressIndicator()
                        : FlatButton(
                            onPressed: () => !currentPage.isInfoComplete()
                                ? null
                                : setState(() {
                                    currentPageIndex++;
                                    if (currentPageIndex > pages.length) {
                                      currentPageIndex = pages.length;
                                      _bloc.updateUseInfo().listen((response) {
                                        if (response.success) {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => WelcomePage()));
                                        } else {
                                          // TODO mostrar mensaje error Snackbar
                                        }
                                      });
                                    }
                                    currentPage = pages[currentPageIndex - 1];
                                  }),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            color: currentPageIndex == 4
                                ? Theme.of(context).accentColor
                                : Colors.transparent,
                            child: Text(
                              (currentPageIndex == pages.length ? strings.finish : strings.next)
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: !currentPage.isInfoComplete()
                                    ? Colors.grey
                                    : Theme.of(context).accentColor,
                              ),
                            ),
                          );
                  }),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: RegisterBlocProvider(
          bloc: _bloc,
          child: Column(
            children: [
              Expanded(
                flex: pages.indexOf(currentPage) != (pages.length + 1) ? 2 : 0,
                child: Container(
                  alignment: Alignment.center,
                  child: pages.indexOf(currentPage) != (pages.length + 1)
                      ? Text(
                          strings.asYouAre,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 34,
                            fontFamily: 'BettyLavea',
                          ),
                        )
                      : null,
                ),
              ),
              Expanded(
                flex: 7,
                child: currentPage as Widget,
              ),
              SizedBox(height: 20),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
