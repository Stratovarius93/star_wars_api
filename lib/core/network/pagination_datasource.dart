import 'package:star_wars_app/core/errors/exceptions.dart';
import 'package:star_wars_app/core/model/pagination_model.dart';
import 'package:star_wars_app/core/services/center_api.dart';
import 'package:star_wars_app/injector_container.dart';

class PaginationDataSource<T> {
  final String urlSpecific;
  final T Function(Map<String, dynamic> json) fromJson;

  PaginationDataSource({
    required this.urlSpecific,
    required this.fromJson,
  });

  Future<PaginationModel<T>> getPagination() async {
    try {
      CenterApi centerApi = sl<CenterApi>();
      final response = await centerApi.get(urlSpecific: urlSpecific);
      if (response.isSuccess) {
        final body = response.result;
        PaginationModel<T> paginationModel =
            PaginationModel<T>.fromJson(body, (e) => fromJson(e));
        return paginationModel;
      } else {
        throw GeneralException(response.message ?? "Ocurrió un error general");
      }
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }
}
