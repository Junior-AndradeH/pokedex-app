// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/models/urls_model.dart';
import 'package:pokedexapp/app/ui/widgets/sprites_widget.dart';
import 'package:pokedexapp/app/datas/sprites_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_model.dart';
import '../../models/pokemon_model.dart';

// main class
class PokemonWidget extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;

  String? _pokemon;
  String? _name;

  // constructor
  PokemonWidget(this._pokemon, this._name);

  // widget
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFuture(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.error != null) {
            return Container();
          } else {
            // data
            _pokemonData = PokemonData.fromMap(snapshot.data!);

            // return
            return _sizedBox(context, _pokemonData!);
          }
        });
  }

  Widget _sizedBox(BuildContext context, PokemonData pokemonData) {
    // set variable
    SpritesData spritesData = SpritesData.fromMap(pokemonData.sprites!);
    String name = PokemonModel.of(context).getString(pokemonData.name!)!;

    // return
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: _pokemon == pokemonData.name
                ? ColorsModel.greyAccent
                : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
          ),
          padding: const EdgeInsets.all(2.0),
          child: SpritesWidget(100.0, 100.0, spritesData),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(name,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
      ],
    );
  }

  // future
  Future<Map<String, dynamic>> _getFuture(BuildContext context) async {
    // get data
    String url = UrlsModel.pokemonsGet + "/" + _name!;
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
        response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}