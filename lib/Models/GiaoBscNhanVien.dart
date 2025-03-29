class GiaoBscNhanVien {
    int? nhanviengiao;
    int? nhanviennhan;
    int? thang;
    int? nam;
    int? donvi;
    bool? trangthaigiao;
    bool? trangthaicham;
    bool? trangthaidongyKqtd;
    bool? trangthaiketthuc;
    DateTime? ngaytao;
    int? loaimau;
    bool? trangthainhan;
    String? nhanvienManv;
    String? nhanvienHoten;
    String? donviTen;
    String? trangthaithamdinh;
    String? ngayThamDinh;

    GiaoBscNhanVien({
        this.nhanviengiao,
        this.nhanviennhan,
        this.thang,
        this.nam,
        this.donvi,
        this.trangthaigiao,
        this.trangthaicham,
        this.trangthaidongyKqtd,
        this.trangthaiketthuc,
        this.ngaytao,
        this.loaimau,
        this.trangthainhan,
        this.nhanvienManv,
        this.nhanvienHoten,
        this.donviTen,
        this.trangthaithamdinh,
        this.ngayThamDinh,
    });

    factory GiaoBscNhanVien.fromJson(Map<String, dynamic> json) => GiaoBscNhanVien(
        nhanviengiao: json["nhanviengiao"],
        nhanviennhan: json["nhanviennhan"],
        thang: json["thang"],
        nam: json["nam"],
        donvi: json["donvi"],
        trangthaigiao: json["trangthaigiao"],
        trangthaicham: json["trangthaicham"],
        trangthaidongyKqtd: json["trangthaidongyKqtd"],
        trangthaiketthuc: json["trangthaiketthuc"],
        ngaytao: json["ngaytao"] == null ? null : DateTime.parse(json["ngaytao"]),
        loaimau: json["loaimau"],
        trangthainhan: json["trangthainhan"],
        nhanvienManv: json["nhanvienManv"],
        nhanvienHoten: json["nhanvienHoten"],
        donviTen: json["donviTen"],
        trangthaithamdinh: json["trangthaithamdinh"],
        ngayThamDinh: json["ngayThamDinh"],
    );

    Map<String, dynamic> toJson() => {
        "nhanviengiao": nhanviengiao,
        "nhanviennhan": nhanviennhan,
        "thang": thang,
        "nam": nam,
        "donvi": donvi,
        "trangthaigiao": trangthaigiao,
        "trangthaicham": trangthaicham,
        "trangthaidongyKqtd": trangthaidongyKqtd,
        "trangthaiketthuc": trangthaiketthuc,
        "ngaytao": ngaytao?.toIso8601String(),
        "loaimau": loaimau,
        "trangthainhan": trangthainhan,
        "nhanvienManv": nhanvienManv,
        "nhanvienHoten": nhanvienHoten,
        "donviTen": donviTen,
        "trangthaithamdinh": trangthaithamdinh,
        "ngayThamDinh": ngayThamDinh,
    };
}
