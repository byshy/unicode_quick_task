import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection_container.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/on_boarding/bloc/on_boarding_bloc.dart';
import '../../features/on_boarding/screens/on_boarding_screen.dart';
import '../../features/splash/bloc/splash_bloc.dart';
import '../../features/splash/screens/splash_screen.dart';
import 'screens.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Screens.splash),
          builder: (_) => BlocProvider.value(
            value: sl<SplashBloc>(),
            child: const SplashScreen(),
          ),
        );
      case Screens.onBoarding:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Screens.onBoarding),
          builder: (_) => BlocProvider.value(
            value: sl<OnBoardingBloc>(),
            child: const OnBoardingScreen(),
          ),
        );
      case Screens.home:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Screens.home),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: sl<HomeBloc>()),
            ],
            child: const HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
