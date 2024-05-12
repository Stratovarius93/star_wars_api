import 'package:star_wars_app/core/model/pagination_model.dart';
import 'package:star_wars_app/features/characters/data/model/sw_character_model.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';

extension GetCharactersDataX on PaginationModel<CharacterModel> {
  Pagination<Character> toEntity() => Pagination<Character>(
        count: count,
        next: next,
        previous: previous,
        results: results.map((e) => e.toEntity()).toList(),
      );
}

extension GetCharacterX on CharacterModel {
  Character toEntity() => Character(
        name: name,
        height: height,
        mass: mass,
        hairColor: hairColor,
        skinColor: skinColor,
        eyeColor: eyeColor,
        birthYear: birthYear,
        created: created,
        edited: edited,
        films: films,
        gender: gender,
        homeworld: homeworld,
        species: species,
        starships: starships,
        url: url,
        vehicles: vehicles,
      );
}
