class ServerResponse {
  bool isSuccess;
  String? message;
  dynamic result;
  int statusCode;
  String? defaultCode;

  ServerResponse({
    required this.isSuccess,
    this.message,
    this.result,
    required this.statusCode,
    this.defaultCode,
  });

  dynamic get response {
    return result;
  }

  String get code {
    return defaultCode ?? '';
  }
}
