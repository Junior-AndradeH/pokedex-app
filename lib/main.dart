// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/controllers/home_controller.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app/models/colors_model.dart';
import 'app/models/evolution_model.dart';
import 'app/models/moves_model.dart';
import 'app/models/pokedex_model.dart';
import 'app/models/pokemon_model.dart';
import 'app/models/species_model.dart';

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
        child: ScopedModel<SpeciesModel>(
          model: SpeciesModel(),
          child: ScopedModel<EvolutionModel>(
            model: EvolutionModel(),
            child: ScopedModel<MovesModel>(
              model: MovesModel(),
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
                home: const HomeController(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}