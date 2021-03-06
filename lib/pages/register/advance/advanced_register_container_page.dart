/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meshi/data/repository/user_repository.dart';
import 'package:meshi/main.dart';
import 'package:meshi/managers/session_manager.dart';
import 'package:meshi/pages/bloc/base_bloc.dart';
import 'package:meshi/pages/register/advance/form_bloc.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_1.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_2.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_3.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_4.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_5.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_6.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_7.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_8.dart';
import 'package:meshi/pages/register/advance/specifics/specific_page_9.dart';
import 'package:meshi/utils/FormUtils.dart';
import 'package:meshi/utils/app_icons.dart';
import 'package:meshi/utils/custom_widgets/page_selector.dart';
import 'package:meshi/utils/custom_widgets/section_indicator.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:meshi/utils/widget_util.dart';

import 'basic/basic_page_1.dart';
import 'basic/basic_page_2.dart';
import 'basic/basic_page_3.dart';
import 'basic/basic_page_4.dart';
import '../form_section.dart';
import 'habits/habits_page_1.dart';
import 'habits/habits_page_2.dart';

class AdvancedRegisterContainerPage extends StatelessWidget with InjectorWidgetMixin {
  final doWhenFinish;

  const AdvancedRegisterContainerPage({Key key, this.doWhenFinish}) : super(key: key);

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final bloc = FormBloc(injector.get(), injector.get(), injector.get(), doWhenFinish);
    return FormContainer(bloc);
  }
}

class FormBlocProvider extends InheritedWidget {
  final FormBloc bloc;
  final Widget child;

  FormBlocProvider({Key key, @required this.bloc, this.child}) : super(key: key, child: child);

  static FormBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(FormBlocProvider) as FormBlocProvider);
  }

  @override
  bool updateShouldNotify(FormBlocProvider oldWidget) => true;
}

// Widget
class FormContainer extends StatefulWidget {
  final FormBloc bloc;

  const FormContainer(this.bloc) : super();

  @override
  _FormPageState createState() => _FormPageState(bloc);
}

class _FormPageState extends State<FormContainer> {
  final FormBloc _bloc;
  static const TOTAL_PAGES = 15;

  int currentPagePos = 1;
  List<Widget> pages = [
    BasicFormPageOne(), // 1
    BasicFormPageTwo(), // 2
    BasicFormPageThree(), // 3
    BasicFormPageFour(), // 4
    HabitsFormPageOne(), // 5
    HabitsFormPageTwo(), // 6
    SpecificsFormPageOne(), // 7
    SpecificsFormPageTwo(), // 8
    SpecificsFormPageThree(), // 9
    SpecificsFormPageFour(), // 10
    SpecificsFormPageFive(), // 11
    SpecificsFormPageSix(), // 12
    SpecificsFormPageSeven(), // 13
    SpecificsFormPageEight(), // 14
    SpecificsFormPageNine(), // 15
  ];

  _FormPageState(this._bloc);

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.errorSubject.listen((message) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(message))));
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    /** Navigation buttons **/
    Widget _buildBottomButtons = Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => setState(() {
                currentPagePos--;
                if (currentPagePos < 1) currentPagePos = 1;
              }),
              child: Text(
                (currentPagePos == 1 ? '' : strings.back).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
          child: Text("$currentPagePos ${strings.ofLabel} $TOTAL_PAGES", textAlign: TextAlign.center),
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
                          onPressed: () => !(pages.elementAt(currentPagePos - 1) as FormSection).isInfoComplete()
                              ? Scaffold.of(contextInt).showSnackBar(SnackBar(
                                  content: Text((pages.elementAt(currentPagePos - 1) as FormSection).requiredOptions() == 0
                                      ? strings.incompleteInformation
                                      : strings.getIncompleteFormErrorMessage(
                                          (pages.elementAt(currentPagePos - 1) as FormSection).requiredOptions()))))
                              : setState(() {
                                  currentPagePos++;
                                  if (currentPagePos > TOTAL_PAGES) {
                                    currentPagePos = TOTAL_PAGES;
                                    _bloc.updateUserInfo().listen((doWhenFinish) {
                                      if (doWhenFinish == BaseBloc.ACTION_POP_PAGE) {
                                        Navigator.of(this.context).pop();
                                      } else {
                                        Navigator.of(this.context).pushReplacementNamed(HOME_ROUTE);
                                      }
                                    }, onError: (error) {
                                      onWidgetDidBuild(() {
                                        Scaffold.of(this.context).showSnackBar(SnackBar(content: Text(strings.tryError)));
                                      });
                                    });
                                  }
                                }),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          color: Theme.of(context).accentColor,
                          child: Text(
                            (currentPagePos == TOTAL_PAGES ? strings.finish : strings.next).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          AppIcons.logo2,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
        title: Text(
          strings.questionnaire,
          textAlign: TextAlign.start,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(15.0),
        child: FormBlocProvider(
          bloc: _bloc,
          child: Column(
            children: [
              SectionIndicator(
                  currentStep: currentPagePos,
                  sections: FormSections,
                  disabledColor: Theme.of(context).colorScheme.onPrimary,
                  completedColor: Theme.of(context).colorScheme.onPrimary,
                  enabledColor: Theme.of(context).accentColor),
              Expanded(
                flex: 7,
                child: PageSelector(
                  currentPagePos: currentPagePos,
                  pages: pages,
                ),
              ),
              SizedBox(height: 20),
              _buildBottomButtons,
            ],
          ),
        ),
      ),
    );
  }
}
