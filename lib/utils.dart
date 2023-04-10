// Package imports:
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

final Logger log = Logger(
  printer: PrettyPrinter(
    colors: true,
  ),
);

late final BitmapDescriptor locationIcon;
