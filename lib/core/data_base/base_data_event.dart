part of 'base_data_bloc.dart';

abstract class BaseDataEvent extends Equatable {
  const BaseDataEvent();
  @override
  List<Object?> get props => [];
}

class CallAction<P extends BaseDataParams> extends BaseDataEvent {
  const CallAction({this.params});
  final P? params;
}

class RestoreData extends BaseDataEvent {
  const RestoreData();
}
