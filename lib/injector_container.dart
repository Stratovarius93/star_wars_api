import 'package:chuck_interceptor/chuck.dart';
import 'package:get_it/get_it.dart';
import 'package:star_wars_app/core/navigator/navigator.dart';
import 'package:star_wars_app/core/services/center_api.dart';
import 'package:star_wars_app/core/utils/connection.dart';
import 'package:star_wars_app/features/characters/sw_injector.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// SW Sub Injector
  SWInjector.init(sl);
  sl.registerFactory(() => HasConnection());

  /// HTTP Interceptor
  sl.registerLazySingleton<Chuck>(
    () => Chuck(
        showNotification: true,
        navigatorKey: AppNavigator.navigatorKey,
        showInspectorOnShake: true),
  );
  sl.registerLazySingleton<CenterApi>(CenterApi.new);
}
