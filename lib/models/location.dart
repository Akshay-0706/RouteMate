class Location {
  final double latitude;
  final double longitude;
  final String name;
  final int id;
  final double cap;

  Location(
      {required this.latitude,
      required this.longitude,
      required this.name,
      required this.id,
      required this.cap});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      id: json['id'],
      cap: json['cap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
      'name': name,
      'id': id,
      'cap': cap,
    };
  }
}
