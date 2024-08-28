import 'package:needle/needle.dart';
import '../data/local_data_sources/local_data_source.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSource(),
  );
}
