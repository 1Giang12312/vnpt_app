class Role {
  final int id;
  final double user_one;
  final String role;
  final DateTime mo_ta;

  Role({
    required this.id,
    required this.user_one,
    required this.role,
    required this.mo_ta,
  });

  // Hàm từ JSON sang Object
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'].toInt(),
      user_one: json['user_one'],
      role: json['role'],
      mo_ta: json['mo_ta'],
    );
  }
}
