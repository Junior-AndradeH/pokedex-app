// main class
class EvolutionData {
  // variables
  String? url;
  String? name;

  Map<String, dynamic>? map;
  Map<String, dynamic>? chain;
  Map<String, dynamic>? species;

  List? list;
  List? evolutionDetails;
  List? evolvesTo;

  bool? isBaby;

  // constructor
  EvolutionData();

  // data
  EvolutionData.fromMap(Map<String, dynamic> map) {
    // map to list
    chain = Chain(map["chain"]);
  }

  Chain(Map<String, dynamic> map) {
    // map to string
    evolutionDetails = map["evolution_details"];
    evolvesTo = map["evolves_to"];
    species = Species(map["species"]);
    isBaby = map["is_baby"];
  }

  Species(Map<String, dynamic> map) {
    // map to string
    url = map["url"];
    name = map["name"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "url": url,
      "name": name,
    };
  }
}