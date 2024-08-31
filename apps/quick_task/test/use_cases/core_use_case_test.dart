import 'package:flutter_test/flutter_test.dart';
import 'package:localization/enums/lang.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:needle/needle.dart';

import 'package:quick_task/core/models/failures/failure.dart';
import 'package:quick_task/core/helpers/language_getter.dart';
import 'package:quick_task/data/local_data_sources/local_data_source.dart';
import 'package:quick_task/use_cases/core_use_case.dart';

import 'core_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LocalDataSource>(),
])
void main() {
  late CoreUseCase coreUseCase;
  late MockLocalDataSource mockLocalDataSource;

  final GetIt instance = GetIt.instance;

  setUp(() {
    coreUseCase = CoreUseCase();
    mockLocalDataSource = MockLocalDataSource();

    if (!instance.isRegistered<LocalDataSource>()) {
      instance.registerSingleton<LocalDataSource>(mockLocalDataSource);
    }
  });

  tearDown(() {
    if (instance.isRegistered<LocalDataSource>()) {
      instance.unregister<LocalDataSource>();
    }
  });

  group('getLanguage', () {
    test('should return a Right with Lang when getCoreLanguage is successful', () {
      // Arrange
      const lang = Lang.en;
      when(getCoreLanguage()).thenReturn(lang);

      when(mockLocalDataSource.setLanguage(Lang.en.name)).thenAnswer((_) async => Future.value());

      // Act
      final result = coreUseCase.getLanguage();

      // Assert
      expect(result, const Right(lang));
    });

    test('should return a Left with UnknownFailure when getCoreLanguage throws an exception', () {
      // Arrange
      when(getCoreLanguage()).thenThrow(Exception('Unexpected error'));

      // Act
      final result = coreUseCase.getLanguage();

      // Assert
      expect(result, isA<Left>());
      expect(result.fold((failure) => failure, (r) => null), isA<UnknownFailure>());
    });
  });
}
