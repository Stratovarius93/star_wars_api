import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/core/data_base/params/data_base_params.dart';
import 'package:star_wars_app/core/errors/failure.dart';
import 'package:star_wars_app/core/utils/connection.dart';

part 'base_data_event.dart';
part 'base_data_state.dart';

abstract class BaseDataBloc<T, P extends BaseDataParams>
    extends Bloc<BaseDataEvent, BaseDataState<T>> {
  BaseDataBloc({
    required this.hasConnection,
  }) : super(BaseDataState<T>()) {
    on<CallAction<P>>(onCallAction);
    on<RestoreData>(restoreData);
  }

  final HasConnection hasConnection;

  FutureOr<void> onCallAction(
    CallAction<P> event,
    Emitter<BaseDataState<T>> emit,
  ) async {
    emit(state.copyWith(status: ScreenStatusType.loading));
    late bool hasInternet;
    hasInternet = await hasConnection.call();
    if (!hasInternet) {
      emit(state.copyWith(status: ScreenStatusType.noInternet));
      return;
    }
    final res = await repositoryCall(event.params);
    res.fold((l) {
      final message = (l as GeneralFailure).message;
      onFailure(emit, message);
    }, (r) {
      onSuccess(emit, r, event.params);
    });
  }

  FutureOr<void> restoreData(
    RestoreData event,
    Emitter<BaseDataState<T>> emit,
  ) async {
    emit(const BaseDataState());
  }

  void onFailure(Emitter<BaseDataState<T>> emit, String failure) {
    emit(
      state.copyWith(
        message: failure,
        status: ScreenStatusType.error,
      ),
    );
  }

  void onSuccess(
    Emitter<BaseDataState<T>> emit,
    T value,
    BaseDataParams? params,
  ) {
    emit(state.copyWith(status: ScreenStatusType.loaded, value: value));
  }

  Future<Either<Failure, T>> repositoryCall(
    P? params,
  );
}
