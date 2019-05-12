/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/bloc/register_bloc.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/base/form_section.dart';
import 'package:meshi/pages/register/basic_info_page_1.dart';
import 'package:meshi/pages/register/basic_info_page_2.dart';
import 'package:meshi/pages/register/basic_info_page_3.dart';
import 'package:meshi/utils/localiztions.dart';

class RegisterPage extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final bloc = RegisterBloc(injector.get<UserRepository>(), injector.get<SessionManager>());
    return RegisterContainer(bloc: bloc);
  }
}

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
class RegisterContainer extends StatefulWidget {
  final RegisterBloc bloc;

  const RegisterContainer({Key key, this.bloc}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(bloc);
}

class _RegisterPageState extends State<RegisterContainer> {
  final RegisterBloc _bloc;
  FormSection currentPage;
  List<FormSection> pages;
  BuildContext buildContext;

  _RegisterPageState(this._bloc);

  @override
  void initState() {
    super.initState();
    setState(() {
      pages = [BasicInfoPageOne(), BasicInfoPageTwo(), BasicInfoPageThree()];
      currentPage = pages[0];
    });
    _bloc.loadFacebookProfile();
    _bloc.errorSubject.listen((message) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(message))));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
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
              _buildBottomButtons(strings),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigation buttons
  Widget _buildBottomButtons(MyLocalizations strings) {
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
          child: Text("$currentPageIndex ${strings.ofLabel} ${pages.length}", textAlign: TextAlign.center),
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
                      : Builder(
                          builder: (contextInt) => FlatButton(
                                onPressed: () => !currentPage.isInfoComplete()
                                    ? Scaffold.of(contextInt).showSnackBar(SnackBar(content: Text("Informacion incompleta")))
                                    : setState(() {
                                        currentPageIndex++;
                                        if (currentPageIndex > pages.length) {
                                          currentPageIndex = pages.length;
                                          _bloc.updateUseInfo().listen((success) {
                                            if (success) {
                                              Navigator.of(this.context).pushReplacementNamed(WELCOME_ROUTE);
                                            }
                                          }, onError: (error) => _bloc.errorSubject.sink.add(error.toString()));
                                        }
                                        currentPage = pages[currentPageIndex - 1];
                                      }),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                color: currentPageIndex == 4 ? Theme.of(context).accentColor : Colors.transparent,
                                child: Text(
                                  (currentPageIndex == pages.length ? strings.finish : strings.next).toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ));
                }),
          ),
        ),
      ],
    );
  }
}
