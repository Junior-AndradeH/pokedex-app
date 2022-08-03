// main class
class AbilitiesData {
  // variables
  String? url;
  String? name;

  Map<String, dynamic>? map;

  List? list;

  // constructor
  AbilitiesData();

  // data
  AbilitiesData.fromList(List list, int index) {
    // list to map
    map = Ability(list[index]["ability"]);
  }

  Ability(Map<String, dynamic> map) {
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