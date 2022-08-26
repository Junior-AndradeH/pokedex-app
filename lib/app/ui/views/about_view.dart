// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/abilities_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/ui/widgets/breeding_widget.dart';

import '../../models/colors_model.dart';
import '../../models/pokemon_model.dart';

// main class
class AboutView extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;

  String? _ability;
  String? _ocult;

  double? _height;
  double? _weight;

  // constructor
  AboutView(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variables
    _height = _pokemonData!.height! / 10;
    _weight = _pokemonData!.weight! / 10;
    _ability = AbilitiesData.fromList(_pokemonData!.abilities!, 0).name;
    _ocult = _pokemonData!.abilities!.length <= 1
        ? ""
        : AbilitiesData.fromList(_pokemonData!.abilities!, 1).name;

    // convert
    String ability = PokemonModel.of(context).getString(_ability!)!;
    String ocult = _pokemonData!.abilities!.length <= 1
        ? ""
        : "(${PokemonModel.of(context).getString(_ocult!)!})";

    // return
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          _sizedBox(
              context, "Height", "${_height!.toStringAsFixed(2)} m"),
          const SizedBox(height: 10.0),
          _sizedBox(
              context, "Weight", "${_weight!.toStringAsFixed(2)} kg"),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Abilities", "$ability $ocult"),
          const SizedBox(height: 20.0),
          const Text("Breeding",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          const SizedBox(height: 20.0),
          BreedingWidget(_pokemonData!),
        ],
      ),
    );
  }

  Widget _sizedBox(BuildContext context, String field, String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Text(field,
              style: const TextStyle(
                  color: ColorsModel.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0)),
          Positioned(
            left: 120.0,
            child: Text(text,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}