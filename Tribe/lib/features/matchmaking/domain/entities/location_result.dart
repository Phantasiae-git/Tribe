class LocationResult {
  final String name;
  final String type;
  final String displayName;
  final double lat;
  final double lon;

  LocationResult({
    required this.name,
    required this.type,
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  factory LocationResult.fromJson(Map<String, dynamic> json) {
    return LocationResult(
      name: json['name'] ?? json['display_name'],
      type: json['type'],
      displayName: json['display_name'],
      lat: double.parse(json['lat']),
      lon: double.parse(json['lon']),
    );
  }
}
