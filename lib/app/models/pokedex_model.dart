// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokedex_data.dart';
import 'package:scoped_model/scoped_model.dart';

import 'colors_model.dart';

// main class
class PokedexModel extends Model {
  // static
  static PokedexModel of(BuildContext context) =>
      ScopedModel.of<PokedexModel>(context);

  // variables
  PokedexData? _pokedexData;

  List? _list;

  // void
  void setList(List list) {
    _list = list;

    notifyListeners();
  }

  void setPokedexData(PokedexData pokedexData) {
    _pokedexData = pokedexData;

    notifyListeners();
  }

  // function
  PokedexData? getPokedexData() {
    if (_pokedexData == null || _pokedexData == PokedexData()) {
      _pokedexData = null;
    }

    return _pokedexData;
  }

  Color? getColor(String text) {
    switch (text) {
      case "bug":
        return ColorsModel.bug;
      case "dark":
        return ColorsModel.dark;
      case "dragon":
        return ColorsModel.dragon;
      case "electric":
        return ColorsModel.electric;
      case "fairy":
        return ColorsModel.fairy;
      case "fighting":
        return ColorsModel.fighting;
      case "fire":
        return ColorsModel.fire;
      case "flying":
        return ColorsModel.flying;
      case "ghost":
        return ColorsModel.ghost;
      case "grass":
        return ColorsModel.grass;
      case "ground":
        return ColorsModel.ground;
      case "ice":
        return ColorsModel.ice;
      case "normal":
        return ColorsModel.normal;
      case "poison":
        return ColorsModel.poison;
      case "psychic":
        return ColorsModel.psychic;
      case "rock":
        return ColorsModel.rock;
      case "steel":
        return ColorsModel.steel;
      case "water":
        return ColorsModel.water;
      default:
        return ColorsModel.grey;
    }
  }

  List? getList() {
    if (_list == null || _list!.isEmpty) {
      _list = [];
    }

    return _list;
  }

  LinearGradient? getLinearGradient(Color color1, Color color2) {
    return LinearGradient(colors: [
      color1,
      color2,
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  }
}