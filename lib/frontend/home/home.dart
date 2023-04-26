import 'dart:async';
import 'dart:math' as Math;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/backend/maps/map_api.dart';
import 'package:routing/models/directions.dart';
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

  static StreamSubscription<DatabaseEvent>? subscription;

  static Map? dBResult;

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  List<Directions>? resultRoutes;
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
    log.d('markers length: ${markers.length}');
    setState(() {});
  }

  LatLng? getLatLongByMarkerId(int id) {
    LatLng? result;

    for (Marker element in markers) {
      if (element.markerId.value == id.toString()) {
        result = element.position;
      }
    }

    return result;
  }

  void getRoutes2(List r) {
    List<List<LatLng>> result = [];

    log.d(r.length);
    log.d(r.first?.length);

    for (int i = 0; i < r.length; i++) {
      List<LatLng> subresult = [];

      for (int j = 0; j < r[i].length; j++) {
        log.d(r[i][j]);
        LatLng? latLng = getLatLongByMarkerId(r[i][j]);

        if (latLng != null) {
          subresult.add(latLng);
        } else {
          log.d('Null');
        }
      }

      result.add(subresult);
    }

    resultRoutePoints = result;
  }

  void getRoutes(Map map, int k) {
    List<List<LatLng>> result = [];

    for (int i = 0; i < k; i++) {
      List<LatLng> subresult = [];

      for (int j = 0; j < map[i].length; j++) {
        LatLng? latLng = getLatLongByMarkerId(map[i][j]);

        if (latLng != null) {
          subresult.add(latLng);
        } else {
          log.d('Null');
        }
      }

      result.add(subresult);
    }

    resultRoutePoints = result;
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
      dBResult = event.snapshot.value as Map;
      log.d(dBResult!['k']);
      // update result routes
    });
  }

  static void stopSubscription() {
    if (subscription != null) subscription!.cancel();
  }

  @override
  void initState() {
    startSubscription();

    super.initState();
  }

  //https://maps.googleapis.com/maps/api/distancematrix/json?destinations=San%20Francisco%7CVictoria%20BC&language=fr-FR&mode=bicycling&origins=Vancouver%20BC%7CSeattle

  //https://maps.googleapis.com/maps/api/directions/json?destination=Montreal&origin=Toronto&key=YOUR_API_KEY

  List<List<LatLng>>? resultRoutePoints;

  @override
  Widget build(BuildContext context) {
    log.d(resultRoutes?.length);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 85, 154),
        onPressed: () async {
          solveOutput();
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
        polylines: polylines,
      ),
    );
  }

  void solve() async {
    // if (markers.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('No Locations selected'),
    //     ),
    //   );
    //   return;
    // }

    for (List<LatLng> route in resultRoutePoints!) {
      Directions? res = await MapApi.getDirectionsWithWayPoints(
        //start point
        route[0],
        //end point
        route[route.length - 1],
        // other points
        route.sublist(1, route.length - 1),
      );

      if (res == null) {
        log.d('Null');
      } else {
        log.d(res.polylinePoints.length);
      }

      resultRoutes ??= [];

      resultRoutes!.add(res!);
    }

    for (Directions element in resultRoutes!) {
      polylines.add(
        Polyline(
          polylineId: PolylineId(getPolylineId()),
          color:
              Colors.primaries[Math.Random().nextInt(Colors.primaries.length)],
          width: 5,
          points: element.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      );
    }

    setState(() {});
  }

  void solveOutput() {
    if (dBResult == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Output'),
        ),
      );
      return;
    }

    int k = dBResult!['k'];

    // getRoutes(dBResult!['routes'], k);

    getRoutes2(dBResult!['routes']);

    solve();
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