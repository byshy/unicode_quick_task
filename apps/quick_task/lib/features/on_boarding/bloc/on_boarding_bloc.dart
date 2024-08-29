import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:route_navigator/route_navigator.dart';

import '../../../core/enums/base_status.dart';
import '../../../data/local_data_sources/local_data_source.dart';
import '../../../di/injection_container.dart';
import '../../../utils/routing/screens.dart';

part 'on_boarding_event.dart';

part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  late TabController onBoardingTabsController;

  OnBoardingBloc() : super(const OnBoardingState()) {
    on<GoToNextPage>(_onGoToNextPage);

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (sl<LocalDataSource>().getFirstLaunch()) {
          sl<HomeBloc>().add(const FirstTimeTODOLoaded());
        }
      },
    );
  }

  Future<void> _onGoToNextPage(GoToNextPage event, Emitter<OnBoardingState> emit) async {
    if (onBoardingTabsController.index != onBoardingTabsController.length - 1) {
      onBoardingTabsController.animateTo(
        onBoardingTabsController.index + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      try {
        sl<LocalDataSource>().setFirstLaunch(false);

        sl<RouteNavigator>().pushReplacementScreen(Screens.home);
      } catch (_) {}
    }
  }
}
