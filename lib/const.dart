import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ThemeColors {
  // Light mode colors
  static Color primary = const Color(0xff2d60e3);
  static Color foreground = const Color(0xff1C1C23);
  static Color foregroundAlt = Colors.black;
  static Color background = const Color(0xffEFF2F9);

  // Dark mode colors
  static Color? primaryDark = const Color(0xff2d60e3);
  static Color foregroundDark = const Color(0xffEFF2F9);
  static Color foregroundAltDark = const Color(0xFFD3D3D3);
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
  static late String mapApiKey;

  static const String mapBaseUrl = "https://maps.googleapis.com/maps/api/";

  static int key = -1;
  static int noOfTrucks = 20;
  static int variance = 1;
  static double truckCapacity = 20;

  static List<Color> routeColors = [
    const Color(0xffE5233B),
    const Color(0xffDCA63A),
    const Color(0xff4C9E38),
    const Color(0xff25BDE2),
    const Color(0xffFD6824),
    const Color(0xff56C02A),
  ];

  static const List<Marker> data = [
    Marker(
      markerId: MarkerId("1"),
      infoWindow: InfoWindow(title: "Home"),
      position: LatLng(19.130036, 72.875422),
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(19.130543, 72.875092),
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(19.127401, 72.874772),
    ),
    Marker(
      markerId: MarkerId("4"),
      position: LatLng(19.124188, 72.874793),
    ),
    Marker(
      markerId: MarkerId("5"),
      position: LatLng(19.129718, 72.877752),
    ),
    Marker(
      markerId: MarkerId("6"),
      position: LatLng(19.119566, 72.846572),
    ),
    Marker(
      markerId: MarkerId("7"),
      position: LatLng(19.119275, 72.848298),
    ),
    Marker(
      markerId: MarkerId("8"),
      position: LatLng(19.118154, 72.847336),
    ),
    Marker(
      markerId: MarkerId("9"),
      position: LatLng(19.123443, 72.836400),
    ),
    Marker(
      markerId: MarkerId("10"),
      position: LatLng(19.124684, 72.838136),
    ),
    Marker(
      markerId: MarkerId("11"),
      position: LatLng(19.126708, 72.837662),
    ),
    Marker(
      markerId: MarkerId("12"),
      position: LatLng(19.123394, 72.843435),
    ),
  ];
}
