/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshi/data/api/base_api.dart';
import 'package:meshi/utils/localiztions.dart';

class ImageSelector extends StatelessWidget {
  final Function(File image) onImageSelected;
  final Function(String image) onDeleteSelected;
  final String image;
  final Stream<bool> showLoader;

  ImageSelector(this.image, this.onImageSelected, this.onDeleteSelected, {this.showLoader});

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
              child: StreamBuilder<bool>(
                stream: showLoader,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return snapshot.data
                      ? Center(child: CircularProgressIndicator())
                      : image != null && image.isNotEmpty && image != "null"
                          ? DecoratedBox(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(BaseApi.IMAGES_URL_DEV + image),
                                fit: BoxFit.cover,
                              )),
                              child: GestureDetector(
                                onTap: () => onDeleteSelected(image),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ClipOval(
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.transparent.withOpacity(0.20),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Icon(Icons.add_a_photo);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
