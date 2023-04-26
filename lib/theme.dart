import 'package:flutter/material.dart';

import 'const.dart';

class ThemeChanger with ChangeNotifier {
  bool isDarkMode = true;
  String theme = "Auto";

  ThemeMode currentTheme() {
    return theme == "Auto"
        ? ThemeMode.system
        : theme == "Dark"
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  void changeThemeMode(String theme) {
    this.theme = theme;
    notifyListeners();
  }
}

class NewTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: ThemeColors.background,
        iconTheme: IconThemeData(color: ThemeColors.foreground),
      ),
      scaffoldBackgroundColor: ThemeColors.background,
      backgroundColor: ThemeColors.background,
      colorScheme:
          const ColorScheme.light().copyWith(secondary: ThemeColors.primary),
      primaryColor: ThemeColors.primary,
      primaryColorLight: ThemeColors.foregroundAlt,
      primaryColorDark: ThemeColors.foreground,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: ThemeColors.backgroundDark,
        iconTheme: IconThemeData(color: ThemeColors.foregroundDark),
      ),
      scaffoldBackgroundColor: ThemeColors.backgroundDark,
      backgroundColor: ThemeColors.backgroundDark,
      colorScheme:
          const ColorScheme.dark().copyWith(secondary: ThemeColors.primaryDark),
      primaryColor: ThemeColors.primaryDark,
      primaryColorLight: ThemeColors.foregroundAltDark,
      primaryColorDark: ThemeColors.foregroundDark,
    );
  }
}
