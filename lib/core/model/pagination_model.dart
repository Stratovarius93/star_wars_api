import 'package:star_wars_app/core/utils/constants.dart';

class Pagination<T> {
  final int count;
  final String next;
  final String previous;
  final List<T> results;

  const Pagination({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  Pagination<T> copyWith({
    int? count,
    String? next,
    String? previous,
    List<T>? results,
  }) {
    return Pagination<T>(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class ParamsToPagination {
  final int page;
  final int pageSize;

  ParamsToPagination({
    required this.page,
    this.pageSize = AppConstants.sizePageInfinityScroll,
  });

  ParamsToPagination _data() {
    return ParamsToPagination(
      page: (page ~/ pageSize).toInt(),
      pageSize: pageSize,
    );
  }

  String get pageToUrl => (_data().page + 1).toString();
  String get pageSizeToUrl => _data().pageSize.toString();
  String get genderToUrl => _data().genderToUrl;
}

class PaginationModel<T> {
  PaginationModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  String previous;
  List<T> results;

  factory PaginationModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return PaginationModel<T>(
      count: json["count"] ?? 0,
      next: json["next"] ?? '',
      previous: json["previous"] ?? '',
      results: List<T>.from(json["results"].map((x) => fromJson(x))),
    );
  }
}
