import 'package:flutter/material.dart';
import 'package:picasso/models/extensions.dart';

class PicassoTheme {
  final bool _isDarkTheme;
  final String _customerColor;
  final String _customerColorLight;
  final String _accentColor;
  final String _black;
  final String _white;
  final String _grey;
  final String _red;
  final String _orange;
  final String _yellow;
  final String _green;
  final String _purple;
  final String _brown;
  final String _blue;
  
  PicassoTheme({
    required bool isDarkTheme,
    required String customerColor,
    required String customerColorLight,
    required String accentColor,
    required String black,
    required String white,
    required String grey,
    required String red,
    required String orange,
    required String yellow,
    required String green,
    required String purple,
    required String brown,
    required String blue,
  })  : _isDarkTheme = isDarkTheme,
        _customerColor = customerColor,
        _customerColorLight = customerColorLight,
        _accentColor = accentColor,
        _black = black,
        _white = white,
        _grey = grey,
        _red = red,
        _orange = orange,
        _yellow = yellow,
        _green = green,
        _purple = purple,
        _brown = brown,
        _blue = blue;

  bool get isDarkTheme => _isDarkTheme;

  Color get customerColor => HexaColor.fromHex(_customerColor);

  Color get customerColorLight => HexaColor.fromHex(_customerColorLight);

  Color get accentColor => HexaColor.fromHex(_accentColor);

  Color get black => HexaColor.fromHex(_black);

  Color get white => HexaColor.fromHex(_white);
  
  Color get grey => HexaColor.fromHex(_grey);

  Color get red => HexaColor.fromHex(_red);

  Color get orange => HexaColor.fromHex(_orange);

  Color get yellow => HexaColor.fromHex(_yellow);

  Color get green => HexaColor.fromHex(_green);

  Color get purple => HexaColor.fromHex(_purple);

  Color get brown => HexaColor.fromHex(_brown);

  Color get blue => HexaColor.fromHex(_blue);

  factory PicassoTheme.fromJson(Map<String, dynamic> json) => PicassoTheme(
        isDarkTheme: json['is_dark_theme'],
        customerColor: json['customer_color'],
        customerColorLight: json['customer_color_light'],
        accentColor: json['accent_color'],
        black: json['black'],
        white: json['white'],
        grey: json['grey'],
        red: json['red'],
        orange: json['orange'],
        yellow: json['yellow'],
        green: json['green'],
        purple: json['purple'],
        brown: json['brown'],
        blue: json['blue'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_dark_theme'] = _isDarkTheme;
    data['customer_color'] = _customerColor;
    data['customer_color_light'] = _customerColorLight;
    data['accent_color'] = _accentColor;
    data['black'] = _black;
    data['white'] = _white;
    data['grey'] = _grey;
    data['red'] = _red;
    data['orange'] = _orange;
    data['yellow'] = _yellow;
    data['green'] = _green;
    data['purple'] = _purple;
    data['brown'] = _brown;
    data['blue'] = _blue;
    return data;
  }

  Color get buttonContentColor => isDarkTheme ? white : grey;

  Color get buttonContentSecondaryColor => isDarkTheme ? white : grey;

  Color get negativeActionButtonColor => isDarkTheme ? customerColor : grey;

  Color disabledStateColor({required bool isDisabled}) => isDisabled
      ? white
      : isDarkTheme
          ? customerColor
          : grey;

  Color disabledStateButtonContentColor({
    required bool isDisabled,
    bool hasLightBG = false,
  }) =>
      isDisabled
          ? white
          : isDarkTheme && !hasLightBG
              ? white
              : grey;
}
