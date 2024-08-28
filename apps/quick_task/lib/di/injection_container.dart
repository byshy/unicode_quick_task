import 'package:needle/needle.dart';

import 'core_injector.dart' as core;
import 'bloc_injector.dart' as bloc;
import 'datasource_injector.dart' as datasource;
import 'external_injector.dart' as external_sdk;
import 'repository_injector.dart' as repository;
import 'use_case_injector.dart' as use_case;

final GetIt sl = GetIt.instance;

Future<void> initSL() async {
  await core.init(sl); 
  await datasource.init(sl); 
  await external_sdk.init(sl); 
  await repository.init(sl); 
  await use_case.init(sl); 
  await bloc.init(sl); 
}
