import 'package:flutter/material.dart';
import 'package:picasso/models/config.dart';

import '../../di/injection_container.dart';

class HeadingStyle {
  static TextStyle largeTitleBold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: sl<Config>().theme!.black,
  );

  static TextStyle largeTitleNormal = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.normal,
    color: sl<Config>().theme!.black,
  );

  static TextStyle largeTitleLight = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w200,
    color: sl<Config>().theme!.black,
  );

  static TextStyle titleBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: sl<Config>().theme!.black,
  );

  static TextStyle titleNormal = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: sl<Config>().theme!.black,
  );

  static TextStyle titleLight = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w200,
    color: sl<Config>().theme!.black,
  );

  static TextStyle subtitleBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: sl<Config>().theme!.black,
  );

  static TextStyle subtitleNormal = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: sl<Config>().theme!.black,
  );

  static TextStyle subtitleLight = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w200,
    color: sl<Config>().theme!.black,
  );
}

class BodyStyle {
  static TextStyle body1Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: sl<Config>().theme!.black,
  );

  static TextStyle body1Normal = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: sl<Config>().theme!.black,
  );

  static TextStyle body1Light = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: sl<Config>().theme!.black,
  );

  static TextStyle body2Bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: sl<Config>().theme!.black,
  );

  static TextStyle body2Normal = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: sl<Config>().theme!.black,
  );

  static TextStyle body2Light = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: sl<Config>().theme!.black,
  );
}

class PicassoButtonStyle {
  static TextStyle buttonBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: sl<Config>().theme!.black,
  );

  static TextStyle buttonNormal = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: sl<Config>().theme!.black,
  );

  static TextStyle buttonLight = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    color: sl<Config>().theme!.black,
  );
}