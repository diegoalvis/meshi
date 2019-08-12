import 'package:flutter/material.dart';
import 'package:meshi/utils/const_utils.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeColor.primary),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  strings.titleAppMin,
                  style: TextStyle(color: themeColor.secondary, fontSize: 45, fontFamily: 'BettyLavea'),
                ),
                Text(
                  strings.meshiCityLocation,
                  style: TextStyle(
                    color: themeColor.onSurface,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                        child: Icon(
                          Icons.phone,
                          color: themeColor.onSurface,
                        ),
                      ),
                      Text(
                        MESHI_PHONE,
                        style: TextStyle(
                          color: themeColor.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                      child: Icon(
                        Icons.email,
                        color: themeColor.onSurface,
                      ),
                    ),
                    Text(
                      MESHI_EMAIL,
                      style: TextStyle(
                        color: themeColor.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _openMap,
              child: Image.network(
                  MAP_IMAGE,
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}

_openMap() async {
  const url = 'https://www.google.com/maps/search/?api=1&query=6.249555, -75.570087';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

const String MAP_IMAGE = 'https://d500.epimg.net/cincodias/imagenes/2015/10/29/lifestyle/1446136907_063470_1446137018_noticia_normal.jpg';
