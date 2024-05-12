import 'package:flutter/material.dart';
import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';

class SWItemFilter extends StatelessWidget {
  final Gender gender;
  final void Function(bool) onSelected;
  final bool isSelected;
  const SWItemFilter(
      {super.key,
      required this.gender,
      required this.onSelected,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      label: Text(gender.toName),
      selected: isSelected,
      shape: const StadiumBorder(side: BorderSide()),
      onSelected: onSelected,
    );
  }
}
