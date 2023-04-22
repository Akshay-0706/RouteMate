class Location {
  final double latitude;
  final double longitude;
  final String name;
  final int id;

  Location(
      {required this.latitude,
      required this.longitude,
      required this.name,
      required this.id});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      id: json['id'],
    );
  }
}