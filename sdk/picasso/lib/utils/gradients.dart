import 'package:flutter/material.dart';
import 'package:picasso/models/config.dart';
import 'package:picasso/models/extensions.dart';

import '../di/injection_container.dart';

class Gradients {
  static List<Color> customer = [
    sl<Config>().theme!.customerColor,
    sl<Config>().theme!.customerColorLight,
  ];

  static List<Color> grey = [
    const Color(0xFFAAAAAA),
    const Color(0xFFAAAAAA).withOpacity(0.5),
  ];

  static List<Color> customerDisabledBG = [
    sl<Config>().theme!.accentColor,
    sl<Config>().theme!.accentColor,
  ];

  static (Alignment begin, Alignment end) gradientEdges({
    bool isLTR = false,
    Alignment gradientBegin = Alignment.bottomLeft,
    Alignment gradientEnd = Alignment.topRight,
  }) {
    Alignment begin = isLTR ? gradientBegin : gradientBegin.opposite();
    Alignment end = isLTR ? gradientEnd : gradientEnd.opposite();

    return (
      Alignment(
        begin.x + 0.1,
        begin.y,
      ),
      Alignment(
        end.x + 0.5,
        end.y,
      ),
    );
  }
}
