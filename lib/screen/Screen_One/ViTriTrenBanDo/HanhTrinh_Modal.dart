class LocationData {
  final double latitude;
  final double longitude;
  final String userOne;
  final DateTime timestamp;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.userOne,
    required this.timestamp,
  });

  // Hàm từ JSON sang Object
  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      userOne: json['user_one'],
      timestamp:  DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['timestamp']?.replaceAll(RegExp(r'\D'), ''))) ?? DateTime.now(),
    );
  }
}
