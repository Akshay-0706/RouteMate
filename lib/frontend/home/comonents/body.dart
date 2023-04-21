import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition mumbai = CameraPosition(
    target: LatLng(19.118154, 72.847336),
    zoom: 15,
  );

  List<Marker> markers = [];
  List<Marker> data = const [
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

  @override
  void initState() {
    markers.addAll(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: mumbai,
        compassEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
