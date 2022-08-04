// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/stats_data.dart';

import '../../models/colors_models.dart';

// main class
class MovesView extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;

  int? _hp;
  int? _atk;
  int? _def;
  int? _spAtk;
  int? _spDef;
  int? _speed;
  int? _total;

  // constructor
  MovesView(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variables
    _hp = StatsData.fromList(_pokemonData!.stats!, 0).baseStat;

    // return
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
    );
  }

  Widget _sizedBox(
      BuildContext context, String field, String text, double value) {
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
          Container(
            margin: const EdgeInsets.only(top: 7.0, left: 170.0),
            child: LinearProgressIndicator(
              minHeight: 4.0,
              backgroundColor: ColorsModel.grey,
              color: ColorsModel.green,
              value: value,
            ),
          ),
        ],
      ),
    );
  }
}