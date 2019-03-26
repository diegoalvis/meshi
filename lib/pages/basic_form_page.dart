import 'package:flutter/material.dart';
import 'package:meshi/blocs/form_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

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
class BasicFormPage extends StatefulWidget {
  @override
  _BasicFormPageState createState() => _BasicFormPageState(FormBloc());
}

class _BasicFormPageState extends State<BasicFormPage> {
  final FormBloc _bloc;

  int currentPage = 1;

  _BasicFormPageState(this._bloc);

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
    const TOTAL_PAGES = 5;
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

    Widget _buildPage() {
      switch (currentPage) {
        case 1:
          return BasicFormPageOne();
        case 2:
          return BasicFormPageTwo();
        case 3:
          return BasicFormPageThree();
        case 4:
          return BasicFormPageFour();
        default:
          return BasicFormPageOne();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset(
          "res/icons/logo.png",
          scale: 4,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Cuestionario",
          textAlign: TextAlign.start,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: FormBlocProvider(
          bloc: FormBloc(),
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
      ),
    );
  }
}

// Pages

class BasicFormPageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;

    return Column(
      children: [
        SizedBox(height: 20),
        Container(
            alignment: Alignment.centerLeft,
            child: Text("¿Que contextura fisica prefieres para tu pareja?")),
        SizedBox(height: 40),
        Container(
          height: 40,
          child: StreamBuilder<User>(
            stream: bloc.userStream,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Row(
                  children: BodyShapeList.map((item) {
                return Expanded(
                  child: FlatButton(
                      onPressed: () => bloc.updateBodyShapePreferred(item),
                      child: Text(item),
                      textColor: snapshot?.data?.bodyShapePreferred?.contains(item) == true
                          ? Theme.of(context).accentColor
                          : Colors.grey[400]),
                );
              }).toList());
            },
          ),
        ),
        SizedBox(height: 50),
        Container(alignment: Alignment.centerLeft, child: Text("Es importante el nivel de ingresos?")),
        SizedBox(height: 20),
        StreamBuilder<User>(
          stream: bloc.userStream,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            return Column(
              children: [
                Row(children: [
                  FlatButton(
                      onPressed: () => bloc.isIncomeImportant = true,
                      child: Text("SI"),
                      textColor: snapshot?.data?.isIncomeImportant == true
                          ? Theme.of(context).accentColor
                          : Colors.grey[400]),
                  FlatButton(
                      onPressed: () => bloc.isIncomeImportant = false,
                      child: Text("NO"),
                      textColor: snapshot?.data?.isIncomeImportant != true
                          ? Theme.of(context).accentColor
                          : Colors.grey[400]),
                ]),
                SizedBox(height: 40),
                snapshot?.data?.isIncomeImportant != true
                    ? SizedBox()
                    : Row(
                        children: [
                          Text("${FormBloc.MIN_INCOME.toInt()}\n o menos",
                              textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                          Expanded(
                            child: RangeSlider(
                              min: FormBloc.MIN_INCOME,
                              max: FormBloc.MAX_INCOME,
                              lowerValue: (snapshot.data?.minIncomePreferred ??
                                      (FormBloc.MIN_INCOME + FormBloc.STEP_INCOME))
                                  .toDouble(),
                              upperValue: (snapshot.data?.maxIncomePreferred ??
                                      (FormBloc.MAX_INCOME - FormBloc.STEP_INCOME))
                                  .toDouble(),
                              showValueIndicator: true,
                              divisions:
                                  (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                              valueIndicatorMaxDecimals: 0,
                              onChanged: (double newLowerValue, double newUpperValue) =>
                                  bloc.incomeRangePreferred(newLowerValue, newUpperValue),
                            ),
                          ),
                          Text("${FormBloc.MAX_INCOME.toInt()}\n o mas",
                              textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ],
                      ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class BasicFormPageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text("Cual es tu nivel de ingresos?")),
        SizedBox(height: 40),
        Container(
            height: 40,
            child: Row(
              children: [
                Text("${FormBloc.MIN_INCOME.toInt()}\n o menos",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                Expanded(
                  child: StreamBuilder<User>(
                    stream: bloc.userStream,
                    builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                      return Slider(
                          label: snapshot.data?.income?.toInt()?.toString() ?? "",
                          min: FormBloc.MIN_INCOME,
                          max: FormBloc.MAX_INCOME,
                          divisions: (FormBloc.MAX_INCOME - FormBloc.MIN_INCOME) ~/ FormBloc.STEP_INCOME,
                          value:
                              snapshot.data?.income ?? (FormBloc.MIN_INCOME + FormBloc.MAX_INCOME) / 2,
                          onChanged: (newUpperValue) => bloc.income = newUpperValue);
                    },
                  ),
                ),
                Text("${FormBloc.MAX_INCOME.toInt()}\n o mas",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
              ],
            )),
        SizedBox(height: 80),
        Container(alignment: Alignment.centerLeft, child: Text("Que edades prefieres para tu pareja?")),
        SizedBox(height: 40),
        Container(
          height: 40,
          child: Row(
            children: [
              SizedBox(width: 20),
              Text(FormBloc.MIN_AGE.toString()),
              Expanded(
                child: StreamBuilder<User>(
                  stream: bloc.userStream,
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                    return RangeSlider(
                      min: FormBloc.MIN_AGE.toDouble(),
                      max: FormBloc.MAX_AGE.toDouble(),
                      lowerValue: (snapshot.data?.minAgePreferred ?? (FormBloc.MIN_AGE + 5)).toDouble(),
                      upperValue: (snapshot.data?.maxAgePreferred ?? (FormBloc.MAX_AGE - 5)).toDouble(),
                      showValueIndicator: true,
                      divisions: FormBloc.MAX_AGE - FormBloc.MIN_AGE,
                      valueIndicatorMaxDecimals: 0,
                      onChanged: (double newLowerValue, double newUpperValue) =>
                          bloc.ageRangePreferred(newLowerValue.toInt(), newUpperValue.toInt()),
                    );
                  },
                ),
              ),
              Text(FormBloc.MAX_AGE.toString()),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class BasicFormPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;

    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text("Cual es tu contextura fisica?")),
        SizedBox(height: 40),
        Container(
          height: 40,
          child: StreamBuilder<User>(
            stream: bloc.userStream,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Row(
                  children: BodyShapeList.map((item) {
                return Expanded(
                  child: FlatButton(
                      onPressed: () => bloc.shape = item,
                      child: Text(item),
                      textColor: snapshot?.data?.bodyShape == item
                          ? Theme.of(context).accentColor
                          : Colors.grey[400]),
                );
              }).toList());
            },
          ),
        ),
        SizedBox(height: 50),
        Container(alignment: Alignment.centerLeft, child: Text("Cual es tu altura?")),
        SizedBox(height: 20),
        StreamBuilder<User>(
          stream: bloc.userStream,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            return TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Centimetros"),
            );
          },
        ),
      ],
    );
  }
}

class BasicFormPageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text(strings.educationalLevelCaption)),
        SizedBox(height: 40),
        Expanded(
          child: Container(
            child: StreamBuilder<User>(
              stream: bloc.userStream,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                return ListView.separated(
                  itemCount: EducationalLevels.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => bloc.eduLevelIndex = EducationalLevels[index],
                      title: Text(
                        EducationalLevels[index],
                        style: TextStyle(
                            color: (snapshot?.data?.eduLevel == EducationalLevels[index]
                                ? Theme.of(context).accentColor
                                : Colors.black)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
