import 'dart:developer';

import 'package:chuck_interceptor/chuck.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_app/core/helper/utils_helper.dart';
import 'package:star_wars_app/core/model/error_response_model.dart';
import 'package:star_wars_app/core/model/server_response_model.dart';
import 'package:star_wars_app/core/utils/constants.dart';
import 'package:star_wars_app/injector_container.dart';

class CenterApi {
  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<ServerResponse> get({
    required String urlSpecific,
    bool useNewErrorHandler = false,
  }) async {
    try {
      final response =
          await http.get(Uri.parse(urlSpecific), headers: _headers);
      sl<Chuck>().onHttpResponse(response);
      final dataDecode = response.body.isNotEmpty
          ? AppUtils.instance.getDataDecode(response.bodyBytes)
          : [];
      log(dataDecode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ServerResponse(
          isSuccess: true,
          message: AppConstants.successfulGet,
          result: dataDecode,
          statusCode: response.statusCode,
        );
      } else {
        return ServerResponse(
          isSuccess: false,
          message: useNewErrorHandler
              ? formatNewError(dataDecode)
              : formatError(dataDecode),
          result: [],
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      return ServerResponse(
        isSuccess: false,
        message: AppConstants.connectionError,
        result: [],
        statusCode: 500,
      );
    }
  }

  String formatError(dynamic error) {
    if (error is List) {
      var errorMessage = '';
      for (final e in error) {
        if (e is String) {
          errorMessage += '$e\n';
        }
      }
      return errorMessage;
    } else if (error is Map) {
      if (error.containsKey('detail')) return error['detail']! as String;
      var errorMessage = '';
      for (final element in error.values) {
        if (element is List) {
          for (final msg in element) {
            if (msg is String) {
              errorMessage += '$msg\n';
            }
          }
        } else if (element is String) {
          errorMessage += '$element\n';
        }
      }
      return errorMessage;
    }
    return AppConstants.error;
  }

  String formatNewError(dynamic error) {
    final errorResponse = ErrorResponse.fromJson(error as Map<String, dynamic>);
    return errorResponse.detail;
  }
}
