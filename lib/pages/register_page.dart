import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:meshi/utils/gender.dart';
import 'package:meshi/utils/localiztions.dart';

class RegisterPage extends StatefulWidget {
  final String fbToken;

  RegisterPage({Key key, this.fbToken}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(fbToken);
}

class _RegisterPageState extends State<RegisterPage> {
  static const _MAX_PICTURES = 4;
  final String _fbToken;

  var _profile;
  String _name, _email;
  List<File> _images = new List(_MAX_PICTURES);
  DateTime selectedDate = DateTime.now();
  Gender _userDefineGender, _userInterestedGender;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    loadFacebookProfile();
  }

  void loadFacebookProfile() async {
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$_fbToken');
    setState(() {
      _profile = json.decode(graphResponse.body);
      try {
        _name = _profile['name'];
        _email = _profile['email'];
      } catch (e) {
        print(e.toString());
      }
    });
  }

  _RegisterPageState(this._fbToken);

  _selectDate() {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then<DateTime>((DateTime pickedDate) {
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() => selectedDate = pickedDate);
      }
    });
  }

  _getImage(index, source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      setState(() => _images[index] = image);
    }
  }

  _buildPictureSelector(MyLocalizations strings, int pos) {
    return Expanded(
      child: GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text(strings.camera),
                        onTap: () => _getImage(pos, ImageSource.camera),
                      ),
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text(strings.gallery),
                        onTap: () => _getImage(pos, ImageSource.gallery),
                      ),
                    ],
                  ),
            ),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(16.0),
            child: _images[pos] != null
                ? Image.file(_images[pos], fit: BoxFit.cover)
                : Container(color: Colors.grey[300], child: Icon(Icons.add_a_photo)),
          ),
        ),
      ),
    );
  }

  _buildGenderSelector(bool isUserGender) {
    var gender = isUserGender ? _userDefineGender : _userInterestedGender;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
                  if (isUserGender)
                    this._userDefineGender = Gender.male;
                  else
                    this._userInterestedGender = Gender.male;
                }),
            child: Image.asset('res/icons/male.png',
                color: gender == Gender.male ? Color(0xFF2ABEB6) : null),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
                  if (isUserGender)
                    this._userDefineGender = Gender.female;
                  else
                    this._userInterestedGender = Gender.female;
                }),
            child: Image.asset('res/icons/female.png',
                color: gender == Gender.female ? Color(0xFF80065E) : null),
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
            _buildPictureSelector(strings, 0),
            SizedBox(width: 12),
            _buildPictureSelector(strings, 1),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildPictureSelector(strings, 2),
            SizedBox(width: 12),
            _buildPictureSelector(strings, 3),
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
        TextFormField(
          initialValue: _email != null ? _email : "",
          decoration: InputDecoration(labelText: strings.email, hintText: "usuario@example.com"),
        ),
        SizedBox(height: 25),
        GestureDetector(
          onTap: () => _selectDate(),
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

    /** Section 4 **/
    Widget _buildPageFour = Column(
      children: [
        SizedBox(height: 40),
        ClipOval(
          child: Container(
            height: 200.0,
            width: 200.0,
            color: _images[0] != null ? Colors.transparent : Colors.grey[300],
            child:
                _images[0] != null ? Image.file(_images[0], fit: BoxFit.cover) : Icon(Icons.add_a_photo),
          ),
        ),
        SizedBox(height: 30),
        Text(
          strings.welcome,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 45,
            fontFamily: 'BettyLavea',
          ),
        ),
        SizedBox(height: 20),
        Text(
          _name != null ? _name : "Usuario",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23.0,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              strings.welcomeCaption,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
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
                (currentPage == 4 ? strings.logIn : currentPage == 1 ? '' : strings.back).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
        Expanded(
          flex: currentPage != 4 ? 1 : 0,
          child: Container(
              child: currentPage != 4
                  ? Text("$currentPage ${strings.ofLabel} 3", textAlign: TextAlign.center)
                  : null),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => setState(() {
                    currentPage++;
                    if (currentPage > 4) currentPage = 4;
                  }),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              color: currentPage == 4 ? Theme.of(context).accentColor : Colors.transparent,
              child: Text(
                (currentPage == 4
                        ? strings.completeProfile
                        : currentPage == 3 ? strings.finish : strings.next)
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentPage == 4 ? Colors.white : Theme.of(context).accentColor,
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
        case 2:
          return _buildPageTwo;
        case 3:
          return _buildPageThree;
        case 4:
          return _buildPageFour;
        default:
          return _buildPageOne;
      }
    }

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(28.0),
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
    );
  }
}
