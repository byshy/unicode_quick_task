import 'package:needle/needle.dart';
import 'package:quick_task/repos/home_repo.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton<HomeRepo>(() => HomeRepo());
}
