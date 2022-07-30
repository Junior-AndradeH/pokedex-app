// main class
class SpritesData {
  // variables
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? backDefault;
  String? backFemale;
  String? backShiny;

  // constructor
  SpritesData();

  // data
  SpritesData.fromMap(Map<String, dynamic> map) {
    // map to string
    frontDefault = map["front_default"];
    frontFemale = map["front_female"];
    frontShiny = map["front_shiny"];
    backDefault = map["back_default"];
    backFemale = map["back_female"];
    backShiny = map["back_shiny"];
  }

  // string to map
  Map<String, dynamic> toMap() {
    return {
      "front_default": frontDefault,
      "front_female": frontFemale,
      "front_shiny": frontShiny,
      "back_default": backDefault,
      "back_female": backFemale,
      "back_shiny": backShiny,
    };
  }
}