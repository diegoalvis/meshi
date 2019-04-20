/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshi/utils/localiztions.dart';

class ImageSelector extends StatelessWidget {
  final Function(File image) onImageSelected;
  final String image;
  final bool showLoader;

  ImageSelector(this.image, this.onImageSelected, {this.showLoader = false});

  _getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = MyLocalizations.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.photo_camera),
                          title: Text(strings.camera),
                          onTap: () {
                            _getImage(ImageSource.camera);
                            Navigator.pop(context);
                          }),
                      ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text(strings.gallery),
                          onTap: () {
                            _getImage(ImageSource.gallery);
                            Navigator.pop(context);
                          }),
                    ],
                  ),
            ),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(16.0),
            child: Container(
              color: Colors.grey[300],
              child: showLoader
                  ? Center(child: CircularProgressIndicator())
                  : image != null ? Image.network(image, fit: BoxFit.cover) : Icon(Icons.add_a_photo),
            ),
          ),
        ),
      ),
    );
  }
}
