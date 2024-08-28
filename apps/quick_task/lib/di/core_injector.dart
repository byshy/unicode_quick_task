import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:monitoring/tracker.dart';
import 'package:needle/needle.dart';
import 'package:picasso/models/config.dart';
import 'package:route_navigator/route_navigator.dart';

import '../core/models/monitoring/trackers_implementation.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton<RouteNavigator>(() => RouteNavigator());
  instance.registerLazySingleton<Connectivity>(() => Connectivity());
  instance.registerLazySingleton<Tracker>(() => Tracker(TrackersImplementation()));

  Config config = await configInitializer();

  instance.registerLazySingleton<Config>(() => config);
}

Future<Config> configInitializer() async {
  String flavorName = const String.fromEnvironment("flavor", defaultValue: 'dev');

  Environment flavorEnv = flavorName.contains('prod') ? Environment.prod : Environment.dev;

  Map<String, dynamic> flavorConfigMap = json.decode(
    await rootBundle.loadString('assets/configs/$flavorName.json'),
  );

  // Only contains the theme and workflow
  Map<String, dynamic> baseConfig = json.decode(
    await rootBundle.loadString('assets/configs/base_config.json'),
  );

  Map<String, dynamic> theme = baseConfig['theme'];
  Map<String, dynamic>? flavoredTheme = flavorConfigMap['theme'];

  Map<String, dynamic> workflow = baseConfig['workflow'];
  Map<String, dynamic>? flavoredWorkflow = flavorConfigMap['workflow'];

  if (flavoredTheme != null) {
    theme.addAll(flavoredTheme);
  }

  if (flavoredWorkflow != null) {
    workflow.addAll(flavoredWorkflow);
  }

  flavorConfigMap['theme'] = theme;
  flavorConfigMap['workflow'] = workflow;
  flavorConfigMap['environment'] = flavorEnv;

  Config configObj = Config.fromJson(flavorConfigMap);

  configObj.initFlavorSettings();

  return configObj;
}
