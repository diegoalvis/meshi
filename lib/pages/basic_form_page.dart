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
          return BasicFormPageOne();
        case 2:
          return BasicFormPageTwo();
        case 3:
          return BasicFormPageThree();
        default:
          return BasicFormPageOne();
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

class BasicFormPageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final bloc = FormBlocProvider.of(context).bloc;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(alignment: Alignment.centerLeft, child: Text("Cual es tu nivle de ingresos?")),
        SizedBox(height: 40),
        Container(
            height: 40,
            child: Row(
              children: [
                Text("700000"),
                Expanded(
                  child: StreamBuilder<User>(
                    stream: bloc.user,
                    builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                      return Slider(
                          min: 700000,
                          max: 10000000,
                          value: 107 / 2 * 100000,
                          onChanged: (newUpperValue) {
//                  setState(() {
//                    _lowerValue = newLowerValue;
//                    _upperValue = newUpperValue;
//                  });
                          });
                    },
                  ),
                ),
                Text("+10000000"),
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
              Text("18"),
              Expanded(
                child: StreamBuilder<User>(
                  stream: bloc.user,
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                    return RangeSlider(
                      min: 18.0,
                      max: 50.0,
                      lowerValue: 22,
                      upperValue: 35,
                      showValueIndicator: true,
                      divisions: (50 - 18),
                      valueIndicatorMaxDecimals: 0,
                      onChanged: (double newLowerValue, double newUpperValue) {
//                  setState(() {
//                    _lowerValue = newLowerValue;
//                    _upperValue = newUpperValue;
//                  });
                      },
                    );
                  },
                ),
              ),
              Text("50"),
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
          child: StreamBuilder<String>(
            stream: bloc.shapeSelected,
            initialData: "Delgad@",
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Row(
                children: [
                  Expanded(
                    child: FlatButton(
                        onPressed: () => bloc.shape = "Delgad@",
                        child: Text("Delgad@"),
                        textColor: snapshot.data == "Delgad@"
                            ? Theme.of(context).accentColor
                            : Colors.grey[400]),
                  ),
                  Expanded(
                    child: FlatButton(
                        onPressed: () => bloc.shape = "Medio",
                        child: Text("Medio"),
                        textColor:
                            snapshot.data == "Medio" ? Theme.of(context).accentColor : Colors.grey[400]),
                  ),
                  Expanded(
                    child: FlatButton(
                        onPressed: () => bloc.shape = "Grande",
                        child: Text("Grande"),
                        textColor: snapshot.data == "Grande"
                            ? Theme.of(context).accentColor
                            : Colors.grey[400]),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 50),
        Container(alignment: Alignment.centerLeft, child: Text("Cual es tu altura?")),
        SizedBox(height: 20),
        StreamBuilder<int>(
          stream: bloc.heightSelected,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
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
        Text(strings.educationalLevelCaption, textAlign: TextAlign.center),
        SizedBox(height: 40),
        Expanded(
          child: Container(
            child: StreamBuilder<int>(
              stream: bloc.eduLevelSelectedIndex,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return ListView.separated(
                  itemCount: FormBloc.educationalLevels.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => bloc.eduLevelIndex = index,
                      title: Text(
                        FormBloc.educationalLevels[index],
                        style: TextStyle(
                            color:
                                (snapshot.data == index ? Theme.of(context).accentColor : Colors.black)),
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
