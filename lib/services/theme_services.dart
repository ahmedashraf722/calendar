import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _boxS = GetStorage();
  final _key = 'isDarkMode';

  isSaveThemeToBox(bool isDarkMode) {
    _boxS.write(_key, isDarkMode);
  }

  bool isLoadThemeFromBox() {
    return _boxS.read<bool>(_key) ?? false;
  }

  ThemeMode get theme {
    return isLoadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    Get.changeThemeMode(
        isLoadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    isSaveThemeToBox(!isLoadThemeFromBox());
  }
}
