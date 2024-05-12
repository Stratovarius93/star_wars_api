import 'package:star_wars_app/core/errors/exceptions.dart';
import 'package:star_wars_app/core/model/pagination_model.dart';
import 'package:star_wars_app/core/model/server_response_model.dart';
import 'package:star_wars_app/core/network/pagination_datasource.dart';
import 'package:star_wars_app/core/services/center_api.dart';
import 'package:star_wars_app/features/characters/data/datasources/sw_datasource.dart';
import 'package:star_wars_app/features/characters/data/model/sw_character_model.dart';
import 'package:star_wars_app/features/characters/data/model/sw_film_model.dart';
import 'package:star_wars_app/features/characters/sw_server.dart';

class SWDataSourceImpl extends SWRemoteDatasource {
  final CenterApi centerApi;

  SWDataSourceImpl({required this.centerApi});
  @override
  Future<PaginationModel<CharacterModel>> getCharacters(
      ParamsToPagination params) async {
    return await PaginationDataSource<CharacterModel>(
      urlSpecific: SWServer.listCharacters(
        page: params.pageToUrl,
        pageSize: params.pageSizeToUrl,
      ),
      fromJson: (e) => CharacterModel.fromJson(e),
    ).getPagination();
  }

  @override
  Future<FilmModel> getFilm(String id) async {
    try {
      ServerResponse response;
      response = await centerApi.get(urlSpecific: SWServer.getFilm(id));
      if (response.isSuccess) {
        final body = response.result;
        return FilmModel.fromJson(body);
      } else {
        throw GeneralException(response.message ?? "Ocurrió un error general");
      }
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }
}
