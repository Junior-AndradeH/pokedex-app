// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/species_data.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_models.dart';
import '../../models/pokemon_model.dart';

// main class
class BreedingWidget extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;
  SpeciesData? _speciesData;

  String? _eggGroups;
  String? _eggCycle;

  // constructor
  BreedingWidget(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFuture(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.error != null) {
            return _columnNull(context);
          } else {
            // data
            _speciesData = SpeciesData.fromMap(snapshot.data!);

            // model
            PokemonModel.of(context).setSpeciesData(_speciesData!);

            // return
            return _columnData(context, _speciesData!);
          }
        });
  }

  Widget _columnNull(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBox(context, "Egg Groups", "NONE"),
        const SizedBox(height: 10.0),
        _sizedBox(context, "Egg Cycle", "NONE"),
      ],
    );
  }

  Widget _columnData(BuildContext context, SpeciesData speciesData) {
    // set variables
    _eggGroups = SpeciesData.fromList(speciesData.eggGroups!, 0).name;
    _eggCycle = speciesData.eggGroups!.length <= 1
        ? _eggGroups
        : SpeciesData.fromList(speciesData.eggGroups!, 1).name;

    // convert
    String eggGroups = PokemonModel.of(context).getString(_eggGroups!)!;
    String eggCycle = PokemonModel.of(context).getString(_eggCycle!)!;

    // return
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBox(context, "Egg Groups", eggGroups),
        const SizedBox(height: 10.0),
        _sizedBox(context, "Egg Cycle", eggCycle),
      ],
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

  // future
  Future<Map<String, dynamic>> _getFuture(BuildContext context) async {
    // get data
    String url = _pokemonData!.species!["url"];
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
    response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}