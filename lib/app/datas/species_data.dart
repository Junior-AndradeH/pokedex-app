// main class
class SpeciesData {
  // variables
  String? url;
  String? name;
  String? group;

  int? genderRate;

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
    evolutionChain = Evolution(map["evolution_chain"]);
    genderRate = map["gender_rate"];
    name = map["name"];
  }

  SpeciesData.fromList(List list, int index) {
    // list to map
    map = EggGroups(list[index]);
  }

  // map to data
  EggGroups(Map<String, dynamic> map) {
    // map to string
    group = map["name"];
  }

  Evolution(Map<String, dynamic> map) {
    // map to string
    url = map["url"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "egg_groups": eggGroups,
      "evolution_chain": evolutionChain,
      "gender_rate": genderRate,
      "name": name,
    };
  }
}