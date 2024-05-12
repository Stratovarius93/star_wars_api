import 'package:star_wars_app/core/model/pagination_model.dart';
import 'package:star_wars_app/features/characters/data/model/sw_character_model.dart';
import 'package:star_wars_app/features/characters/data/model/sw_film_model.dart';

abstract class SWRemoteDatasource {
  Future<PaginationModel<CharacterModel>> getCharacters(
      ParamsToPagination params);

  Future<FilmModel> getFilm(String id);
}
