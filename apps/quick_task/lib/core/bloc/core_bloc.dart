import 'dart:async';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/enums/lang.dart';
import 'package:quick_task/use_cases/core_use_case.dart';
import 'package:unicode/unicode.dart';

import '../../di/injection_container.dart';
import '../../generated/l10n.dart';
import '../models/failures/failure.dart';

part 'core_event.dart';

part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  late PackageInfo packageInfo;

  CoreBloc() : super(const CoreState()) {
    PackageInfo.fromPlatform().then((value) {
      packageInfo = value;
    });

    on<CoreLanguageInitialized>(_onCoreLanguageInitialized);
    on<CoreLanguageChanged>(_onLanguageChanged);
    on<DeviceIDFetched>(_onDeviceIDFetched);

    add(const CoreLanguageInitialized());
    add(const DeviceIDFetched());
  }

  Future<void> _onCoreLanguageInitialized(CoreLanguageInitialized event, Emitter<CoreState> emit) async {
    Either<Failure, Lang> langResult = sl<CoreUseCase>().getLanguage();

    await langResult.fold(
      (failure) {},
      (language) async {
        await QuickTaskL10n.load(Locale(language.name));

        emit(
          state.copyWith(
            lang: language.name,
          ),
        );
      },
    );
  }

  Future<void> _onLanguageChanged(CoreLanguageChanged event, Emitter<CoreState> emit) async {
    Either<Failure, Lang> langResult = sl<CoreUseCase>().getLanguage(lang: event.language);

    await langResult.fold(
      (failure) {},
      (language) async {
        await QuickTaskL10n.load(Locale(language.name));

        emit(
          state.copyWith(
            lang: event.language,
          ),
        );
      },
    );
  }

  Future<void> _onDeviceIDFetched(DeviceIDFetched event, Emitter<CoreState> emit) async {
    Either<Failure, String?> result = await sl<CoreUseCase>().getDeviceID();

    result.fold(
      (failure) {},
      (deviceID) {
        emit(
          state.copyWith(
            deviceID: deviceID,
          ),
        );
      },
    );
  }
}
