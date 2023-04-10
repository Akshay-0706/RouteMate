import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/const.dart';
import 'package:routing/models/distance_matrix.dart';
import 'package:routing/utils.dart';

class MapApi {
  static Future<DistanceMatrix?> getDistanceMatrix(
      {required LatLng origin, required LatLng destination}) async {
    final url = Uri.parse(
        '${Constants.MAP_BASE_URL}distancematrix/json?units=metric&origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=${Constants.MAP_API_KEY}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return DistanceMatrix.fromJson(jsonDecode(response.body));
    } else {
      log.d(response.body);
      log.d(response.statusCode);
    }

    return null;
  }

  static Future<DistanceMatrix?> getDistances(
      List<LatLng> origins, List<LatLng> destinations) async {
    String destinationsArray =
        destinations.map((e) => '${e.latitude},${e.longitude}').join('|');
    String originsArray =
        origins.map((e) => '${e.latitude},${e.longitude}').join('|');

    final url = Uri.parse(
        '${Constants.MAP_BASE_URL}distancematrix/json?units=metric&origins=${originsArray}&destinations=${destinationsArray}&key=${Constants.MAP_API_KEY}');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      log.d(response.body);
      return DistanceMatrix.fromJson(jsonDecode(response.body));
    } else {
      log.d(response.body);
      log.d(response.statusCode);
    }

    return null;
  }
}
