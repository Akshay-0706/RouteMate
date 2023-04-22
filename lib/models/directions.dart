import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    final bounds = map['bounds'];
    final northeast = bounds['northeast'];
    final southwest = bounds['southwest'];

    final northeastLatLng = LatLng(northeast['lat'], northeast['lng']);
    final southwestLatLng = LatLng(southwest['lat'], southwest['lng']);
    final latLngBounds =
        LatLngBounds(northeast: northeastLatLng, southwest: southwestLatLng);

    final polylinePoints = PolylinePoints();
    final List<PointLatLng> points =
        polylinePoints.decodePolyline(map['overview_polyline']['points']);

    return Directions(
      bounds: latLngBounds,
      polylinePoints: points,
      totalDistance: map['legs'][0]['distance']['text'],
      totalDuration: map['legs'][0]['duration']['text'],
    );
  }
}
