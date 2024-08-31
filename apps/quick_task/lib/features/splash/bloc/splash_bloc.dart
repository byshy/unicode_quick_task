import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_task/core/helpers/is_test_env.dart';
import '../../../core/enums/base_status.dart';
import '../../../di/injection_container.dart';
import '../../../use_cases/splash_screen_use_case.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashScreenMounted>(onSplashScreenMounted);
  }

  Future<void> onSplashScreenMounted(SplashScreenMounted event, Emitter<SplashState> emit) async {
    emit(state.copyWith(status: BaseStatus.loading));

    if (!isRunningInTest) {
      await Permission.notification.request();
    }

    await sl<SplashScreenUseCase>().onMounted();
    emit(state.copyWith(status: BaseStatus.success));
  }
}
