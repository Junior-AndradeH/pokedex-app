// import
import 'package:flutter/material.dart';

import '../../models/colors_model.dart';

// main class
class TypesWidget extends StatelessWidget {
  // variable
  String? _name;

  // constructor
  TypesWidget(this._name);

  // widget
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsModel.white.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Text(_name!.toString().toUpperCase(),
          style: const TextStyle(
              color: ColorsModel.whiteDark,
              fontWeight: FontWeight.bold,
              fontSize: 14.0)),
    );
  }
}