class ErrorResponse {
  ErrorResponse({
    required this.detail,
  });

  final String detail;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        detail: json['detail'],
      );

  Map<String, dynamic> toJson() => {
        'detail': detail,
      };
}
