// import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/types_data.dart';

import '../../models/images_model.dart';
import '../../models/pokedex_model.dart';

// main class
class PokemonPage extends StatelessWidget {
  // variable
  PokemonData? _pokemonData;

  // constructor
  PokemonPage(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          _containerWallpaper(context),
          _containerList(context),
          _containerAppBar(context),
        ],
      ),
    );
  }

  Widget _containerWallpaper(BuildContext context){
    // set variables
    TypesData typesData0 = TypesData.fromMap(_pokemonData!.types![0]["type"]);
    TypesData typesData1 = TypesData.fromMap(
        _pokemonData!.types!.length <= 1 ? {} : _pokemonData!.types![1]["type"]);

    Color color1 = PokeDexModel.of(context).getColor(typesData0.name.toString())!;
    Color color2 = PokeDexModel.of(context).getColor(
        _pokemonData!.types!.length <= 1
            ? typesData0.name.toString()
            : typesData1.name.toString())!;

    // return
    return Container(
      decoration: BoxDecoration(
        gradient: PokeDexModel.of(context).getLinearGradient(color1, color2),
      ),
      height: 350.0,
    );
  }

  Widget _containerList(BuildContext context){
    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        const SizedBox(height: 280.0),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Expanded(
            child: Column(
              children: <Widget>[
                Text("teste"),
                Text("teste"),
                Text("teste"),
                Text("teste"),
                Text("teste"),
                Text("teste"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _containerAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0, left: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImagesModel.iconArrowLeftWhite)),
              ),
              width: 20.0,
              height: 20.0,
              margin: const EdgeInsets.all(10.0),
            ),
            onTap: () {
              // navigator
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: 40.0),
        ],
      ),
    );
  }
}