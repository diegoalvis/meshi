import 'package:flutter/material.dart';
import 'package:meshi/utils/localiztions.dart';
import 'package:url_launcher/url_launcher.dart';

/*Text(
'meshi',
style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 45, fontFamily: 'BettyLavea'),
),*/

class ContactPage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.contactUs,),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'meshi',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 45,
                      fontFamily: 'BettyLavea'),
                ),
                Text(
                  'Medellin - Colombia',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 8.0),
                        child: Icon(
                          Icons.phone,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '301 234 56 78',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      child: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'info@mesh-e.com',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(onTap: _openMap,
              child: Image.network(
                  'https://d500.epimg.net/cincodias/imagenes/2015/10/29/lifestyle/1446136907_063470_1446137018_noticia_normal.jpg',
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