import 'package:dartz/dartz.dart';
import 'package:star_wars_app/core/errors/failure.dart';
import 'package:star_wars_app/core/model/pagination_model.dart';
import 'package:star_wars_app/features/characters/data/datasources/sw_datasource.dart';
import 'package:star_wars_app/features/characters/data/mappers/sw_character_to_entity_mapper.dart';
import 'package:star_wars_app/features/characters/data/mappers/sw_film_to_entity_mapper.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_films.dart';

abstract class SWRepository {
  Future<Either<Failure, Pagination<Character>>> getCharacter(
      ParamsToPagination params);

  Future<Either<Failure, List<Film>>> getFilm(List<int> ids);
}

class SWRepositoryImpl implements SWRepository {
  final SWRemoteDatasource repository;

  SWRepositoryImpl({required this.repository});

  @override
  Future<Either<Failure, Pagination<Character>>> getCharacter(
      ParamsToPagination params) async {
    try {
      final result = await repository.getCharacters(params);
      return Right(result.toEntity());
    } on Failure catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> getFilm(List<int> ids) async {
    try {
      final result =
          await Future.wait(ids.map((e) => repository.getFilm(e.toString())));
      return Right(result.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
