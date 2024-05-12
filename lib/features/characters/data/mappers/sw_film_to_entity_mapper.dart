import 'package:star_wars_app/features/characters/data/model/sw_film_model.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_films.dart';

extension GetFilmx on FilmModel {
  Film toEntity() => Film(
        title: title,
        director: director,
        releaseDate: releaseDate,
      );
}
