import 'dart:io';

import 'package:workmanager/workmanager.dart';

extension WMTaskRegister on Workmanager {
  void registerTask(
    final String uniqueName,
    final String taskName,
  ) {
    if (Platform.isIOS) {
      Workmanager().registerOneOffTask(
        uniqueName,
        taskName,
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
    } else {
      Workmanager().registerPeriodicTask(
        uniqueName,
        taskName,
      );
    }
  }
}
