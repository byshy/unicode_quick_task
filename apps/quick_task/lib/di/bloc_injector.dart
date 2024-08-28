import 'package:needle/needle.dart';

import '../core/bloc/core_bloc.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/on_boarding/bloc/on_boarding_bloc.dart';
import '../features/splash/bloc/splash_bloc.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton(() => CoreBloc());

  instance.registerLazySingleton(() => SplashBloc());
  instance.registerLazySingleton(() => OnBoardingBloc());
  instance.registerLazySingleton(() => HomeBloc());
}
