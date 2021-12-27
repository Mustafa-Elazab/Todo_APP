import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDark';
  _saveThemeToBox(bool isDarkNode) => _box.write(_key, isDarkNode);
  bool _loadTheme() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadTheme() ? ThemeMode.light : ThemeMode.dark  );
    _saveThemeToBox(!_loadTheme());
  }
}
