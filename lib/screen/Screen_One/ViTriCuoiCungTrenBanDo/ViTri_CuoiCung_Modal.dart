class Modal_NV {
  final double latitude;
  final double longitude;
  final String userOne;
  final DateTime timestamp;
  final String hoTen;
  Modal_NV({
    required this.latitude,
    required this.longitude,
    required this.userOne,
    required this.timestamp,
    required this.hoTen
  });

  // Hàm từ JSON sang Object
  factory Modal_NV.fromJson(Map<String, dynamic> json) {
    return Modal_NV(
      hoTen: json['ten_nv'],
      latitude: json['latitude'] ?? json['latitude'].toDouble() ,
      longitude: json['longitude'] ?? json['longitude'].toDouble(),
      userOne: json['ma_nd'],
      timestamp:  DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['timestamp']?.replaceAll(RegExp(r'\D'), ''))) ?? DateTime.now(),
    );
  }
}
