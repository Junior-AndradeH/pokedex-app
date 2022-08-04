// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/pokedex_data.dart';
import 'package:pokedexapp/app/datas/sprites_data.dart';
import 'package:pokedexapp/app/datas/types_data.dart';
import 'package:pokedexapp/app/ui/pages/pokemon_page.dart';
import 'package:pokedexapp/app/ui/widgets/pokeball_widget.dart';
import 'package:pokedexapp/app/ui/widgets/sprites_widget.dart';
import 'package:pokedexapp/app/ui/widgets/types_widget.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_models.dart';
import '../../models/images_model.dart';
import '../../models/pokedex_model.dart';

// main class
class PokeDexWidget extends StatelessWidget {
  // variables
  PokedexData? _pokedexData;
  PokemonData? _pokemonData;

  String? _type0;
  String? _type1;

  Color? _color0;
  Color? _color1;

  // constructor
  PokeDexWidget(this._pokedexData);

  // widget
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFuture(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: ColorsModel.whiteDark,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(ColorsModel.grey),
              ),
            );
          } else if (snapshot.error != null) {
            return Container();
          } else {
            // data
            _pokemonData = PokemonData.fromMap(snapshot.data!);

            // return
            return _inkWell(context, _pokemonData!);
          }
        });
  }

  Widget _inkWell(BuildContext context, PokemonData pokemonData) {
    // set variables
    _type0 = TypesData.fromList(pokemonData.types!, 0).name;
    _type1 = pokemonData.types!.length <= 1
        ? _type0
        : TypesData.fromList(pokemonData.types!, 1).name;

    _color0 = PokedexModel.of(context).getColor(_type0.toString())!;
    _color1 = PokedexModel.of(context).getColor(_type1.toString())!;

    // return
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        decoration: BoxDecoration(
          gradient:
              PokedexModel.of(context).getLinearGradient(_color0!, _color1!),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        width: 180.0,
        height: 150.0,
        child: Stack(
          children: <Widget>[
            _positionedPokeball(context),
            _positionedTypes(context, pokemonData),
            _positionedSprites(context, pokemonData),
          ],
        ),
      ),
      onTap: () {
        // actived void
        _setData(context, pokemonData);
      },
    );
  }

  Widget _positionedPokeball(BuildContext context) {
    return Positioned(
      right: -5.0,
      bottom: -5.0,
      child: PokeballWidget(ImagesModel.iconPokeballWhite, 0.4, 100.0, 100.0),
    );
  }

  Widget _positionedTypes(BuildContext context, PokemonData pokemonData) {
    // set variables
    _type0 = TypesData.fromList(pokemonData.types!, 0).name;
    _type1 = pokemonData.types!.length <= 1
        ? _type0
        : TypesData.fromList(pokemonData.types!, 1).name;

    // return
    return Positioned(
      top: 10.0,
      left: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(pokemonData.name!.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black,
                      blurRadius: 15.0,
                      offset: Offset(2, 2),
                    ),
                  ])),
          const SizedBox(height: 20.0),
          TypesWidget(_type0!),
          _type0 == _type1 ? Container() : const SizedBox(height: 5.0),
          _type0 == _type1 ? Container() : TypesWidget(_type1!),
        ],
      ),
    );
  }

  Widget _positionedSprites(BuildContext context, PokemonData pokemonData) {
    // set variable
    SpritesData spritesData = SpritesData.fromMap(pokemonData.sprites!);

    // return
    return Positioned(
      right: 0.0,
      bottom: 0.0,
      child: SpritesWidget(100.0, 100.0, spritesData),
    );
  }

  // void
  void _setData(BuildContext context, PokemonData pokemonData) {
    // navigator
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PokemonPage(pokemonData)));
  }

  // future
  Future<Map<String, dynamic>> _getFuture(BuildContext context) async {
    // get data
    String url = _pokedexData!.url.toString();
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
        response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}