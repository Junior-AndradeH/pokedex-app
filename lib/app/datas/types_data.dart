// main class
class TypesData {
  // variables
  String? url;
  String? name;

  // constructor
  TypesData();

  // data
  TypesData.fromMap(Map<String, dynamic> map) {
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