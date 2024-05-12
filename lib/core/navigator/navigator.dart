import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/core/navigator/sub_router.dart';
import 'package:star_wars_app/features/characters/presentation/pages/sw_main.dart';
import 'package:star_wars_app/features/characters/sw_router.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static final _moduleRouterRegistration = <SubRouter>[
    swRoute,
  ];

  static Route onGenerateRoute(RouteSettings settings) {
    Route pageRoute({Widget page = const SWMainPage()}) {
      return Platform.isIOS
          ? CupertinoPageRoute(
              builder: (context) => page,
              settings: settings,
            )
          : MaterialPageRoute(
              builder: (context) => page,
              settings: settings,
            );
    }

    try {
      final routeComponents = settings.name!.split(' ');
      final module = _moduleRouterRegistration.firstWhere((subRouter) {
        return subRouter.moduleName == routeComponents[0];
      });
      final routeName = routeComponents[1];
      final splitRouteSettings = RouteSettings(
        name: routeName,
        arguments: settings.arguments,
      );
      return pageRoute(page: module.router(splitRouteSettings));
    } catch (e) {
      log(e.toString());
    }
    return pageRoute();
  }
}
