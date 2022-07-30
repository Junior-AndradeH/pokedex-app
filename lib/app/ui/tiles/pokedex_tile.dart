// import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedexapp/app/datas/pokedex_data.dart';
import 'package:pokedexapp/app/ui/widgets/pokedex_widget.dart';
import 'package:http/http.dart' as http;

import '../../models/colors_models.dart';
import '../../models/images_model.dart';
import '../../models/pokedex_model.dart';
import '../../models/urls_model.dart';

// main class
class PokeDexTile extends StatelessWidget {
  // variables
  PokedexData? _pokedexData;

  String? _filter;

  DateTime? _dateTime;

  List? _pokedex;
  List<Widget>? _list;

  // constructor
  PokeDexTile(this._dateTime, this._filter);

  // widget
  @override
  Widget build(BuildContext context) {
    // set variable
    _pokedex = PokeDexModel.of(context).getList();

    // return
    return _pokedex!.isNotEmpty
        ? _listView(context, _pokedex!)
        : FutureBuilder<List>(
            future: _getFuture(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: ColorsModel.whiteDark,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.grey,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorsModel.grey),
                  ),
                );
              } else if (snapshot.error != null) {
                return _listView(context, []);
              } else {
                // model
                PokeDexModel.of(context).setList(snapshot.data!);

                // return
                return _listView(context, snapshot.data!);
              }
            });
  }

  Widget _listView(BuildContext context, List list) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        const SizedBox(height: 40.0),
        _container(context),
        const SizedBox(height: 20.0),
        Wrap(
          direction: Axis.horizontal,
          spacing: 10.0,
          runSpacing: 10.0,
          children: _getList(context, list)!,
        ),
        const SizedBox(height: 80.0),
      ],
    );
  }

  Widget _container(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _inkWell(context, 0, ImagesModel.iconArrowLeftGreyDark),
            _inkWell(context, 1, ImagesModel.iconBack),
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

  Widget _inkWell(BuildContext context, int index, String image){
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(image)),
        ),
        width: 20.0,
        height: 20.0,
        margin: const EdgeInsets.all(10.0),
      ),
      onTap: () {
        // navigator
      },
    );
  }

  // function
  List<Widget>? _getList(BuildContext context, List list) {
    // set variable
    _list = [];

    int index;
    for (index = 0; index < list.length; index++) {
      // data
      _pokedexData = PokedexData.fromMap(list[index]);

      // add to list
      if (_filter == "all") {
        _list!.add(PokeDexWidget(_pokedexData!));
      } else {
        if (_filter == "all") {
          _list!.add(PokeDexWidget(_pokedexData!));
        }
      }
    }

    // return
    return _list;
  }

  // future
  Future<List> _getFuture(BuildContext context) async {
    // get data
    String url = UrlsModel.pokemonsGet;
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    List list = response.body == "" ? [] : json.decode(response.body)["results"];

    // return
    return list;
  }
}