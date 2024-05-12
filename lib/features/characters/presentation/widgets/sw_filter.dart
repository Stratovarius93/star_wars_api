import 'package:flutter/material.dart';
import 'package:star_wars_app/features/characters/data/model/sw_gender_model.dart';
import 'package:star_wars_app/features/characters/presentation/widgets/sw_filterchip.dart';

class SWFilter extends StatefulWidget {
  const SWFilter({super.key, required this.onFilterChanged});
  final void Function(Gender?) onFilterChanged;

  @override
  State<SWFilter> createState() => _SWFilterState();
}

class _SWFilterState extends State<SWFilter> {
  List<Gender> filters = [];
  Gender? selectedFilter;
  @override
  void initState() {
    filters = Gender.values.map((e) => e).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Filter by gender',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: filters
                .map((filter) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: SWItemFilter(
                        gender: filter,
                        isSelected: selectedFilter == filter,
                        onSelected: (isSelected) {
                          setState(() {
                            selectedFilter = isSelected ? filter : null;
                            widget.onFilterChanged(selectedFilter);
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          height: 2,
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          thickness: 1,
        )
      ],
    );
  }
}
