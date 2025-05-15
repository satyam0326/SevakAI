import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Pref {
  static late Box _box;
  static bool _initialized = false;

  static Future<void> initialize() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    _box = await Hive.openBox('myData');
    _initialized = true;
  }

  static bool showOnboarding() {
    assert(_initialized, 'Pref must be initialized first');
    return _box.get('showOnboarding', defaultValue: true);
  }

  static Future<void> setShowOnboarding(bool v) async {
    assert(_initialized, 'Pref must be initialized first');
    await _box.put('showOnboarding', v);
  }

  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  static ThemeMode get defaultTheme {
    final data = _box.get('isDarkMode');
    log('data: $data');
    if (data == null) return ThemeMode.system;
    if (data == true) return ThemeMode.dark;
    return ThemeMode.light;
  }
}
