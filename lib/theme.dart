import 'package:flutter/material.dart';

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
        backgroundColor: Global.background,
        iconTheme: IconThemeData(color: Global.foreground),
      ),
      scaffoldBackgroundColor: Global.background,
      backgroundColor: Global.background,
      colorScheme:
          const ColorScheme.light().copyWith(secondary: Global.primary),
      primaryColor: Global.primary,
      primaryColorLight: Global.foregroundAlt,
      primaryColorDark: Global.foreground,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "OverPass",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Global.backgroundDark,
        iconTheme: IconThemeData(color: Global.foregroundDark),
      ),
      scaffoldBackgroundColor: Global.backgroundDark,
      backgroundColor: Global.backgroundDark,
      colorScheme:
          const ColorScheme.dark().copyWith(secondary: Global.primaryDark),
      primaryColor: Global.primaryDark,
      primaryColorLight: Global.foregroundAltDark,
      primaryColorDark: Global.foregroundDark,
    );
  }
}

class Global {
  // Light mode colors
  static Color primary = const Color(0xff5E00F5);
  static Color foreground = const Color(0xff1C1C23);
  static Color foregroundAlt = Colors.black;
  static Color background = const Color(0xffFCF7F8);

  // Dark mode colors
  static Color? primaryDark = const Color(0xff5E00F5);
  static Color foregroundDark = const Color(0xffFCF7F8);
  static Color foregroundAltDark = const Color(0xffD2D2D2);
  static Color backgroundDark = const Color(0xff1C1C23);
}

class Pallete {
  final BuildContext context;

  Pallete(this.context);

  Color primary() => Theme.of(context).primaryColor;
  Color primaryLight() => Theme.of(context).primaryColorLight;
  Color primaryDark() => Theme.of(context).primaryColorDark;
  Color background() => Theme.of(context).backgroundColor;
}
