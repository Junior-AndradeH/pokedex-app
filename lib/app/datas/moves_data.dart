// main class
class MovesData {
  // variables
  String? url;
  String? urlType;
  String? name;
  String? nameType;

  int? id;
  int? accuracy;
  int? power;

  Map<String, dynamic>? map;
  Map<String, dynamic>? move;
  Map<String, dynamic>? type;

  List? list;

  // constructor
  MovesData();

  // data
  MovesData.fromDocument(Map<String, dynamic> map) {
    // map to var
    accuracy = map["accuracy"];
    name = map["name"];
    power = map["power"];
    type = Type(map["type"]);
  }

  MovesData.fromMap(Map<String, dynamic> map) {
    // map to string
    move = Move(map["move"]);
  }

  // map to data
  Move(Map<String, dynamic> map) {
    // map to string
    url = map["url"];
    name = map["name"];
  }

  Type(Map<String, dynamic> map) {
    // map to string
    urlType = map["url"];
    nameType = map["name"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "url": url,
      "name": name,
    };
  }
}