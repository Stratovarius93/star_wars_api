import 'package:flutter/material.dart';
import 'package:star_wars_app/core/navigator/no_route.dart';
import 'package:star_wars_app/core/navigator/sub_router.dart';
import 'package:star_wars_app/features/characters/domain/entities/sw_character.dart';
import 'package:star_wars_app/features/characters/presentation/pages/sw_details.dart';
import 'package:star_wars_app/features/characters/presentation/pages/sw_main.dart';
import 'package:star_wars_app/features/characters/sw_route.dart';

final swRoute = _SWRoute();

class _SWRoute extends SubRouter {
  @override
  String get moduleName => 'character';

  @override
  Widget router(RouteSettings settings) {
    switch (settings.name) {
      case SubRouteSwType.home:
        return const SWMainPage();
      case SubRouteSwType.details:
        return SWItemDetailsPage(
          character: settings.arguments as Character,
        );
      default:
        return const NoRoute();
    }
  }
}
