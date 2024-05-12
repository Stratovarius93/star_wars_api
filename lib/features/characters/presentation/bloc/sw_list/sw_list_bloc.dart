import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/errors/failure.dart';
import 'package:star_wars_app/core/model/fetch_response.dart';
import 'package:star_wars_app/core/model/pagination_model.dart';
import 'package:star_wars_app/core/utils/constants.dart';

import 'sw_list_event.dart';
import 'sw_list_state.dart';

const _pageSize = AppConstants.sizePageInfinityScroll;

class SWListBloc<T> extends Bloc<SWListEvent<T>, SWListState<T>> {
  final Future<Either<Failure, Pagination<T>>> Function(
      ParamsToPagination params) getSWCharacter;
  SWListBloc({required this.getSWCharacter}) : super(SWListState<T>()) {
    on<SWListFetchEvent<T>>(_fetchList, transformer: concurrent());
    on<SWListResetEvent<T>>(_reset);
  }
  Future<void> _fetchList(
      SWListFetchEvent<T> event, Emitter<SWListState<T>> emit) async {
    emit(state.copyWith(status: SWListStatus.loading));

    ParamsToPagination data = ParamsToPagination(
      page: event.totalItems ?? state.values.length,
    );
    final res2 = await getSWCharacter(data);
    res2.fold((l) {
      String message = (l as GeneralFailure).msg;
      emit(state.copyWith(
        status: SWListStatus.fail,
        message: message,
      ));
    }, (r) {
      late Pagination<T> pagination;
      pagination = r;
      final fetchResponse = FetchResponse<T>(
        list: pagination.results,
        totalItems: pagination.count,
        totalPages: (pagination.count / _pageSize).ceil(),
      );
      final d = event.clearList
          ? List<T>.from(fetchResponse.list)
          : (List<T>.from(state.values)..addAll(fetchResponse.list));

      final totalItems = event.totalItems ?? state.values.length;
      emit(SWListState<T>(
        values: d,
        hasReachedMax: fetchResponse.totalPages ==
            ((totalItems + fetchResponse.list.length) / _pageSize).ceil(),
      ));
    });
  }

  Future<void> _reset(
      SWListResetEvent<T> event, Emitter<SWListState<T>> emit) async {
    emit(SWListState<T>());
  }
}
