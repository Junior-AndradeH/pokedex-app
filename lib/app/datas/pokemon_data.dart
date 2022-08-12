// main class
class PokemonData {
  // variables
  String? urlType;
  String? name;
  String? nameType;

  int? id;
  int? weight;
  int? height;

  Map<String, dynamic>? species;
  Map<String, dynamic>? sprites;
  Map<String, dynamic>? type;

  List? abilities;
  List? moves;
  List? forms;
  List? stats;
  List? types;

  // constructor
  PokemonData();

  // data
  PokemonData.fromMap(Map<String, dynamic> map) {
    // map to string
    id = map["id"];
    name = map["name"];
    abilities = map["abilities"];
    moves = map["moves"];
    forms = map["forms"];
    species = map["species"];
    sprites = map["sprites"];
    stats = map["stats"];
    types = map["types"];
    weight = map["weight"];
    height = map["height"];
  }

  PokemonData.fromList(List list, int index) {
    // list to map
    type = list.isEmpty
        ? {}
        : Type(list[index]["type"]);
  }

  // map to data
  Type(Map<String, dynamic> map) {
    // map to string
    urlType = map["url"];
    nameType = map["name"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "abilities": abilities,
      "moves": moves,
      "forms": forms,
      "species": species,
      "sprites": sprites,
      "stats": stats,
      "types": types,
      "weight": weight,
      "height": height,
    };
  }
}