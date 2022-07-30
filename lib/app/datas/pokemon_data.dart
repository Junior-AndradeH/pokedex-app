// main class
class PokemonData {
  // variables
  String? name;

  int? id;
  int? weight;
  int? height;

  Map<String, dynamic>? sprites;

  List? abilities;
  List? forms;
  List? types;

  // constructor
  PokemonData();

  // data
  PokemonData.fromMap(Map<String, dynamic> map) {
    // map to string
    id = map["id"];
    name = map["name"];
    abilities = map["abilities"];
    forms = map["forms"];
    sprites = map["sprites"];
    types = map["types"];
    weight = map["weight"];
    height = map["height"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "abilities": abilities,
      "forms": forms,
      "sprites": sprites,
      "types": types,
      "weight": weight,
      "height": height,
    };
  }
}