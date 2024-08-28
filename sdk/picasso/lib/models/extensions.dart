import 'package:flutter/material.dart';

extension HexaColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse(hex, radix: 16));
  }
}

extension IntegerX on double {
  BorderRadius toCircularRadius() {
    return BorderRadius.circular(this);
  }
}

extension AlignmentX on Alignment {
  Alignment opposite() {
    Map<Alignment, Alignment> opposites = {
      Alignment.topLeft: Alignment.bottomRight,
      Alignment.topRight: Alignment.bottomLeft,
      Alignment.bottomRight: Alignment.topLeft,
      Alignment.bottomLeft: Alignment.topRight,
      Alignment.centerLeft: Alignment.centerRight,
      Alignment.centerRight: Alignment.centerLeft,
      Alignment.bottomCenter: Alignment.topCenter,
      Alignment.topCenter: Alignment.bottomCenter,
    };

    return opposites[this] ?? Alignment.center;
  }
}
