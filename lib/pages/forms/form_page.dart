import 'package:flutter/material.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/forms/basic/basic_page_four.dart';
import 'package:meshi/pages/forms/basic/basic_page_one.dart';
import 'package:meshi/pages/forms/basic/basic_page_three.dart';
import 'package:meshi/pages/forms/basic/basic_page_two.dart';
import 'package:meshi/pages/forms/habits/habits_page_one.dart';
import 'package:meshi/pages/forms/habits/habits_page_two.dart';
import 'package:meshi/pages/forms/specifics/specific_page_five.dart';
import 'package:meshi/pages/forms/specifics/specific_page_four.dart';
import 'package:meshi/pages/forms/specifics/specific_page_one.dart';
import 'package:meshi/pages/forms/specifics/specific_page_three.dart';
import 'package:meshi/pages/forms/specifics/specific_page_two.dart';
import 'package:meshi/pages/home/home_page.dart';
import 'package:meshi/utils/custom_widgets/page_selector.dart';
import 'package:meshi/utils/custom_widgets/section_indicator.dart';
import 'package:meshi/utils/localiztions.dart';

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
class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState(FormBloc());
}

class _FormPageState extends State<FormPage> {
  final FormBloc _bloc;
  static const TOTAL_PAGES = 7;

  int currentPage = 1;

  _FormPageState(this._bloc);

  @override
  void initState() {
    super.initState();
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
          child: Text("$currentPage ${strings.ofLabel} $TOTAL_PAGES", textAlign: TextAlign.center),
        )),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => setState(() {
                    currentPage++;
                    if (currentPage > TOTAL_PAGES) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => HomePage(fbToken: "")));
                      currentPage = TOTAL_PAGES;
                    }
                  }),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              color: Theme.of(context).accentColor,
              child: Text(
                (currentPage == TOTAL_PAGES ? strings.finish : strings.next).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Transform.rotate(
            angle: -0.3,
            child: Image.asset(
              "res/icons/logo.png",
              scale: 4,
              color: Theme.of(context).primaryColor,
            )),
        title: Text(
          "Cuestionario",
          textAlign: TextAlign.start,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(15.0),
        child: FormBlocProvider(
          bloc: FormBloc(),
          child: Column(
            children: [
              SectionIndicator(
                  currentStep: currentPage,
                  sections: FormSections,
                  disabledColor: Theme.of(context).colorScheme.onPrimary,
                  completedColor: Theme.of(context).colorScheme.onPrimary,
                  enabledColor: Theme.of(context).accentColor),
              Expanded(
                flex: 7,
                child: PageSelector(
                  currentPage: 11,
                  pages: [
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
                  ],
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
