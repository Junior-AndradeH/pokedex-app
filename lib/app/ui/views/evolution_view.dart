// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/final_data.dart';
import 'package:pokedexapp/app/datas/middle_data.dart';
import 'package:pokedexapp/app/datas/start_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/species_data.dart';
import 'package:pokedexapp/app/ui/widgets/pokemon_widget.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_model.dart';
import '../../models/images_model.dart';
import '../../models/species_model.dart';

// main class
class EvolutionView extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;
  SpeciesData? _speciesData;
  StartData? _startData;
  MiddleData? _middleData;
  FinalData? _finalData;

  // constructor
  EvolutionView(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variable
    _speciesData = SpeciesModel.of(context).getSpeciesData();

    // return
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFuture(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 300.0,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(ColorsModel.grey),
              ),
            );
          } else if (snapshot.error != null) {
            return Container();
          } else {
            return _columnData(context, snapshot.data!);
          }
        });
  }

  Widget _columnData(BuildContext context, Map<String, dynamic> map) {
    // data
    _startData = StartData.fromMap(map);
    _middleData = _startData!.middleData;
    _finalData = _startData!.middleData!.finalData;

    // return
    return _middleData == null || _middleData!.name == null
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 300.0,
            alignment: Alignment.center,
            child: const Text("Only way",
                style: TextStyle(
                    color: ColorsModel.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20.0),
              _row(context, _startData!.name!, _middleData!.name!,
                  _middleData!.minLevel == null ? 0 : _middleData!.minLevel!),
              _finalData == null || _finalData!.name == null
                  ? Container()
                  : const SizedBox(height: 10.0),
              _finalData == null || _finalData!.name == null
                  ? Container()
                  : _row(context, _middleData!.name!, _finalData!.name!,
                      _finalData!.minLevel == null ? 0 : _finalData!.minLevel!),
            ],
          );
  }

  Widget _columnLevel(BuildContext context, String image, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
          width: 20.0,
          height: 20.0,
        ),
        const SizedBox(height: 10.0),
        Text(name,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
      ],
    );
  }

  Widget _row(
      BuildContext context, String nameLeft, String nameRight, int level) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PokemonWidget(_pokemonData!.name!, nameLeft),
        _columnLevel(context, ImagesModel.iconArrowRightGrey, "Lvl $level"),
        PokemonWidget(_pokemonData!.name!, nameRight),
      ],
    );
  }

  // future
  Future<Map<String, dynamic>> _getFuture(BuildContext context) async {
    // get data
    String url = _speciesData!.url.toString();
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
        response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}