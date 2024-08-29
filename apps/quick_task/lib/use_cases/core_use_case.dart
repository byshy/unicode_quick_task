import 'package:app_set_id/app_set_id.dart';
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

  Future<Either<Failure, String?>> getDeviceID() async {
    try {
      return Right(await AppSetId().getIdentifier());
    } catch (e) {
      return Left(UnknownFailure(data: e));
    }
  }
}
