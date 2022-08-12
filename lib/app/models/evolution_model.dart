// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/final_data.dart';
import 'package:pokedexapp/app/datas/middle_data.dart';
import 'package:pokedexapp/app/datas/pokemon_data.dart';
import 'package:pokedexapp/app/datas/start_data.dart';
import 'package:scoped_model/scoped_model.dart';

import 'colors_model.dart';

// main class
class EvolutionModel extends Model {
  // static
  static EvolutionModel of(BuildContext context) =>
      ScopedModel.of<EvolutionModel>(context);

  // variables
  StartData? _startData;
  MiddleData? _middleData;
  FinalData? _finalData;

  Map<String, dynamic>? _map;

  List? _list;

  // void
  void setStartData(StartData startData) {
    _startData = startData;

    notifyListeners();
  }

  void setMiddleData(MiddleData middleData) {
    _middleData = middleData;

    notifyListeners();
  }

  void setFinalData(FinalData finalData) {
    _finalData = finalData;

    notifyListeners();
  }

  void setMap(Map<String, dynamic>? map) {
    _map = map;

    notifyListeners();
  }

  void setList(List list) {
    _list = list;

    notifyListeners();
  }

  // function
  StartData? getStartData() {
    if (_startData == null || _startData == StartData()) {
      _startData = null;
    }

    return _startData;
  }

  MiddleData? getMiddleData() {
    if (_middleData == null || _middleData == MiddleData()) {
      _middleData = null;
    }

    return _middleData;
  }

  FinalData? getFinalData() {
    if (_finalData == null || _finalData == FinalData()) {
      _finalData = null;
    }

    return _finalData;
  }

  Map<String, dynamic>? getMap() {
    if (_map == null || _map == {}) {
      _map = {};
    }

    return _map;
  }

  List? getList() {
    if (_list == null || _list!.isEmpty) {
      _list = [];
    }

    return _list;
  }
}