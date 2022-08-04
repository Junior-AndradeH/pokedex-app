// main class
class SpeciesData {
  // variables
  String? url;
  String? name;

  Map<String, dynamic>? map;
  Map<String, dynamic>? evolutionChain;

  List? list;
  List? eggGroups;

  // constructor
  SpeciesData();

  // data
  SpeciesData.fromMap(Map<String, dynamic> map) {
    // map to list
    eggGroups = map["egg_groups"];
    evolutionChain = map["evolution_chain"];
  }

  SpeciesData.fromList(List list, int index) {
    // list to map
    map = EggGroups(list[index]);
  }

  EggGroups(Map<String, dynamic> map) {
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