import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:quick_task/core/enums/base_status.dart';
import 'package:quick_task/data/local_data_sources/local_data_source.dart';
import 'package:quick_task/features/splash/bloc/splash_bloc.dart';
import 'package:quick_task/use_cases/splash_screen_use_case.dart';
import 'package:route_navigator/route_navigator.dart';

import 'splash_bloc_test.mocks.dart';

@GenerateMocks([
  SplashScreenUseCase,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'SplashBloc base flow (all customers).',
    () {
      final GetIt instance = GetIt.instance;

      late SplashBloc splashBloc;
      late MockSplashScreenUseCase splashUseCase;

      setUp(() async {
        splashBloc = SplashBloc();
        splashUseCase = MockSplashScreenUseCase();

        if (!instance.isRegistered<SplashBloc>()) {
          instance.registerSingleton<SplashBloc>(splashBloc);
        }

        if (!instance.isRegistered<SplashScreenUseCase>()) {
          instance.registerSingleton<SplashScreenUseCase>(splashUseCase);
        }
      });

      tearDown(() {
        if (instance.isRegistered<SplashScreenUseCase>()) {
          instance.unregister<SplashScreenUseCase>();
        }

        if (instance.isRegistered<LocalDataSource>()) {
          instance.unregister<LocalDataSource>();
        }

        if (instance.isRegistered<RouteNavigator>()) {
          instance.unregister<RouteNavigator>();
        }

        splashBloc.close();
      });

      test("Init state is correct.", () {
        expect(
          instance<SplashBloc>().state,
          const SplashState(),
        );
      });

      blocTest<SplashBloc, SplashState>(
        'Successfully onMounted splash screen',
        build: () {
          when(
            splashUseCase.onMounted(),
          ).thenAnswer(
            (_) async => const Right(
              null,
            ),
          );

          return splashBloc;
        },
        act: (bloc) => bloc.add(
          const SplashScreenMounted(),
        ),
        expect: () => [
          const SplashState(
            status: BaseStatus.loading,
          ),
          const SplashState(
            status: BaseStatus.success,
          ),
        ],
        verify: (bloc) => [
          verify(splashUseCase.onMounted()).called(1),
        ],
      );
    },
  );
}
