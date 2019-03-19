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
            context: context, initialDate: selectedDate, firstDate: DateTime(1950), lastDate: DateTime.now())
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

  _buildPictureList(strings, int pos) {
    return Expanded(
      child: GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text("Camara"),
                        onTap: () => _getImage(pos, ImageSource.camera),
                      ),
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text("Galeria"),
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
                : Container(
                    color: Colors.grey[300],
//                    constraints: BoxConstraints(minHeight: double.infinity),
                    child: Icon(Icons.add_a_photo)),
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
            child: Image.asset('res/icons/male.png', color: gender == Gender.male ? Color(0xFF2ABEB6) : null),
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
        Expanded(
          child: Text(
            "Selecciona las fotos para que tus intereses puedan verte y conocerter.",
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Row(
              children: [
                _buildPictureList(strings, 0),
                SizedBox(width: 12),
                _buildPictureList(strings, 1),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Expanded(
          flex: 2,
          child: Container(
            child: Row(
              children: [
                _buildPictureList(strings, 2),
                SizedBox(width: 12),
                _buildPictureList(strings, 3),
              ],
            ),
          ),
        ),
      ],
    );

    /** Section 2 **/
    Widget _buildPageTwo = ListView(
      children: [
        Text(
          "Cuentanos sobre ti.",
          textAlign: TextAlign.center,
        ),
        TextFormField(
          initialValue: _email != null ? _email : "",
          decoration: InputDecoration(labelText: 'Correo', hintText: "usuario@example.com"),
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
                  labelText: 'Fecha de nacimiento',
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
                child: Text('Soy',
                    textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor))),
            Expanded(child: _buildGenderSelector(true))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Me interesa',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(child: _buildGenderSelector(false))
          ],
        ),
      ],
    );

    /** Section 3 **/
    Widget _buildPageThree = SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Cuentanos sobre ti.",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Como te describes?',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Que te gusta hacer en tus tiempos libres?',
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'A que te dedicas?',
            ),
          ),
          SizedBox(height: 25),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Que buscas en otra persona?',
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );

    /** Section 4 **/
    Widget _buildPageFour = Column(
      children: [
        SizedBox(height: 20),
        ClipOval(
          child: Container(
            height: 200.0,
            width: 200.0,
            color: _images[0] != null ? Colors.transparent : Colors.grey[300],
            child: _images[0] != null ? Image.file(_images[0], fit: BoxFit.cover) : Icon(Icons.add_a_photo),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Bienvenido',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 45,
            fontFamily: 'BettyLavea',
          ),
        ),
        SizedBox(height: 20),
        Text(
          _name != null ? _name : "",
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
              "En Meshe queremos suferite los usuarios que cumplan con las características que tu deseas en tu pareja, para esto hacemos un cuestionario profundo para entender tus hábitos e intereses y lograr ser más asertivos a la hora de sugerirte otras personas.\n\n\nPuedes ingresar o completar tu perfil.",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 40),
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
                currentPage == 1 ? '' : 'Atras',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
        Expanded(child: Text(currentPage != 4 ? "$currentPage de 3" : "", textAlign: TextAlign.center)),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => setState(() {
                    currentPage++;
                    if (currentPage > 4) currentPage = 4;
                  }),
              child: Text(
                currentPage == 3 ? 'Finalizar' : 'Siguiente',
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
              flex: currentPage != 4 ? 2: 0,
              child: Container(
                alignment: Alignment.center,
                child: currentPage != 4
                    ? Text(
                        'Como Eres?',
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
