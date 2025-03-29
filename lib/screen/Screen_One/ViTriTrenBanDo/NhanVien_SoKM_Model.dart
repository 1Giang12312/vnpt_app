class NhanVien_SoKM_Model {
  final double total_distance_km;
  final String user_one;
  final DateTime date;

  NhanVien_SoKM_Model({
    required this.total_distance_km,
    required this.user_one,
    required this.date,
  });

  // Hàm từ JSON sang Object
  factory NhanVien_SoKM_Model.fromJson(Map<String, dynamic> json) {
    return NhanVien_SoKM_Model(
      total_distance_km: json['total_distance_km'].toDouble(),
      user_one: json['user_one'],
      date:  json['date'] != null ? DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['date'].replaceAll(RegExp(r'\D'), ''))) : DateTime.now(),
    );
  }
}