// import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/sprites_data.dart';
import 'package:pokedexapp/app/datas/types_data.dart';
import 'package:pokedexapp/app/ui/views/about_view.dart';
import 'package:pokedexapp/app/ui/views/base_stats_view.dart';
import 'package:pokedexapp/app/ui/views/evolution_view.dart';
import 'package:pokedexapp/app/ui/views/moves_view.dart';
import 'package:pokedexapp/app/ui/widgets/pokeball_widget.dart';
import 'package:pokedexapp/app/ui/widgets/types_widget.dart';

import '../../models/colors_model.dart';
import '../../models/images_model.dart';
import '../../models/pokedex_model.dart';

// main class
class PokemonPage extends StatefulWidget {
  // variable
  PokemonData? _pokemonData;

  // constructor
  PokemonPage(this._pokemonData);

  // widget
  @override
  State<PokemonPage> createState() => _PokemonPageState(_pokemonData);
}

// layout class
class _PokemonPageState extends State<PokemonPage> {
  // variables
  PokemonData? _pokemonData;

  String? _sprite;
  String? _type0;
  String? _type1;
  String? _register;

  int? _pos;

  bool? _like;

  // constructor
  _PokemonPageState(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variables
    _sprite = SpritesData.fromMap(_pokemonData!.sprites!).frontDefault;
    _type0 = TypesData.fromList(_pokemonData!.types!, 0).name;
    _type1 = _pokemonData!.types!.length <= 1
        ? _type0
        : TypesData.fromList(_pokemonData!.types!, 1).name;
    _pos ??= 0;
    _like ??= false;

    // return
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
          _positioned(context),
          _columnAppBar(context),
          _containerView(),
        ],
      ),
    );
  }

  Widget _containerWallpaper(BuildContext context) {
    // set variables
    Color color1 = PokedexModel.of(context).getColor(_type0.toString())!;
    Color color2 = PokedexModel.of(context).getColor(_type1.toString())!;

    // return
    return Container(
      decoration: BoxDecoration(
        gradient: PokedexModel.of(context).getLinearGradient(color1, color2),
      ),
      height: 280.0,
    );
  }

  Widget _containerSprite() {
    return Hero(
      tag: "hero",
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(_sprite!),
              fit: BoxFit.cover),
        ),
        width: 160.0,
        height: 160.0,
      ),
    );
  }

  Widget _containerView() {
    return Container(
      margin: const EdgeInsets.only(top: 325.0),
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          [
            AboutView(_pokemonData!),
            BaseStatsView(_pokemonData!),
            EvolutionView(_pokemonData!),
            MovesView(_pokemonData!),
          ].elementAt(_pos!)
        ],
      ),
    );
  }

  Widget _positioned(BuildContext context) {
    return Positioned(
      top: 15.0,
      right: -60.0,
      child: PokeballWidget(ImagesModel.iconPokeballWhite, 0.4, 300.0, 300.0),
    );
  }

  Widget _columnAppBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 35.0),
        SizedBox(
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 10.0,
                right: 10.0,
                child: _row(context),
              ),
              Positioned(
                top: 60.0,
                left: 20.0,
                child: _columnData(),
              ),
              Positioned(
                top: 50.0,
                right: 5.0,
                child: _containerSprite(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40.0),
              _stack(context),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _columnData() {
    // set variable
    if (_pokemonData!.id! < 10) {
      _register = "#00${_pokemonData!.id}";
    } else if (_pokemonData!.id! < 100) {
      _register = "#0${_pokemonData!.id}";
    } else {
      _register = "#${_pokemonData!.id}";
    }

    // return
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_register!,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0)),
        const SizedBox(height: 20.0),
        Text(_pokemonData!.name!.toUpperCase(),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28.0)),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            TypesWidget(_type0),
            _type0 == _type1 ? Container() : const SizedBox(width: 10.0),
            _type0 == _type1 ? Container() : TypesWidget(_type1),
          ],
        ),
      ],
    );
  }

  Widget _row(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _inkWellButton(context, 0, ImagesModel.iconArrowLeftWhite),
        _inkWellButton(
            context,
            1,
            _like == false
                ? ImagesModel.iconHeartOutlineWhite
                : ImagesModel.iconHeartSolidWhite),
      ],
    );
  }

  Widget _stack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: ColorsModel.greyAccent, width: 1.0)),
          ),
          margin: const EdgeInsets.only(top: 19.0, left: 20.0, right: 20.0),
          padding: const EdgeInsets.only(bottom: 20.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _inkWellBar(context, 0, "Sobre"),
            _inkWellBar(context, 1, "Base Stats"),
            _inkWellBar(context, 2, "Evoluções"),
            _inkWellBar(context, 3, "Movimentos"),
          ],
        ),
      ],
    );
  }

  Widget _inkWellButton(BuildContext context, int index, String image) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image)),
          ),
          width: index == 0 ? 20.0 : 25.0,
          height: index == 0 ? 20.0 : 25.0,
        ),
      ),
      onTap: () {
        // actived void
        _setData(context, index);
      },
    );
  }

  Widget _inkWellBar(BuildContext context, int index, String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: index == _pos ? Colors.blue : ColorsModel.greyAccent,
                  width: 1.0)),
        ),
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(text,
            style: TextStyle(
                color: index == _pos ? Colors.black : ColorsModel.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
      ),
      onTap: () {
        setState(() {
          _pos = index;
        });
      },
    );
  }

  // void
  void _setData(BuildContext context, int index) {
    if (index == 0) {
      // navigator
      Navigator.of(context).pop();
    } else {
      setState(() {
        if (_like == false) {
          _like = true;
        } else {
          _like = false;
        }
      });
    }
  }
}