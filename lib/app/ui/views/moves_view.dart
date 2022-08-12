// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/moves_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/ui/widgets/moves_widget.dart';

// main class
class MovesView extends StatelessWidget {
  // variables
  PokemonData? _pokemonData;
  MovesData? _movesData;

  List<Widget>? _list;

  // constructor
  MovesView(this._pokemonData);

  // widget
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getList(context)!,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  // function
  List<Widget>? _getList(BuildContext context) {
    // set variable
    _list = [];

    int index;
    for (index = 0; index < _pokemonData!.moves!.length; index++) {
      // data
      _movesData = MovesData.fromMap(_pokemonData!.moves![index]);

      // add to list
      _list!.add(MovesWidget(_movesData!));
    }

    // return
    return _list;
  }
}