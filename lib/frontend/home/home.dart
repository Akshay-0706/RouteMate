import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routing/backend/algorithm/api.dart';
import 'package:routing/backend/maps/map_api.dart';
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

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  String getMarkerId() {
    return (markers.length + 1).toString();
  }

  String getPolylineId() {
    return 'polyline ${polylines.length + 1}';
  }

  // void initCustomIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(
  //       size: Size(5, 5),
  //     ),
  //     "assets/icons/location.png",
  //   ).then(
  //     (icon) {
  //       setState(() {
  //         markerIcon = icon;

  //       });
  //     },
  //   );
  // }

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

  // remove marker in 5 radius

  bool inRange(LatLng latLng1, LatLng latLng2) {
    if ((latLng1.latitude - latLng2.latitude).abs() <= 5 &&
        (latLng1.longitude - latLng2.longitude).abs() <= 5) {
      return true;
    }
    return false;
  }

  void deletemarker(LatLng latLng) {
    markers.removeWhere((element) => inRange(latLng, element.position));
  }

  @override
  void initState() {
    // initCustomIcon();
    markers = {
      Marker(
        markerId: MarkerId(getMarkerId()),
        position: const LatLng(19.0780, 72.97),
        draggable: true,
        icon: locationIcon,
      ),
      Marker(
        markerId: MarkerId(getMarkerId()),
        position: const LatLng(19.00, 72.87),
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
        onPressed: () async {
          print('hello called');
          log.d('hello called');
          final distanceMatrix = DistanceMatrix.fromJson(
              jsonDecode(DistanceMatrix.sampleResponse));

          final res = await API.addData(distanceMatrix);

          // final res = await MapApi.getDistances(const [
          //   LatLng(19.0760, 72.8777), //src
          //   LatLng(19.0780, 72.97),
          //   LatLng(19.0780, 72.97)
          // ], const [
          //   LatLng(19.0760, 72.88), //dest
          //   LatLng(19.00, 72.87)
          // ]);

          // for (int i = 2; i< markers.length; i++) {
          //   Marker element = markers.elementAt(i);
          //   res!.locations.add(Location(latitude: element.position.latitude, longitude: element.position.longitude , name: 'tempname' , id: int.parse(element.mapsId.value)));
          // }

          // Marker dest = markers.elementAt(1);
          // Marker src = markers.elementAt(0);

          // res!.destination = Location(latitude: dest.position.latitude , longitude: dest.position.longitude , name: res.destinationAddresses![0], id: int.parse(dest.mapsId.value));

          // res.source = Location(latitude: src.position.latitude , longitude: src.position.longitude , name: res.originAddresses![0], id: int.parse(src.mapsId.value));
        },
        backgroundColor: const Color.fromARGB(255, 0, 85, 154),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      // body: GoogleMap(
      //     mapType: MapType.normal,
      //     initialCameraPosition: mumbai,
      //     onMapCreated: (GoogleMapController controller) {
      //       _controller.complete(controller);
      //     },
      //     onLongPress: (LatLng argument) => addMarker(argument),
      //     markers: markers,
      //     polylines: {
      //       Polyline(
      //         polylineId: PolylineId('polyline'),
      //         points: [
      //           LatLng(19.09, 72.97),
      //           LatLng(19.00, 72.87),
      //         ],
      //         width: 5,
      //         color: Colors.red,
      //       ),
      //     })
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Text('Hello'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                labelText: 'Enter your Email',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                labelText: 'Enter your Name',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: Colors.black,
                ),
                labelText: 'Enter your balance',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.account_balance,
                  color: Colors.black,
                ),
                labelText: 'Enter your Bank name',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 85, 154),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*

       body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: mumbai,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onLongPress: (argument) {
              markers.add(
                Marker(
                  markerId: MarkerId(getMarkerId()),
                  position: argument,
                  draggable: true,
                  icon: locationIcon,
                ),
              );
              setState(() {});
            },
            markers: markers,
            polylines: {
              Polyline(
                polylineId: PolylineId('polyline'),
                points: [
                  LatLng(19.09, 72.97),
                  LatLng(19.00, 72.87),
                ],
                width: 5,
                color: Colors.red,
              ),
            }));


*/