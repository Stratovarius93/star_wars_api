class GeneralException implements Exception {
  final String msg;
  final int? code;

  GeneralException(this.msg, {this.code});

  @override
  String toString() => msg;
}
