// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/ui/pages/pokedex_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app/models/colors_models.dart';
import 'app/models/pokedex_model.dart';
import 'app/models/pokemon_model.dart';

// master function
void main() {
  runApp(const PokeDexAPP());
}

// main class
class PokeDexAPP extends StatelessWidget {
  const PokeDexAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PokedexModel>(
      model: PokedexModel(),
      child: ScopedModel<PokemonModel>(
        model: PokemonModel(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: ColorsModel.greyDark,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
            ).copyWith(
              secondary: ColorsModel.greyDark,
            ),
            fontFamily: "Inter",
          ),
          debugShowCheckedModeBanner: true,
          home: PokeDexPage(),
        ),
      ),
    );
  }
}