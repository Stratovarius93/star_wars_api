import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class GeneralFailure extends Failure {
  final String msg;
  final int? code;

  GeneralFailure(this.msg, {this.code});
  String get message => msg;
}
