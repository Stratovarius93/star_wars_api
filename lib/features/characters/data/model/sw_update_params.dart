import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';

class SWUpdateParams {
  final Gender? gender;
  final int? totalItems;

  SWUpdateParams({this.gender, this.totalItems});

  /// copyWith method
  SWUpdateParams copyWith({
    Gender? gender,
  }) =>
      SWUpdateParams(
        gender: gender ?? this.gender,
      );

  /// init
  factory SWUpdateParams.init() => SWUpdateParams(gender: null);
}
