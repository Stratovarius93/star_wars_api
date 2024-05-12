import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';

class Character {
  final String name;
  final int height;
  final double mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final Gender gender;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final DateTime created;
  final DateTime edited;
  final String url;

  Character(
      {required this.name,
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
      required this.url});
}
