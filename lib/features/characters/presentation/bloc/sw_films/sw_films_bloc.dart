import 'package:dartz/dartz.dart';
import 'package:star_wars_app/core/data_base/base_data_bloc.dart';
import 'package:star_wars_app/core/errors/failure.dart';
import 'package:star_wars_app/features/characters/data/repositories/sw_repositories.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_films.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_films/sw_films_params.dart';

class SWFilmsBloc extends BaseDataBloc<List<Film>, SWFilmsParams> {
  final SWRepository repository;
  SWFilmsBloc({required super.hasConnection, required this.repository});

  @override
  Future<Either<Failure, List<Film>>> repositoryCall(SWFilmsParams? params) {
    return repository.getFilm(params!.ids);
  }
}
