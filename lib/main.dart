// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/ui/pages/pokedex_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app/models/pokedex_model.dart';

// master function
void main() {
  runApp(const PokeDexAPP());
}

// main class
class PokeDexAPP extends StatelessWidget {
  const PokeDexAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PokeDexModel>(
      model: PokeDexModel(),
      child: MaterialApp(
        home: PokeDexPage(),
      ),
    );
  }
}