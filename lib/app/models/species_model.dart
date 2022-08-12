// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/species_data.dart';
import 'package:scoped_model/scoped_model.dart';

// main class
class SpeciesModel extends Model {
  // static
  static SpeciesModel of(BuildContext context) =>
      ScopedModel.of<SpeciesModel>(context);

  // variables
  SpeciesData? _speciesData;

  List? _list;

  // void
  void setList(List list) {
    _list = list;

    notifyListeners();
  }

  void setSpeciesData(SpeciesData speciesData) {
    _speciesData = speciesData;

    notifyListeners();
  }

  // function
  List? getList() {
    if (_list == null || _list!.isEmpty) {
      _list = [];
    }

    return _list;
  }

  SpeciesData? getSpeciesData() {
    if (_speciesData == null || _speciesData == SpeciesData()) {
      _speciesData = null;
    }

    return _speciesData;
  }
}