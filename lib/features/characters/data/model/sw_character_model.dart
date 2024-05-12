import 'package:star_wars_app/core/helper/utils_helper.dart';
import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';

class CharacterModel {
  String name;
  int height;
  double mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  Gender gender;
  String homeworld;
  List<String> films;
  List<String> species;
  List<String> vehicles;
  List<String> starships;
  DateTime created;
  DateTime edited;
  String url;

  CharacterModel({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        name: json["name"] as String? ?? '',
        height: AppUtils.instance.jsonToInt(json["height"]),
        mass: AppUtils.instance.jsonToDouble(json["mass"]),
        hairColor: json["hair_color"] as String? ?? '',
        skinColor: json["skin_color"] as String? ?? '',
        eyeColor: json["eye_color"] as String? ?? '',
        birthYear: json["birth_year"] as String? ?? '',
        gender: genderValues.map[json["gender"]] ?? Gender.none,
        homeworld: json["homeworld"] as String? ?? '',
        films: List<String>.from(json["films"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        created: DateTime.parse(json["created"]) as DateTime? ?? DateTime.now(),
        edited: DateTime.parse(json["edited"]) as DateTime? ?? DateTime.now(),
        url: json["url"] as String? ?? '',
      );
}
