import 'dart:io';
import 'package:localization/enums/lang.dart';
import 'package:picasso/di/injection_container.dart';

import '../../data/local_data_sources/local_data_source.dart';

Lang getCoreLanguage() {
  Lang language;

  final String? savedLocale = sl<LocalDataSource>().getLanguage();

  if (savedLocale != null) {
    language = savedLocale.toLang();
  } else {
    final String currentLocale = Platform.localeName;

    if (currentLocale.isNotEmpty) {
      // split('_') is needed since it return language like this en_US, en_UK so we need to split to get the en only
      // in case the platform language is empty take the default form storage or ar
      language = currentLocale.split('_')[0].toLang();
    } else {
      language = Lang.en;
    }

    sl<LocalDataSource>().setLanguage(language.name);
  }

  return language;
}
