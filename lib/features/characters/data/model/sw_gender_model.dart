enum Gender {
  female,
  male,
  none,
}

final genderValues = EnumValues({
  'female': Gender.female,
  'male': Gender.male,
  'none': Gender.none,
  'n/a': Gender.none,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;
  EnumValues(this.map);
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

extension GenderExtensionNameX on Gender {
  String get toName {
    switch (this) {
      case Gender.female:
        return 'Female';
      case Gender.male:
        return 'Male';
      case Gender.none:
        return 'No data';
      default:
        return 'No data';
    }
  }
}
