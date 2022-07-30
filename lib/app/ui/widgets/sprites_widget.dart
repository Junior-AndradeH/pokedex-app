// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/sprites_data.dart';

// main class
class SpritesWidget extends StatelessWidget {
  // variables
  SpritesData? _spritesData;

  double? _width;
  double? _height;

  // constructor
  SpritesWidget(this._width, this._height, this._spritesData);

  // widget
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(_spritesData!.frontDefault!),
            fit: BoxFit.cover),
      ),
      width: _width,
      height: _height,
    );
  }
}