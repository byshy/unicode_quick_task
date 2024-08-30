import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:picasso/models/config.dart';
import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/data/local_data_sources/local_data_source.dart';
import 'package:quick_task/use_cases/splash_screen_use_case.dart';
import 'package:quick_task/utils/routing/screens.dart';
import 'package:route_navigator/route_navigator.dart';

import 'splash_screen_use_case_test.mocks.dart';

@GenerateMocks([
  Config,
  RouteNavigator,
  LocalDataSource,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'SplashBloc base flow (all customers).',
    () {
      final GetIt instance = GetIt.instance;

      SplashScreenUseCase useCase = SplashScreenUseCase();

      late MockConfig mockConfig;
      late MockLocalDataSource mockLocalDataSource;
      late MockRouteNavigator mockRouteNavigator;

      setUp(() async {
        mockConfig = MockConfig();
        mockLocalDataSource = MockLocalDataSource();
        mockRouteNavigator = MockRouteNavigator();

        if (!instance.isRegistered<Config>()) {
          instance.registerSingleton<Config>(mockConfig);
        }

        if (!instance.isRegistered<LocalDataSource>()) {
          instance.registerSingleton<LocalDataSource>(mockLocalDataSource);
        }

        if (!instance.isRegistered<RouteNavigator>()) {
          instance.registerSingleton<RouteNavigator>(mockRouteNavigator);
        }

        when(
          mockRouteNavigator.pushReplacementScreen(
            any,
            arguments: anyNamed('arguments'),
          ),
        ).thenAnswer((_) => Future.value(null));
      });

      tearDown(() {
        if (instance.isRegistered<Config>()) {
          instance.unregister<Config>();
        }

        if (instance.isRegistered<LocalDataSource>()) {
          instance.unregister<LocalDataSource>();
        }

        if (instance.isRegistered<RouteNavigator>()) {
          instance.unregister<RouteNavigator>();
        }
      });

      test(
        'Users first session',
        () async {
          when(
            mockLocalDataSource.getFirstLaunch(),
          ).thenReturn(
            true,
          );

          when(
            mockRouteNavigator.pushReplacementScreen(any),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          Either<Failure, void> result = await useCase.onMounted();

          verify(mockLocalDataSource.getFirstLaunch()).called(1);
          verify(mockRouteNavigator.pushReplacementScreen(Screens.onBoarding)).called(1);

          expect(result, const Right(null));
        },
      );

      test(
        'Not the first session of the user',
        () async {
          when(
            mockLocalDataSource.getFirstLaunch(),
          ).thenReturn(
            false,
          );

          when(
            mockRouteNavigator.pushReplacementScreen(any),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          Either<Failure, void> result = await useCase.onMounted();

          verify(mockLocalDataSource.getFirstLaunch()).called(1);
          verify(mockRouteNavigator.pushReplacementScreen(Screens.home)).called(1);

          expect(result, const Right(null));
        },
      );
    },
  );
}
