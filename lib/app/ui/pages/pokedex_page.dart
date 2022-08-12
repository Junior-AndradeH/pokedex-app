// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/ui/widgets/pokeball_widget.dart';
import 'package:pokedexapp/app/ui/widgets/pokedex_widget.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_model.dart';
import '../../models/images_model.dart';
import '../../models/maps_models.dart';
import '../../models/pokedex_model.dart';
import '../../models/pokemon_model.dart';
import '../../models/urls_model.dart';

// main class
class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

// layout class
class _PokedexPageState extends State<PokedexPage> {
  // variables
  PokemonData? _pokemonData;

  String? _filter;
  String? _name;
  String? _type0;
  String? _type1;

  int? _start;
  int? _end;
  int? _limit;

  Color? _color;

  List? _pokedex;
  List<Widget>? _list;
  List<Widget>? _types;

  // widget
  @override
  Widget build(BuildContext context) {
    // set variable
    _pokedex ??= PokedexModel.of(context).getList();
    _start = 0;
    _end = 151;
    _filter ??= "all";
    _limit ??= 20;

    if (_limit! > _end!) {
      _limit = _end;
    }

    // return
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          Positioned(
            top: -70.0,
            right: -85.0,
            child:
                PokeballWidget(ImagesModel.iconPokeballGrey, 0.2, 250.0, 250.0),
          ),
          _listView(context),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        const SizedBox(height: 40.0),
        _containerAppBar(context),
        const SizedBox(height: 20.0),
        Wrap(
          direction: Axis.horizontal,
          spacing: 10.0,
          runSpacing: 10.0,
          children: _getList(context)!,
        ),
        const SizedBox(height: 20.0),
        _limit == _end ? Container() : _inkWellMore(context),
        _limit == _end ? Container() : const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _containerAppBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _inkWellAppBar(context, 0, ImagesModel.iconArrowLeftGreyDark),
            _inkWellAppBar(context, 1, ImagesModel.iconFilter),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: const <Widget>[
            SizedBox(width: 10.0),
            Text("Pokedex",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
          ],
        ),
      ],
    );
  }

  Widget _containerType(BuildContext context, String type) {
    // set variable
    _name = PokemonModel.of(context).getString(type);
    _color = PokemonModel.of(context).getColor(type);

    // return
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
            color: _color!,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          width: 85.0,
          height: 40.0,
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          alignment: Alignment.center,
          child: Text(_name!,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0)),
        ),
        onTap: () {
          // actived void
          _setData(context, type);
        },
      ),
    );
  }

  Widget _inkWellAppBar(BuildContext context, int index, String image) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image)),
        ),
        width: 20.0,
        height: 20.0,
        margin: const EdgeInsets.all(10.0),
      ),
      onTap: () {
        // actived void
        if (index == 1) {
          _setAlert(context);
        }
      },
    );
  }

  Widget _inkWellMore(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsModel.greyAccent,
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        alignment: Alignment.center,
        child: const Text("Carregar mais",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                shadows: <Shadow>[
                  Shadow(
                    color: ColorsModel.greyDark,
                    blurRadius: 12,
                    offset: Offset(2, 2),
                  ),
                ])),
      ),
      onTap: () {
        setState(() {
          // set variables
          _pokedex = [];
          _limit = _limit! + 20;
        });
      },
    );
  }

  // void
  void _setAlert(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Tipos",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0)),
                  _containerType(context, "all"),
                ],
              ),
              content: SizedBox(
                width: 300.0,
                height: 340.0,
                child: ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    Wrap(
                      children: _getTypes(context)!,
                    ),
                  ],
                ),
              ),
            ));
  }

  void _setData(BuildContext context, String type) {
    setState(() {
      _filter = type;
    });

    // navigator
    Navigator.of(context).pop();
  }

  // function
  List<Widget>? _getTypes(BuildContext context) {
    // set variable
    _types = [];

    int index;
    for (index = 0; index < MapsModel.list.length; index++) {
      // add to list
      _types!.add(_containerType(context, MapsModel.list[index]));
    }

    // return
    return _types;
  }

  List<Widget>? _getList(BuildContext context) {
    // set variable
    _list = [];

    int index;
    for (index = _start!; index < _limit! + 1; index++) {
      Widget widget = FutureBuilder<Map<String, dynamic>>(
          future: _getFuture(context, index),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.error != null) {
              return Container();
            } else {
              // data
              _pokemonData = PokemonData.fromMap(snapshot.data!);

              // set variables
              List list = snapshot.data!["types"];
              _type0 = PokemonData.fromList(list, 0).nameType;
              _type1 = list.length <= 1
                  ? _type0
                  : PokemonData.fromList(list, 1).nameType;

              // return
              return _filter == "all" || _filter == _type0 || _filter == _type1
                  ? PokeDexWidget(_pokemonData!)
                  : Container();
            }
          });

      // add to list
      _list!.add(widget);
    }

    // return
    return _list;
  }

  // future
  Future<Map<String, dynamic>> _getFuture(
      BuildContext context, int index) async {
    // get data
    String urlPokemon = UrlsModel.pokemonsGet + "/$index";
    Uri uriPokemon = Uri.parse(urlPokemon);
    http.Response responsePokemon = await http.get(uriPokemon);
    Map<String, dynamic> map =
        responsePokemon.body == "" ? {} : json.decode(responsePokemon.body);

    // return
    return map;
  }
}