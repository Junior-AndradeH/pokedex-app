// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:scoped_model/scoped_model.dart';

import 'colors_model.dart';

// main class
class PokemonModel extends Model {
  // static
  static PokemonModel of(BuildContext context) =>
      ScopedModel.of<PokemonModel>(context);

  // variables
  PokemonData? _pokemonData;

  String? _text;

  List? _list;

  // void
  void setList(List list) {
    _list = list;

    notifyListeners();
  }

  void setPokemonData(PokemonData pokemonData) {
    _pokemonData = pokemonData;

    notifyListeners();
  }

  // function
  PokemonData? getPokemonData() {
    if (_pokemonData == null || _pokemonData == PokemonData()) {
      _pokemonData = null;
    }

    return _pokemonData;
  }

  String? getString(String text){
    String letter = text.replaceRange(1, text.length, "");
    String word = text.replaceRange(0, 1, "");
    _text = letter.toUpperCase() + word;

    return _text;
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