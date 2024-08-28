library local_storage;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UnicodeStorage {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<void> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  Future<void> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  void setDouble(String key, double value) {
    _sharedPreferences.setDouble(key, value);
  }

  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  void setInt(String key, int value) {
    _sharedPreferences.setInt(key, value);
  }

  Object? get(String key) {
    return _sharedPreferences.get(key);
  }

  Set<String>? getKeys(String key) {
    return _sharedPreferences.getKeys();
  }

  Future<void> setJsonAsMap(String key, Map<String, dynamic> value) async {
    final jsonString = json.encode(value);
    await _sharedPreferences.setString(key, jsonString);
  }

  Map<String, dynamic>? getJsonAsMap(String key) {
    final jsonString = _sharedPreferences.getString(key);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      if (jsonMap is Map<String, dynamic>) {
        return jsonMap;
      }
    }
    return null;
  }

  Future<void> delete(String key) async {
    await _sharedPreferences.remove(key);
  }

  bool containKey(String key) {
    return _sharedPreferences.containsKey(key);
  }
}
