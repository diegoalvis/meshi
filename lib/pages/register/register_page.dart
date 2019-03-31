import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meshi/blocs/register_bloc.dart';
import 'package:meshi/data/models/user_model.dart';
import 'package:meshi/pages/register/welcome_page.dart';
import 'package:meshi/utils/custom_widgets/image_selector.dart';
import 'package:meshi/utils/gender.dart';
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
  final String fbToken;

  RegisterPage({Key key, @required this.fbToken}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(fbToken, RegisterBloc());
}

class _RegisterPageState extends State<RegisterPage> {
  static const _MAX_PICTURES = 4;
  final RegisterBloc _bloc;
  final String _fbToken;

  List<File> _images = new List(_MAX_PICTURES);
  DateTime selectedDate = DateTime.now();
  Gender _userDefineGender;
  Set<Gender> _userInterestedGender = Set<Gender>();
  int currentPage = 1;

  _RegisterPageState(this._fbToken, this._bloc);

  @override
  void initState() {
    super.initState();
    _bloc.loadFacebookProfile(_fbToken);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  _buildGenderSelector(bool isUnique) {
    Color colorMale = isUnique
        ? (_userDefineGender == Gender.male ? Color(Gender.male.color) : null)
        : (_userInterestedGender?.contains(Gender.male) == true ? Color(Gender.male.color) : null);
    Color colorFemale = isUnique
        ? (_userDefineGender == Gender.female ? Color(Gender.female.color) : null)
        : (_userInterestedGender?.contains(Gender.female) == true ? Color(Gender.female.color) : null);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
                  if (isUnique) {
                    _userDefineGender = Gender.male;
                  } else {
                    if (_userInterestedGender.contains(Gender.male)) {
                      _userInterestedGender.remove(Gender.male);
                    } else {
                      _userInterestedGender.add(Gender.male);
                    }
                  }
                }),
            child: Image.asset(Gender.male.icon, color: colorMale),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
                  if (isUnique) {
                    _userDefineGender = Gender.female;
                  } else {
                    if (_userInterestedGender.contains(Gender.female)) {
                      _userInterestedGender.remove(Gender.female);
                    } else {
                      _userInterestedGender.add(Gender.female);
                    }
                  }
                }),
            child: Image.asset(Gender.female.icon, color: colorFemale),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    /** Section 1 **/
    Widget _buildPageOne = Column(
      children: [
        Text(
          strings.pictureSelectCaption,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50),
        Row(
          children: [
            ImageSelector(_images[0], (image) => setState(() => _images[0] = image)),
            SizedBox(width: 12),
            ImageSelector(_images[1], (image) => setState(() => _images[1] = image)),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            ImageSelector(_images[2], (image) => setState(() => _images[2] = image)),
            SizedBox(width: 12),
            ImageSelector(_images[3], (image) => setState(() => _images[3] = image)),
          ],
        ),
      ],
    );

    /** Section 2 **/
    Widget _buildPageTwo = ListView(
      children: [
        Text(
          strings.tellUsAboutYou,
          textAlign: TextAlign.center,
        ),
        StreamBuilder<User>(
          stream: _bloc.user,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            return TextFormField(
              initialValue: snapshot.data?.email != null ? snapshot.data.email : "",
              decoration: InputDecoration(labelText: strings.email, hintText: "usuario@example.com"),
            );
          },
        ),
        SizedBox(height: 25),
        GestureDetector(
          onTap: () => showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now())
                  .then<DateTime>((DateTime pickedDate) {
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() => selectedDate = pickedDate);
                }
              }),
          child: Container(
            color: Colors.transparent,
            child: IgnorePointer(
              child: TextFormField(
                controller: TextEditingController(
                    text: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                decoration: InputDecoration(
                  labelText: strings.birthDate,
                  hintText: "dd/mm/aa",
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Expanded(
                child: Text(strings.self,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).primaryColor))),
            Expanded(flex: 2, child: _buildGenderSelector(true))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                strings.interested,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(flex: 2, child: _buildGenderSelector(false))
          ],
        ),
      ],
    );

    /** Section 3 **/
    Widget _buildPageThree = SingleChildScrollView(
      child: Column(
        children: [
          Text(
            strings.tellUsAboutYou,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.howDescribeYourself,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.hobbiesCaption,
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.whatYouDo,
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: strings.whatYouLookingFor,
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
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
            child: StreamBuilder<User>(
              stream: _bloc.user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                return FlatButton(
                  onPressed: () => setState(() {
                        currentPage++;
                        if (currentPage > 3) {
                          currentPage = 3;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WelcomePage(image: _images[0], name: snapshot?.data?.name)),
                          );
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
                );
              },
            ),
          ),
        ),
      ],
    );

    Widget _buildPage() {
      switch (currentPage) {
        case 1:
          return _buildPageOne;
        case 2:
          return _buildPageTwo;
        case 3:
          return _buildPageThree;
        default:
          return _buildPageOne;
      }
    }

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: RegisterBlocProvider(
          bloc: _bloc,
          child: Column(
            children: [
              Expanded(
                flex: currentPage != 4 ? 2 : 0,
                child: Container(
                  alignment: Alignment.center,
                  child: currentPage != 4
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
