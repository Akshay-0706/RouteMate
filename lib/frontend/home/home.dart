import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/backend/algorithm/api.dart';
import 'package:routing/backend/maps/map_api.dart';
import 'package:routing/models/directions.dart';
import 'package:routing/models/distance_matrix.dart';
import 'package:routing/models/location.dart';
import 'package:routing/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition mumbai = CameraPosition(
    target: LatLng(19.0760, 72.8777),
    zoom: 13,
  );

  // BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  static StreamSubscription<DatabaseEvent>? subscription;

  static var result;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  Directions? resultRoute; // currently for 1, make for k
  static DatabaseReference ref = FirebaseDatabase.instance.ref('/Algorithm2');

  String getMarkerId() {
    return (markers.length + 1).toString();
  }

  String getPolylineId() {
    return 'polyline ${polylines.length + 1}';
  }

  void addMarker(LatLng argument) {
    markers.add(
      Marker(
        markerId: MarkerId(getMarkerId()),
        position: argument,
        draggable: true,
        icon: locationIcon,
      ),
    );
    setState(() {});
  }

  bool inRange(LatLng latLng1, LatLng latLng2) {
    if ((latLng1.latitude - latLng2.latitude).abs() <= 0.0001 &&
        (latLng1.longitude - latLng2.longitude).abs() <= 0.0001) {
      return true;
    }
    return false;
  }

  void deleteMarker(LatLng latLng) {
    markers.removeWhere((element) => inRange(latLng, element.position));
    setState(() {});
  }

  static void startSubscription() {
    subscription = ref.child('output').onValue.listen((event) {
      log.d('Data changed');
      log.d(event.snapshot.value);
      result = event.snapshot.value as Map;
      log.d(result['k']);
      // update result routes
    });
  }

  static void stopSubscription() {
    if (subscription != null) subscription!.cancel();
  }

  @override
  void initState() {
    startSubscription();
    markers = {
      Marker(
        markerId: MarkerId(getMarkerId()),
        position: const LatLng(19.0760, 72.8777),
        draggable: true,
        icon: locationIcon,
      ),
      Marker(
        markerId: MarkerId(getMarkerId()),
        position: const LatLng(19.09, 72.97),
        icon: locationIcon,
      ),
    };

    super.initState();
  }

  //https://maps.googleapis.com/maps/api/distancematrix/json?destinations=San%20Francisco%7CVictoria%20BC&language=fr-FR&mode=bicycling&origins=Vancouver%20BC%7CSeattle

  //https://maps.googleapis.com/maps/api/directions/json?destination=Montreal&origin=Toronto&key=YOUR_API_KEY

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 85, 154),
        onPressed: () async {
          resultRoute = await MapApi.getDirectionsWithWayPoints(
              const LatLng(19.0760, 72.8777), const LatLng(19.09, 72.97), [
            const LatLng(19.0790, 72.91),
            const LatLng(19.08, 72.92),
          ]);
          log.d(resultRoute?.polylinePoints.length);
          setState(() {});
        },
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: mumbai,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onLongPress: (LatLng argument) => addMarker(argument),
        onTap: (LatLng argument) => deleteMarker(argument),
        markers: markers,
        polylines: {
          if (resultRoute != null)
            Polyline(
              polylineId: PolylineId(getPolylineId()),
              points: resultRoute!.polylinePoints
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
              width: 5,
              color: Colors.red,
            ),
        },
      ),
    );
  }

  @override
  void dispose() {
    stopSubscription();
    super.dispose();
  }
}



/*

    onPressed: () async {
          print('hello called');
          log.d('hello called');
          // final distanceMatrix = DistanceMatrix.fromJson(
          //     jsonDecode(DistanceMatrix.sampleResponse));

          final DistanceMatrix? res = await MapApi.getDistances(const [
            LatLng(19.0760, 72.8777), //src
            LatLng(19.0780, 72.97),
            LatLng(19.0780, 72.97)
          ], const [
            LatLng(19.0760, 72.88), //dest
            LatLng(19.00, 72.87)
          ]);

          if (res == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error fetching data'),
              ),
            );
            return;
          }

          for (int i = 2; i < markers.length; i++) {
            Marker element = markers.elementAt(i);
            res.locations.add(
              Location(
                latitude: element.position.latitude,
                longitude: element.position.longitude,
                name: 'Location',
                id: int.parse(element.mapsId.value),
              ),
            );
          }

          Marker dest = markers.elementAt(1);
          Marker src = markers.elementAt(0);

          res.destination = Location(
              latitude: dest.position.latitude,
              longitude: dest.position.longitude,
              name: res.destinationAddresses![0],
              id: int.parse(dest.mapsId.value));

          res.source = Location(
              latitude: src.position.latitude,
              longitude: src.position.longitude,
              name: res.originAddresses![0],
              id: int.parse(src.mapsId.value));

          log.d(res.rows!.length);

          await API.addData(res);
        },
     
*/