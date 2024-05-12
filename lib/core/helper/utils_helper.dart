import 'dart:convert';
import 'dart:typed_data';

class AppUtils {
  AppUtils._internal();
  static final AppUtils _instance = AppUtils._internal();
  static AppUtils get instance => _instance;

  getDataDecode(Uint8List bodyBytes) {
    return json.decode(utf8.decode(bodyBytes));
  }

  double jsonToDouble(dynamic value) {
    return value == null
        ? 0
        : value is String
            ? double.tryParse(value) ?? 0
            : value is int
                ? value.toDouble()
                : value.toDouble();
  }

  int jsonToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int || value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
