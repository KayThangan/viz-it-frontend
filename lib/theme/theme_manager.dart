import 'package:flutter/material.dart';
import 'package:viz_it_app/theme/theme.dart';


class ThemeManager extends ChangeNotifier {
  ThemeManager();

  // The ThemeData object which the app uses
  ThemeData? _themeData;

  ThemeData? get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.LIGHT];
    }
    return _themeData;
  }

  switchTheme() async {
    if (_themeData == appThemeData[AppTheme.LIGHT]) {
      _themeData = appThemeData[AppTheme.DARK];
    } else {
      _themeData = appThemeData[AppTheme.LIGHT];
    }

    notifyListeners();
  }
}
