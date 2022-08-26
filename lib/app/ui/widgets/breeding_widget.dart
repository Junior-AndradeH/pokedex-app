// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/species_data.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_model.dart';
import '../../models/images_model.dart';
import '../../models/pokemon_model.dart';
import '../../models/species_model.dart';
import '../../models/urls_model.dart';

// main class
class BreedingWidget extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;
  SpeciesData? _speciesData;

  String? _eggGroups;
  String? _eggCycle;

  Widget? _widget;

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
            SpeciesModel.of(context).setSpeciesData(_speciesData!);

            // return
            return _columnData(context, _speciesData!);
          }
        });
  }

  Widget _columnNull(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBoxEgg(context, "Egg Groups", "None"),
        const SizedBox(height: 10.0),
        _sizedBoxEgg(context, "Egg Cycle", "None"),
      ],
    );
  }

  Widget _columnData(BuildContext context, SpeciesData speciesData) {
    // set variables
    _eggGroups = SpeciesData.fromList(speciesData.eggGroups!, 0).group;
    _eggCycle = speciesData.eggGroups!.length <= 1
        ? _eggGroups
        : SpeciesData.fromList(speciesData.eggGroups!, 1).group;

    // convert
    String eggGroups = PokemonModel.of(context).getString(_eggGroups!)!;
    String eggCycle = PokemonModel.of(context).getString(_eggCycle!)!;

    // return
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sizedBoxGenre(context, speciesData),
        const SizedBox(height: 10.0),
        _sizedBoxEgg(context, "Egg Groups", eggGroups),
        const SizedBox(height: 10.0),
        _sizedBoxEgg(context, "Egg Cycle", eggCycle),
      ],
    );
  }

  Widget _sizedBoxGenre(BuildContext context, SpeciesData speciesData) {
    // set variable
    if(speciesData.genderRate == 1){
      _widget = _rowStatic(ImagesModel.iconMaleBlue, "Male only");
    }else if(speciesData.genderRate == 2 || speciesData.genderRate == 3){
      _widget = _rowGender(">", "Greater chances for male");
    }else if(speciesData.genderRate == 4){
      _widget = _rowGender("=", "Equal rate");
    }else if(speciesData.genderRate == 5 || speciesData.genderRate == 6){
      _widget = _rowGender("<", "Greater chances for female");
    }else if(speciesData.genderRate == 7){
      _widget = _rowStatic(ImagesModel.iconFemalePink, "Female only");
    }else{
      _widget = _rowStatic(ImagesModel.iconUnknownYellow, "Unknown");
    }

    // return
    return Stack(
      children: <Widget>[
        const Text("Gender",
            style: TextStyle(
                color: ColorsModel.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
        Container(
          margin: const EdgeInsets.only(left: 120.0),
          child: _widget!,
        ),
      ],
    );
  }

  Widget _sizedBoxEgg(BuildContext context, String field, String text) {
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

  Widget _rowStatic(String image, String text) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image)),
          ),
          width: 14.0,
          height: 14.0,
        ),
        Text("  $text",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
      ],
    );
  }

  Widget _rowGender(String text, String description) {
    return Wrap(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(ImagesModel.iconMaleBlue)),
          ),
          width: 14.0,
          height: 14.0,
        ),
        Text("  $text  ",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(ImagesModel.iconFemalePink)),
          ),
          width: 14.0,
          height: 14.0,
        ),
        Text("  ($description)",
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
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
    String url = UrlsModel.speciesGet + "/${_pokemonData!.id}";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
    response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}