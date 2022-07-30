// main class
class PokedexData {
  // variables
  String? url;
  String? name;

  // constructor
  PokedexData();

  // data
  PokedexData.fromMap(Map<String, dynamic> map) {
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