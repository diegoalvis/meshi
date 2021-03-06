/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/main.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/pages/register/form_section.dart';
import 'package:meshi/pages/register/basic/basic_info_page_1.dart';
import 'package:meshi/pages/register/basic/basic_info_page_2.dart';
import 'package:meshi/pages/register/basic/basic_info_page_3.dart';
import 'package:meshi/pages/register/basic/basic_info_bloc.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

class BasicInfoContainerPage extends StatelessWidget with InjectorWidgetMixin {
  final doWhenFinish;

  const BasicInfoContainerPage({Key key, this.doWhenFinish}) : super(key: key);

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final bloc = BasicInfoBloc(injector.get(), injector.get(), injector.get(), doWhenFinish);
    return RegisterContainer(bloc: bloc);
  }
}

class BasicInfoBlocProvider extends InheritedWidget {
  final BasicInfoBloc bloc;
  final Widget child;

  BasicInfoBlocProvider({Key key, @required this.bloc, this.child}) : super(key: key, child: child);

  static BasicInfoBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: BasicInfoBlocProvider);
  }

  @override
  bool updateShouldNotify(BasicInfoBlocProvider oldWidget) => true;
}

// Widget
class RegisterContainer extends StatefulWidget {
  final BasicInfoBloc bloc;

  const RegisterContainer({Key key, this.bloc}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(bloc);
}

class _RegisterPageState extends State<RegisterContainer> {
  final BasicInfoBloc _bloc;
  FormSection currentPage;
  List<FormSection> pages;
  BuildContext buildContext;

  _RegisterPageState(this._bloc);

  @override
  void didUpdateWidget(RegisterContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

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
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: BasicInfoBlocProvider(
          bloc: _bloc,
          child: Column(
            children: [
              Expanded(
                flex: pages.indexOf(currentPage) != (pages.length + 1) ? 2 : 0,
                child: Container(
                  alignment: Alignment.center,
                  child: pages.indexOf(currentPage) != (pages.length + 1)
                      ? Text(
                          "Informaci\ón personal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 31,
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
              _buildBottomButtons(strings, context),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigation buttons
  Widget _buildBottomButtons(MyLocalizations strings, BuildContext context) {
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
                                    ? Scaffold.of(contextInt).showSnackBar(SnackBar(
                                        content: Text(currentPage.requiredOptions() == 0
                                            ? strings.incompleteInformation
                                            : strings.getIncompleteFormErrorMessage(currentPage.requiredOptions()))))
                                    : setState(() {
                                        currentPageIndex++;
                                        if (currentPageIndex > pages.length) {
                                          currentPageIndex = pages.length;
                                          _bloc.updateUseInfo().listen((doWhenFinish) {
                                            if (doWhenFinish == BaseBloc.ACTION_POP_PAGE) {
                                              Navigator.of(this.context).pop();
                                            } else {
                                              Navigator.of(this.context).pushReplacementNamed(WELCOME_ROUTE);
                                            }
                                          }, onError: (error) {
                                            onWidgetDidBuild(() {
                                              Scaffold.of(this.context).showSnackBar(SnackBar(content: Text(error)));
                                            });
                                          });
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
