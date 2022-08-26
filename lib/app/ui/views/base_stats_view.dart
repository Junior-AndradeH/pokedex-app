// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/stats_data.dart';

import '../../models/colors_model.dart';

// main class
class BaseStatsView extends StatelessWidget {
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
  BaseStatsView(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variables
    _hp = StatsData.fromList(_pokemonData!.stats!, 0).baseStat;
    _atk = StatsData.fromList(_pokemonData!.stats!, 1).baseStat;
    _def = StatsData.fromList(_pokemonData!.stats!, 2).baseStat;
    _spAtk = StatsData.fromList(_pokemonData!.stats!, 3).baseStat;
    _spDef = StatsData.fromList(_pokemonData!.stats!, 4).baseStat;
    _speed = StatsData.fromList(_pokemonData!.stats!, 5).baseStat;
    _total = _hp! + _atk! + _def! + _spAtk! + _spDef! + _speed!;

    // return
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          _sizedBox(context, "HP", _hp!.toString(), _hp! / 255),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Attack", _atk!.toString(), _atk! / 255),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Defense", _def!.toString(), _def! / 255),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Sp. Atk", _spAtk!.toString(), _spAtk! / 255),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Sp. Def", _spDef!.toString(), _spDef! / 255),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Speed", _speed!.toString(), _speed! / 255),
          const SizedBox(height: 10.0),
          _sizedBox(context, "Total", _total!.toString(), _total! / 700),
        ],
      ),
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