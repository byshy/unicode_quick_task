import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:localization/enums/lang.dart';
import 'package:quick_task/data/local_data_sources/local_data_source.dart';
import 'package:quick_task/di/injection_container.dart';

import '../core/helpers/language_getter.dart';
import '../core/models/failures/failure.dart';

class CoreUseCase {
  Either<Failure, Lang> getLanguage({String? lang}) {
    if (lang != null) {
      sl<LocalDataSource>().setLanguage(lang);
    }

    try {
      return Right(getCoreLanguage());
    } catch (e) {
      return Left(UnknownFailure(data: e));
    }
  }

  Future<Either<Failure, String?>> getDeviceID() async {
    try {
      String uniqueDeviceId = '';

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        uniqueDeviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        uniqueDeviceId = iosInfo.identifierForVendor ?? '';
      }

      return Right(uniqueDeviceId);
    } catch (e) {
      return Left(UnknownFailure(data: e));
    }
  }
}
