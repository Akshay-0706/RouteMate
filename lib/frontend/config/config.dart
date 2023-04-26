import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/frontend/config/components/body.dart';
import 'package:routing/models/location.dart';

class Config extends StatelessWidget {
  const Config({super.key, required this.locations});

  final List<Marker> locations;

  @override
  Widget build(BuildContext context) {
    return ConfigBody(
      locations: locations,
    );
  }
}
