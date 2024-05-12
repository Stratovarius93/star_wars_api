import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/core/navigator/navigator.dart';
import 'package:star_wars_app/core/navigator/sub_router.dart';

class NavigatorRouter {
  NavigatorRouter._();

  static final key = AppNavigator.navigatorKey;

  static BuildContext get currentContext => key.currentContext!;
  static Future<T?> pushNamed<T extends Object?>(
    String route, {
    SubRouter? router,
    Object? arguments,
  }) {
    return key.currentState!.pushNamed(
      router != null ? '${router.moduleName} $route' : route,
      arguments: arguments,
    );
  }

  static void pop<T>([T? result]) {
    return key.currentState!.pop(result);
  }
}
