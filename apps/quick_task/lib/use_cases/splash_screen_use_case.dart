import 'package:dartz/dartz.dart';
import 'package:route_navigator/route_navigator.dart';
import '../core/models/failures/failure.dart';
import '../data/local_data_sources/local_data_source.dart';
import '../di/injection_container.dart';
import '../utils/routing/screens.dart';

class SplashScreenUseCase {
  Future<Either<Failure, void>> onMounted() async {
    try {
      if (sl<LocalDataSource>().getFirstLaunch()) {
        sl<RouteNavigator>().pushReplacementScreen(Screens.onBoarding);
      } else {
        sl<RouteNavigator>().pushReplacementScreen(Screens.home);
      }
    } catch (e) {
      return const Left(
        UnknownFailure(),
      );
    }

    return const Right(null);
  }
}
