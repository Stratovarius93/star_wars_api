part of 'base_data_bloc.dart';

enum ScreenStatusType {
  initial,
  loading,
  loaded,
  error,
  existing,
  noInternet,
}

extension ScreenStatusTypeX on ScreenStatusType {
  bool get isInitial => this == ScreenStatusType.initial;
  bool get isLoading => this == ScreenStatusType.loading;
  bool get isLoaded => this == ScreenStatusType.loaded;
  bool get isError => this == ScreenStatusType.error;
  bool get isExisting => this == ScreenStatusType.existing;
  bool get isNoInternet => this == ScreenStatusType.noInternet;
}

class BaseDataState<T> extends Equatable {
  const BaseDataState({
    ScreenStatusType? status,
    this.value,
    String? message,
  })  : status = status ?? ScreenStatusType.initial,
        message = message ?? '';

  final ScreenStatusType status;
  final T? value;
  final String message;

  BaseDataState<T> copyWith({
    ScreenStatusType? status,
    T? value,
    String? message,
  }) =>
      BaseDataState(
        status: status ?? this.status,
        value: value ?? this.value,
        message: message ?? this.message,
      );
  @override
  List<Object?> get props => [status, value, message];
}
