// main class
class TypesData {
  // variables
  String? url;
  String? name;

  Map<String, dynamic>? map;

  List? list;
  List? types;

  // constructor
  TypesData();

  // data
  TypesData.fromMap(Map<String, dynamic> map) {
    // map to list
    types = map["types"];
  }

  TypesData.fromList(List list, int index) {
    // list to map
    map = Types(list[index]["type"]);
  }

  // map to data
  Types(Map<String, dynamic> map) {
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