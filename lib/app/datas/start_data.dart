// import
import 'package:pokedexapp/app/datas/middle_data.dart';

// main class
class StartData {
  // variables
  MiddleData? middleData;

  String? url;
  String? name;

  int? minLevel;

  Map<String, dynamic>? map;
  Map<String, dynamic>? chain;
  Map<String, dynamic>? species;

  List? evolutionDetails;
  List? evolvesTo;

  bool? isBaby;

  // constructor
  StartData();

  // data
  StartData.fromMap(Map<String, dynamic> map) {
    // map to var
    chain = Chain(map["chain"]);
  }

  StartData.fromData(List list, int index) {
    // list to map
    middleData = MiddleData.fromList(list, index);
  }

  // map to data
  Chain(Map<String, dynamic> map) {
    // map to var
    evolutionDetails = map["evolution_details"];
    middleData = MiddleData.fromList(map["evolves_to"], 0);
    isBaby = map["is_baby"];
    species = Species(map["species"]);
  }

  Species(Map<String, dynamic> map) {
    // map to string
    url = map["url"];
    name = map["name"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "isBaby": isBaby,
      "url": url,
      "name": name,
    };
  }
}