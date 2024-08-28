import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:picasso/models/config.dart';
import 'package:quick_task/data/local_data_sources/local_data_source.dart';
import 'package:quick_task/features/on_boarding/bloc/on_boarding_bloc.dart';
import 'package:quick_task/utils/routing/screens.dart';
import 'package:route_navigator/route_navigator.dart';

import 'on_boarding_bloc_test.mocks.dart';

@GenerateMocks([
  Config,
  LocalDataSource,
  RouteNavigator,
  TabController,
])
void main() {
  group(
    'OnBoarding Bloc base flow (all customers).',
    () {
      final GetIt instance = GetIt.instance;

      late OnBoardingBloc onBoardingBloc;
      late MockConfig mockConfig;
      late MockLocalDataSource mockLocalDataSource;
      late MockRouteNavigator mockRouteNavigator;
      late MockTabController mockTabController;

      setUp(() {
        onBoardingBloc = OnBoardingBloc();
        mockConfig = MockConfig();
        mockLocalDataSource = MockLocalDataSource();
        mockRouteNavigator = MockRouteNavigator();
        mockTabController = MockTabController();

        onBoardingBloc.onBoardingTabsController = mockTabController;

        if (!instance.isRegistered<OnBoardingBloc>()) {
          instance.registerSingleton<OnBoardingBloc>(onBoardingBloc);
        }

        if (!instance.isRegistered<Config>()) {
          instance.registerSingleton<Config>(mockConfig);
        }

        if (!instance.isRegistered<LocalDataSource>()) {
          instance.registerSingleton<LocalDataSource>(mockLocalDataSource);
        }

        if (!instance.isRegistered<RouteNavigator>()) {
          instance.registerSingleton<RouteNavigator>(mockRouteNavigator);
        }

        when(mockTabController.length).thenReturn(3);

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

        onBoardingBloc.close();
      });

      test("Init state is correct.", () {
        expect(
          instance<OnBoardingBloc>().state,
          const OnBoardingState(),
        );
      });

      blocTest<OnBoardingBloc, OnBoardingState>(
        'Animates to next page when current page is not the last page.',
        build: () {
          when(
            onBoardingBloc.onBoardingTabsController.index,
          ).thenReturn(0);

          return onBoardingBloc;
        },
        act: (bloc) => bloc.add(
          const GoToNextPage(
            pagesLength: 3,
          ),
        ),
        verify: (_) {
          verify(
            onBoardingBloc.onBoardingTabsController.animateTo(
              1,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            ),
          ).called(1);
          verifyNever(
            mockLocalDataSource.setFirstLaunch(false),
          );
          verifyNever(
            mockRouteNavigator.pushReplacementScreen(
              any,
              arguments: anyNamed('arguments'),
            ),
          );
        },
      );

      blocTest<OnBoardingBloc, OnBoardingState>(
        'Navigates to home screen when current page is the last page in regular customer',
        build: () {
          when(
            mockTabController.index,
          ).thenReturn(2);

          when(
            mockTabController.length,
          ).thenReturn(3);

          when(
            mockConfig.domain,
          ).thenReturn(Client.regular);

          when(
            mockRouteNavigator.pushReplacementScreen(any),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          return onBoardingBloc;
        },
        act: (bloc) => bloc.add(
          const GoToNextPage(
            pagesLength: 3,
          ),
        ),
        verify: (bloc) => [
          verifyNever(
            onBoardingBloc.onBoardingTabsController.animateTo(
              3,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            ),
          ),
          verify(
            mockLocalDataSource.setFirstLaunch(false),
          ).called(1),
          verify(
            mockRouteNavigator.pushReplacementScreen(
              Screens.home,
            ),
          ).called(1),
        ],
      );

      blocTest<OnBoardingBloc, OnBoardingState>(
        'Navigates to home screen when current page is the last page in pro customer',
        build: () {
          when(
            mockTabController.index,
          ).thenReturn(3);

          when(
            mockTabController.length,
          ).thenReturn(4);

          when(
            mockConfig.domain,
          ).thenReturn(Client.pro);

          when(
            mockRouteNavigator.pushReplacementScreen(any),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          return onBoardingBloc;
        },
        act: (bloc) => bloc.add(
          const GoToNextPage(
            pagesLength: 4,
          ),
        ),
        verify: (bloc) => [
          verifyNever(
            onBoardingBloc.onBoardingTabsController.animateTo(
              4,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            ),
          ),
          verify(
            mockLocalDataSource.setFirstLaunch(false),
          ).called(1),
          verify(
            mockRouteNavigator.pushReplacementScreen(
              Screens.home,
            ),
          ).called(1),
        ],
      );

      blocTest<OnBoardingBloc, OnBoardingState>(
        'Handles setFirstLaunch failure gracefully.',
        build: () {
          when(
            mockTabController.index,
          ).thenReturn(2);

          when(
            mockTabController.length,
          ).thenReturn(3);

          when(
            mockConfig.domain,
          ).thenReturn(Client.regular);

          when(mockLocalDataSource.setFirstLaunch(false)).thenThrow(Exception('Failed to set first launch'));

          return onBoardingBloc;
        },
        act: (bloc) => bloc.add(
          const GoToNextPage(pagesLength: 3),
        ),
        verify: (bloc) {
          verifyNever(
            onBoardingBloc.onBoardingTabsController.animateTo(
              3,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
          );
          verify(
            mockLocalDataSource.setFirstLaunch(false),
          ).called(1);
          verifyNever(
            mockRouteNavigator.pushReplacementScreen(Screens.home),
          );
        },
      );

      blocTest<OnBoardingBloc, OnBoardingState>(
        'Handles navigation failure gracefully.',
        build: () {
          when(
            mockRouteNavigator.pushReplacementScreen(any),
          ).thenThrow(Exception('Navigation failed'));

          when(
            mockTabController.index,
          ).thenReturn(2);

          when(
            mockTabController.length,
          ).thenReturn(3);

          return onBoardingBloc;
        },
        act: (bloc) => bloc.add(
          const GoToNextPage(
            pagesLength: 3,
          ),
        ),
        verify: (bloc) {
          verify(
            mockRouteNavigator.pushReplacementScreen(Screens.home),
          ).called(1);
          // Handle navigation failure gracefully here, possibly with an error state or retry logic
        },
      );

      blocTest<OnBoardingBloc, OnBoardingState>(
        'Handles a large number of pages efficiently.',
        build: () {
          when(mockTabController.index).thenReturn(0);
          when(mockTabController.length).thenReturn(100);

          return onBoardingBloc;
        },
        act: (bloc) => bloc.add(
          const GoToNextPage(pagesLength: 100),
        ),
        verify: (bloc) {
          verify(
            onBoardingBloc.onBoardingTabsController.animateTo(
              1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            ),
          ).called(1);
        },
      );
    },
  );
}
