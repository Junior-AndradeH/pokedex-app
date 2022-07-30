// import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedexapp/app/ui/tiles/pokedex_tile.dart';
import 'package:pokedexapp/app/ui/widgets/pokeball_widget.dart';

import '../../models/images_model.dart';

// main class
class PokeDexPage extends StatelessWidget {
  // variables
  String? _filter;

  DateTime? _dateTime;

  // widget
  @override
  Widget build(BuildContext context) {
    // set variable
    _filter = "all";
    _dateTime = DateTime.now();

    // return
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          _positioned(context),
          PokeDexTile(_dateTime!, _filter!),
        ],
      ),
    );
  }

  Widget _positioned(BuildContext context) {
    return Positioned(
      top: -70.0,
      right: -85.0,
      child: PokeballWidget(ImagesModel.iconPokeballGrey, 0.2, 250.0, 250.0),
    );
  }
}