import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshi/utils/localiztions.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const _MAX_PICTURES = 4;

  List<File> _images = new List(_MAX_PICTURES);

  getImage(index, source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _images[index] = image;
      });
    }
  }

  _buildPictureList() {
    List<Widget> _imageList = new List();
    for (var i = 0; i < _MAX_PICTURES; i++) {
      _imageList.add(
        GestureDetector(
          onTap: () => getImage(i, ImageSource.gallery),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(16.0),
            child: _images[i] != null
                ? Image.file(_images[i], fit: BoxFit.cover)
                : Container(
                    color: Colors.grey,
                    child: Icon(Icons.add_a_photo),
                  ),
          ),
        ),
      );
    }
    return _imageList;
  }

  _buildGenderSelector(context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => {},
            child: Image.asset(
              'res/icons/male.png',
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => {},
            child: Image.asset(
              'res/icons/female.png',
            ),
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
          flex: 4,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: _buildPictureList(),
          ),
        ),
      ],
    );

    /** Section 2 **/
    Widget _buildPageTwo = Column(
      children: [
        Expanded(
          child: Text(
            "Cuentanos sobre ti.",
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Correo', hintText: "usuario@example.com"),
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Fecha de nacimiento',
              hintText: "dd/mm/aa",
              fillColor: Theme.of(context).colorScheme.onPrimary,
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                  child: Text('Soy',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).primaryColor))),
              Expanded(child: _buildGenderSelector(context))
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Me interesa',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Expanded(child: _buildGenderSelector(context))
            ],
          ),
        ),
      ],
    );

    /** Navigation buttons **/
    Widget _buildBottomButtons = Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              child: Text(
                'Atras',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
        Expanded(child: Text("1 de 3", textAlign: TextAlign.center)),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: FlatButton(
              child: Text(
                'Siguiente',
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

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Como Eres?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 45,
                    fontFamily: 'BettyLavea',
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: _buildPageTwo,
            ),
            _buildBottomButtons,
          ],
        ),
      ),
    );
  }
}
