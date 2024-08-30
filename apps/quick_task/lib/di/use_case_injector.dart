import 'package:needle/needle.dart';
import 'package:quick_task/use_cases/helpers/todo_sync_helper.dart';
import '../use_cases/core_use_case.dart';
import '../use_cases/home_use_case.dart';
import '../use_cases/splash_screen_use_case.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton(() => CoreUseCase());
  instance.registerLazySingleton(() => SplashScreenUseCase());

  instance.registerLazySingleton(() => TodoSyncHelper());
  instance.registerLazySingleton(() => HomeUseCase());
}
