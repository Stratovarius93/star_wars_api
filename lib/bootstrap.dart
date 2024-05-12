import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'injector_container.dart' as di;

Future<void> bootstrap({required FutureOr<Widget> Function() builder}) async {
  di.init();
  await runZonedGuarded(() async {
    runApp(await builder());
  }, (error, stackTrace) {
    log('runZonedGuarded: Caught error: $error');
    log('runZonedGuarded: StackTrace: $stackTrace');
  });
}
