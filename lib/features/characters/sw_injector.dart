import 'package:get_it/get_it.dart';
import 'package:star_wars_app/features/characters/data/datasources/sw_datasource.dart';
import 'package:star_wars_app/features/characters/data/network/sw_datasource_impl.dart';
import 'package:star_wars_app/features/characters/data/repositories/sw_repositories.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_films/sw_films_bloc.dart';
import 'package:star_wars_app/features/characters/presentation/bloc/sw_list/sw_list_bloc.dart';

class SWInjector {
  SWInjector.init(GetIt sl) {
    //=======================
    // Blocs
    //=======================
    sl
      ..registerFactory(() => SWListBloc<Character>(
            getSWCharacter: (p0) => sl<SWRepository>().getCharacter(p0),
          ))
      ..registerFactory(
          () => SWFilmsBloc(repository: sl(), hasConnection: sl()));

    //=======================
    // Repositories
    //=======================
    sl.registerLazySingleton<SWRepository>(
      () => SWRepositoryImpl(repository: sl()),
    );

    //=======================
    // DataSource
    //======================
    sl.registerLazySingleton<SWRemoteDatasource>(
        () => SWDataSourceImpl(centerApi: sl()));
  }
}
