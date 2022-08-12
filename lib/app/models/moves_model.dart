// import
import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/moves_data.dart';
import 'package:scoped_model/scoped_model.dart';

// main class
class MovesModel extends Model {
  // static
  static MovesModel of(BuildContext context) =>
      ScopedModel.of<MovesModel>(context);

  // variables
  MovesData? _movesData;

  Map<String, dynamic>? _map;

  List? _list;

  // void
  void setMap(Map<String, dynamic> map) {
    _map = map;

    notifyListeners();
  }

  void setList(List list) {
    _list = list;

    notifyListeners();
  }

  void setMovesData(MovesData movesData) {
    _movesData = movesData;

    notifyListeners();
  }

  // function
  Map<String, dynamic>? getMap() {
    if (_map == null || _map! == {}) {
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

  MovesData? getMovesData() {
    if (_movesData == null || _movesData == MovesData()) {
      _movesData = null;
    }

    return _movesData;
  }
}