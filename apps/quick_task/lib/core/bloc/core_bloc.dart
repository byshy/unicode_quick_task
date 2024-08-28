import 'dart:async';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/enums/lang.dart';
import 'package:quick_task/use_cases/core_use_case.dart';
import 'package:unicode/unicode.dart';

import '../../data/local_data_sources/local_data_source.dart';
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

    on<CoreLanguageChanged>(_changeLanguage);
  }

  Future<void> _changeLanguage(CoreLanguageChanged event, Emitter<CoreState> emit) async {
    await getLanguage();

    sl<LocalDataSource>().setLanguage(event.language);

    emit(
      state.copyWith(
        lang: event.language,
      ),
    );
  }

  Future<void> getLanguage() async {
    Either<Failure, Lang> langResult = sl<CoreUseCase>().getLanguage();

    await langResult.fold(
      (failure) {},
      (language) async {
        await QuickTaskL10n.load(Locale(language.name));
      },
    );
  }
}
