// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/species_data.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_models.dart';

// main class
class SpeciesWidget extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;
  SpeciesData? _speciesData;

  String? _eggGroups;
  String? _eggCycle;

  // constructor
  SpeciesWidget(this._pokemonData);

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

            // return
            return _columnData(context, _speciesData!);
          }
        });
  }

  Widget _columnNull(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBox(context, "Egg Groups", "None"),
        const SizedBox(height: 10.0),
        _sizedBox(context, "Egg Cycle", "None"),
      ],
    );
  }

  Widget _columnData(BuildContext context, SpeciesData speciesData) {
    // set variables
    _eggGroups = SpeciesData.fromList(speciesData.eggGroups!, 0).name;
    _eggCycle = SpeciesData.fromList(speciesData.eggGroups!, 1).name;

    // return
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBox(context, "Egg Groups", _eggGroups!),
        const SizedBox(height: 10.0),
        _sizedBox(context, "Egg Cycle", _eggCycle!),
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
            child: Text(text.toUpperCase(),
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