import 'package:flutter/material.dart';

class ThemeColors {
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

  Color get primary => Theme.of(context).primaryColor;
  Color get primaryLight => Theme.of(context).primaryColorLight;
  Color get primaryDark => Theme.of(context).primaryColorDark;
  Color get background => Theme.of(context).backgroundColor;
}

class Constants {
  static late final MAP_API_KEY;

  static const String MAP_BASE_URL = "https://maps.googleapis.com/maps/api/";

  static const int TRUCK_CAPACITY = 20;
  static const int NO_OF_TRUCKS = 20;
// class Backend {
//   static int truckCapacity = 0;
//   static int truckSpeed = 20;

}
