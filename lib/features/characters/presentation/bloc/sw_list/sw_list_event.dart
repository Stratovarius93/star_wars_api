import 'package:equatable/equatable.dart';

abstract class SWListEvent<T> extends Equatable {
  const SWListEvent();
}

class SWListFetchEvent<T> extends SWListEvent<T> {
  final bool clearList;
  final int? totalItems;
  const SWListFetchEvent({
    this.clearList = false,
    this.totalItems,
  });

  @override
  List<Object?> get props => [];
}

class SWListResetEvent<T> extends SWListEvent<T> {
  const SWListResetEvent();

  @override
  List<Object?> get props => [];
}
