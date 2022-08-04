// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/evolution_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/app/datas/species_data.dart';
import 'package:pokedexapp/app/models/pokemon_model.dart';

// main class
class EvolutionView extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;
  SpeciesData? _speciesData;
  EvolutionData? _evolutionData;

  // constructor
  EvolutionView(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variable
    _speciesData = PokemonModel.of(context).getSpeciesData();

    // return
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFuture(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.error != null) {
            return Container();
          } else {
            // data
            _evolutionData = EvolutionData.fromMap(snapshot.data!);

            print("name: ${ _evolutionData!.chain }");

            // return
            return Container();
          }
        });
  }

  Widget _row(BuildContext context){
    return Row(
      children: <Widget>[
        _sizedBox(context, 0, "teste", "teste"),
        _sizedBox(context, 1, "teste", "teste"),
      ],
    );
  }

  Widget _sizedBox(BuildContext context, int index, String image, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          ),
          width: 150.0,
          height: 150.0,
        ),
      ],
    );
  }

  // future
  Future<Map<String, dynamic>> _getFuture(BuildContext context) async {
    // get data
    String url = _speciesData!.evolutionChain!["url"];
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
    response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}