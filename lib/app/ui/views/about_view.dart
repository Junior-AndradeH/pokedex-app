// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/abilities_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/ui/widgets/breeding_widget.dart';

import '../../models/colors_models.dart';
import '../../models/images_model.dart';

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
    _ocult = AbilitiesData.fromList(_pokemonData!.abilities!, 1).name;

    String species = "Seed";
    double male = 87.5;
    double female = 12.5;

    // return
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sizedBoxDefault(context, "Espécie", species),
          const SizedBox(height: 10.0),
          _sizedBoxDefault(
              context, "Altura", "${_height!.toStringAsFixed(2)} m"),
          const SizedBox(height: 10.0),
          _sizedBoxDefault(
              context, "Peso", "${_weight!.toStringAsFixed(2)} kg"),
          const SizedBox(height: 10.0),
          _sizedBoxDefault(context, "Habilidades",
              "${_ability!.toUpperCase()} (${_ocult!.toUpperCase()})"),
          const SizedBox(height: 20.0),
          const Text("Breeding",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          const SizedBox(height: 20.0),
          _sizedBoxGenre(context, male, female),
          const SizedBox(height: 10.0),
          BreedingWidget(_pokemonData!),
        ],
      ),
    );
  }

  Widget _sizedBoxDefault(BuildContext context, String field, String text) {
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

  Widget _sizedBoxGenre(BuildContext context, double male, double female) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          const Text("Gênero",
              style: TextStyle(
                  color: ColorsModel.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0)),
          Positioned(
            left: 120.0,
            child: Row(
              children: <Widget>[
                _row(ImagesModel.iconMaleBlue, male),
                const SizedBox(width: 10.0),
                _row(ImagesModel.iconFemalePink, female),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String image, double value) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image)),
          ),
          width: 14.0,
          height: 14.0,
        ),
        const SizedBox(width: 5.0),
        Text("${value.toStringAsFixed(1)} %",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
      ],
    );
  }
}