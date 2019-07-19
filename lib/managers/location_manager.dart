import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meshi/data/models/user_location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';

const String PERMISSION_DENIED = 'PERMISSION_DENIED';
const String PERMISSION_ALWAYS_DENIED = 'PERMISSION_DENIED_NEVER_ASK';

class LocationManager {
  UserLocation _currentLocation;
  var location = Location();
  String permissionDenied;

  Future<UserLocation> getLocation(BuildContext context) async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on PlatformException catch (e) {
      if (e.code == PERMISSION_DENIED || e.code == PERMISSION_ALWAYS_DENIED) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Permiso requerido", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                content: Text("Meshi requiere el permiso de ubicacion para brindar una mejor experiencia"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      AppSettings.openAppSettings();
                      _dismissDialog(context);
                    },
                    child: Text('Aceptar'),
                  )
                ],
              );
            });
      } else {
        print(_currentLocation.latitude);
        print(_currentLocation.longitude);
      }
    }
    return _currentLocation;
  }

  validatePermissions(BuildContext context) async {
    if (permissionDenied == PERMISSION_DENIED || permissionDenied == PERMISSION_ALWAYS_DENIED) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Permiso requerido", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              content: Text("Meshi requiere el permiso de ubicacion para brindar una mejor experiencia"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    AppSettings.openAppSettings();
                    _dismissDialog(context);
                  },
                  child: Text('Aceptar'),
                )
              ],
            );
          });
    } else {
      print(_currentLocation.latitude);
      print(_currentLocation.longitude);
    }
  }

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
