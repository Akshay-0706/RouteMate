import 'package:routing/const.dart';
import 'package:routing/models/location.dart';
import 'package:routing/utils.dart';

class DistanceMatrix {
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Rows>? rows;
  String? status;

  List<Location> locations = [];
  Location? destination, source; // update here

  DistanceMatrix(
      {this.destinationAddresses,
      this.originAddresses,
      this.rows,
      this.status});

  DistanceMatrix.fromJson(Map<String, dynamic> json) {
    destinationAddresses = json['destination_addresses'].cast<String>();
    originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cap'] = Constants.truckCapacity;
    data['k'] = Constants.noOfTrucks;
    data['key'] = Constants.key;
    data['variance'] = Constants.variance;

    Map<String, dynamic> distances = <String, dynamic>{};

    // distances['distances'] = rows!.map((e) => e.elements!.map((e) => e.distance!.value).toList()).toList();

    for (int i = 0; i < rows!.length - 1; i++) {
      distances['$i'] = <String, dynamic>{};

      for (var j = 0; j < rows![i].elements!.length; j++) {
        if (i < j) {
          distances['$i']['$j'] = rows![i].elements![j].distance!.value;
        } else {
          distances['$i']['$j'] = -1;
        }
      }
    }

    data['distances'] = distances;

    Map<String, dynamic> endpoints = <String, dynamic>{};

    // endpoints['destination'] = {
    //   'id': destination!.id,
    //   'lat': destination!.latitude,
    //   'lon': destination!.longitude,
    //   'name': destination!.name
    // };

    // endpoints['source'] = {
    //   'id': source!.id,
    //   'lat': source!.latitude,
    //   'lon': source!.longitude,
    //   'name': source!.name
    // };

    data['endpoints'] = endpoints;

    Map<String, dynamic> locations = <String, dynamic>{};

    log.d(this.locations.length);

    for (int i = 0; i < this.locations.length; i++) {
      locations['$i'] = {
        'id': this.locations[i].id,
        'lat': this.locations[i].latitude,
        'lon': this.locations[i].longitude,
        'name': this.locations[i].name,
        'cap': this.locations[i].cap ?? 0
      };
    }

    data['locations'] = locations;

    // data['destination_addresses'] = destinationAddresses;
    // data['origin_addresses'] = originAddresses;
    // if (rows != null) {
    //   data['rows'] = rows!.map((v) => v.toJson()).toList();
    // }

    Map<String, dynamic> finalData = <String, dynamic>{};
    finalData['input'] = data;
    log.d(finalData);
    return finalData;
  }

  static String sampleResponse = '''{
    "destination_addresses": [
        "585 Schenectady Ave, Brooklyn, NY 11203, USA",
        "102-1 66th Rd, Forest Hills, NY 11375, USA",
        "1000 N Village Ave, Rockville Centre, NY 11570, USA",
        "3-28 Beach 19th St, Queens, NY 11691, USA"
    ],
    "origin_addresses": [
        "P.O. Box 793, Brooklyn, NY 11207, USA"
    ],
    "rows": [
        {
            "elements": [
                {
                    "distance": {
                        "text": "4.7 km",
                        "value": 4661
                    },
                    "duration": {
                        "text": "19 mins",
                        "value": 1119
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "13.8 km",
                        "value": 13784
                    },
                    "duration": {
                        "text": "23 mins",
                        "value": 1374
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "25.6 km",
                        "value": 25557
                    },
                    "duration": {
                        "text": "29 mins",
                        "value": 1768
                    },
                    "status": "OK"
                },
                {
                    "distance": {
                        "text": "21.3 km",
                        "value": 21332
                    },
                    "duration": {
                        "text": "34 mins",
                        "value": 2067
                    },
                    "status": "OK"
                }
            ]
        }
    ],
    "status": "OK"
  }''';
}

class Rows {
  List<Elements>? elements;

  Rows({this.elements});

  Rows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  Distance? distance;
  Distance? duration;
  String? status;

  Elements({this.distance, this.duration, this.status});

  Elements.fromJson(Map<String, dynamic> json) {
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    duration =
        json['duration'] != null ? Distance.fromJson(json['duration']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}
