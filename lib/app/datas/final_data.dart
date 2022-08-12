// main class
class FinalData {
  // variables
  String? url;
  String? name;

  int? minLevel;

  Map<String, dynamic>? map;
  Map<String, dynamic>? species;

  List? evolutionDetails;

  bool? isBaby;

  // constructor
  FinalData();

  // data
  FinalData.fromList(List list, int index) {
    // list to map
    map = list.isEmpty ? {} : EvolvesTo(list[index]);
  }

  // map to data
  EvolvesTo(Map<String, dynamic> map) {
    // map to var
    evolutionDetails = ListToMap(map["evolution_details"], 0);
    isBaby = map["is_baby"];
    species = Species(map["species"]);
  }

  Species(Map<String, dynamic> map) {
    // map to string
    url = map["url"];
    name = map["name"];
  }

  MinLevel(Map<String, dynamic> map) {
    // map to int
    minLevel = map["min_level"];
  }

  ListToMap(List list, int index) {
    // map to list
    map = list.isEmpty ? {} : MinLevel(list[index]);
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