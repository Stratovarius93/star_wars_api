import 'package:equatable/equatable.dart';

enum SWListStatus {
  initial,
  loading,
  fail,
}

extension SWListStatusX on SWListStatus {
  bool get isLoading => this == SWListStatus.loading;
  bool get isInitial => this == SWListStatus.initial;
  bool get isFail => this == SWListStatus.fail;
}

class SWListState<T> extends Equatable {
  final List<T> values;
  final String message;
  final SWListStatus status;
  final bool hasReachedMax;

  const SWListState({
    List<T>? values,
    String? message,
    SWListStatus? status,
    bool? hasReachedMax,
  })  : values = values ?? const [],
        message = message ?? '',
        status = status ?? SWListStatus.initial,
        hasReachedMax = hasReachedMax ?? false;

  SWListState<T> copyWith({
    List<T>? values,
    String? message,
    SWListStatus? status,
    bool? hasReachedMax,
  }) =>
      SWListState<T>(
        values: values ?? this.values,
        message: message ?? this.message,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object?> get props => [
        values,
        message,
        status,
        hasReachedMax,
      ];
}
