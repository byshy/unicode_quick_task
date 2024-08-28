import 'package:dartz/dartz.dart';
import 'package:localization/enums/lang.dart';

import '../core/helpers/language_getter.dart';
import '../core/models/failures/failure.dart';

class CoreUseCase {
  Either<Failure, Lang> getLanguage() {
    try {
      return Right(getCoreLanguage());
    } catch (e) {
      return Left(UnknownFailure(data: e));
    }
  }
}
