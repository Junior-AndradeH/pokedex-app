// main class
class MapsModel {
  // static
  static const Map<String, dynamic> pokemon1 = {
    "id": 1,
    "image": "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
    "name": "Bulbasaur",
    "type": ["Grass", "Poison"],
    "weaknesses": ["Fire", "Psychic", "Flying", "Ice"],
    "about": {
      "weight": 6.9,
      "height": 0.7,
      "abilities": ["Overgrow"],
      "category": "Seed",
      "gender": [87.5, 12.5],
      "egg_groups": "Monster",
      "egg_cycle": "Grass",
    },
    "base_stats": {
      "hp": 45,
      "attack": 49,
      "defense": 49,
      "sp.atk": 65,
      "sp.def": 65,
      "speed": 45,
      "total": 318,
      "type_defenses": "test",
    },
    "shyne": {
      "option": true,
      "image":
          "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
    },
    "evolution": [
      {
        "id": 2,
        "level": 16,
        "image":
            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
        "form": "Leaf Stone",
      },
      {
        "id": 3,
        "level": 32,
        "image":
            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
        "form": "Leaf Stone",
      },
    ],
    "moves": [],
  };

  static const List<String> list = [
    "bug",
    "dark",
    "dragon",
    "electric",
    "fairy",
    "fighting",
    "fire",
    "flying",
    "ghost",
    "grass",
    "ground",
    "ice",
    "normal",
    "poison",
    "psychic",
    "rock",
    "steel",
    "water",
  ];
}