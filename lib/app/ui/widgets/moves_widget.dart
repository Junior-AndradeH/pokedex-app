// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/moves_data.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_model.dart';
import '../../models/pokemon_model.dart';
import '../../models/urls_model.dart';

// main class
class MovesWidget extends StatelessWidget {
  // variables
  MovesData? _movesData;

  String? _type;
  String? _name;

  int? _power;

  Color? _color;

  // constructor
  MovesWidget(this._movesData);

  // widget
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFuture(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _container(context, "Loading...", "Loading...",
                "Loading...", ColorsModel.grey);
          } else if (snapshot.error != null) {
            return _container(context, "None", "None", "0", ColorsModel.grey);
          } else {
            // data
            MovesData movesData = MovesData.fromDocument(snapshot.data!);

            // set variables
            _type = PokemonModel.of(context).getString(movesData.nameType!);
            _name = PokemonModel.of(context).getString(movesData.name!);
            _color = PokemonModel.of(context).getColor(movesData.nameType!);
            _power = movesData.power ??= 0;

            // return
            return _container(
                context, _type!, _name!, _power!.toString(), _color!);
          }
        });
  }

  Widget _container(BuildContext context, String type, String name,
      String power, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _row("Type:", type, color),
          _richText("Name:", name),
          _richText("Power:", power),
        ],
      ),
    );
  }

  Widget _row(String field, String text, Color color) {
    return Row(
      children: <Widget>[
        Text(
          field,
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        const SizedBox(width: 5.0),
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _richText(String field, String text) {
    return RichText(
      text: TextSpan(
        text: "$field ",
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
        children: <TextSpan>[
          TextSpan(
              text: text,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0)),
        ],
      ),
    );
  }

  // future
  Future<Map<String, dynamic>> _getFuture(BuildContext context) async {
    // get data
    String url = UrlsModel.movesGet + "/" + _movesData!.name!;
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    Map<String, dynamic> map =
        response.body == "" ? {} : json.decode(response.body);

    // return
    return map;
  }
}