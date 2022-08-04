// main class
class StatsData {
  // variables
  String? url;
  String? name;

  int? baseStat;

  Map<String, dynamic>? map;
  Map<String, dynamic>? stat;

  List? list;

  // constructor
  StatsData();

  // data
  StatsData.fromList(List list, int index) {
    // list to map
    map = BaseStats(list[index]);
  }

  BaseStats(Map<String, dynamic> map) {
    // map to string
    baseStat = map["base_stat"];
    stat = map["stat"];
  }

  Stat(Map<String, dynamic> map) {
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