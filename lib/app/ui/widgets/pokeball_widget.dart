// import
import 'package:flutter/material.dart';

// main class
class PokeballWidget extends StatelessWidget {
  // variables
  String? _image;

  double? _opacity;
  double? _width;
  double? _height;

  // constructor
  PokeballWidget(this._image, this._opacity, this._width, this._height);

  // widget
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity!,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(_image!),
              fit: BoxFit.cover),
        ),
        width: _width,
        height: _height,
      ),
    );
  }
}