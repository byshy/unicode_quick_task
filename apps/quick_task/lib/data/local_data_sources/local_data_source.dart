import 'package:local_storage/local_storage.dart';
import 'package:picasso/di/injection_container.dart';

import '../../core/enums/config_names.dart';

class LocalDataSource {
  static const _language = BaseConfigs.lang;

  Future<void> setLanguage(String value) {
    return sl<UnicodeStorage>().setString(_language, value);
  }

  String? getLanguage() {
    return sl<UnicodeStorage>().getString(_language);
  }

  static const _firstLaunch = 'first_launch';

  Future<void> setFirstLaunch(bool value) {
    return sl<UnicodeStorage>().setBool(_firstLaunch, value);
  }

  bool getFirstLaunch() {
    return sl<UnicodeStorage>().getBool(_firstLaunch) ?? true;
  }
}
