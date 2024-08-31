import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/enums/lang.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:needle/needle.dart';
import 'package:quick_task/core/bloc/core_bloc.dart';
import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/use_cases/core_use_case.dart';

import 'core_bloc_test.mocks.dart';

@GenerateMocks([
  CoreUseCase,
])
void main() {
  final GetIt instance = GetIt.instance;

  late CoreBloc coreBloc;
  late MockCoreUseCase mockCoreUseCase;

  setUp(() {
    mockCoreUseCase = MockCoreUseCase();

    if (!instance.isRegistered<CoreUseCase>()) {
      instance.registerSingleton<CoreUseCase>(mockCoreUseCase);
    }

    when(mockCoreUseCase.getLanguage()).thenAnswer((_) => const Right(Lang.en));

    coreBloc = CoreBloc();
  });

  tearDown(() {
    if (instance.isRegistered<CoreUseCase>()) {
      instance.unregister<CoreUseCase>();
    }

    coreBloc.close();
  });

  group('CoreBloc', () {
    blocTest<CoreBloc, CoreState>(
      'emits correct state when CoreLanguageInitialized is added and succeeds',
      build: () {
        when(mockCoreUseCase.getLanguage()).thenAnswer((_) => const Right(Lang.en));

        return coreBloc;
      },
      act: (bloc) => bloc.add(const CoreLanguageInitialized()),
      expect: () => [
        const CoreState(lang: 'en'),
      ],
      verify: (_) {
        verify(mockCoreUseCase.getLanguage()).called(1);
      },
    );

    blocTest<CoreBloc, CoreState>(
      'emits correct state when CoreLanguageChanged is added and succeeds',
      build: () {
        when(mockCoreUseCase.getLanguage(lang: Lang.ar.name)).thenAnswer((_) => const Right(Lang.ar));
        return coreBloc;
      },
      act: (bloc) => bloc.add(CoreLanguageChanged(language: Lang.ar.name)),
      expect: () => [
        const CoreState(lang: 'ar'),
      ],
      verify: (_) {
        verify(mockCoreUseCase.getLanguage(lang: Lang.ar.name)).called(1);
      },
    );

    blocTest<CoreBloc, CoreState>(
      'does not emit new state when CoreLanguageInitialized fails',
      build: () {
        when(mockCoreUseCase.getLanguage()).thenAnswer((_) => const Left(UnknownFailure()));
        return coreBloc;
      },
      act: (bloc) => bloc.add(const CoreLanguageInitialized()),
      expect: () => [],
      verify: (_) {
        verify(mockCoreUseCase.getLanguage()).called(1);
      },
    );

    blocTest<CoreBloc, CoreState>(
      'does not emit new state when CoreLanguageChanged fails',
      build: () {
        when(mockCoreUseCase.getLanguage(lang: Lang.ar.name)).thenAnswer((_) => const Left(UnknownFailure()));
        return coreBloc;
      },
      act: (bloc) => bloc.add(CoreLanguageChanged(language: Lang.ar.name)),
      expect: () => [],
      verify: (_) {
        verify(mockCoreUseCase.getLanguage(lang: Lang.ar.name)).called(1);
      },
    );
  });
}