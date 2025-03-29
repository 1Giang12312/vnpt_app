class BaoHongNMK {
    int? id;
    String? datETime;
    String? accSMthdKey;
    String? loaITb;
    String? thoigiaNBd;
    String? thoigiaNKt;
    String? tonGTg;
    String? sOTongdai;
    String? nhAMang;
    String? hOTen;
    String? diAChi;
    String? mATinh;
    String? reselleRName;
    String? btSName;
    String? mAChuongTrinh;
    String? tenKv;
    String? trangThaiOb;
    dynamic tenNvOb;
    dynamic maNvOb;
    String? ngayCapNhatTrangThaiOB;
    BaoHongNMK({
        this.id,
        this.datETime,
        this.accSMthdKey,
        this.loaITb,
        this.thoigiaNBd,
        this.thoigiaNKt,
        this.tonGTg,
        this.sOTongdai,
        this.nhAMang,
        this.hOTen,
        this.diAChi,
        this.mATinh,
        this.reselleRName,
        this.btSName,
        this.mAChuongTrinh,
        this.tenKv,
        this.trangThaiOb,
        this.tenNvOb,
        this.maNvOb,
        this.ngayCapNhatTrangThaiOB
    });

    factory BaoHongNMK.fromJson(Map<String, dynamic> json) => BaoHongNMK(
        id: json["id"],
        datETime: json["datE_TIME"],
        accSMthdKey: json["accS_MTHD_KEY"],
        loaITb: json["loaI_TB"],
        thoigiaNBd: json["thoigiaN_BD"],
        thoigiaNKt: json["thoigiaN_KT"],
        tonGTg: json["tonG_TG"],
        sOTongdai: json["sO_TONGDAI"],
        nhAMang: json["nhA_MANG"],
        hOTen: json["hO_TEN"],
        diAChi: json["diA_CHI"],
        mATinh: json["mA_TINH"],
        reselleRName: json["reselleR_NAME"],
        btSName: json["btS_NAME"],
        mAChuongTrinh: json["mA_CHUONG_TRINH"],
        tenKv: json["ten_kv"],
        trangThaiOb: json["trangThaiOB"],
        tenNvOb: json["tenNvOB"],
        maNvOb: json["maNvOB"],
        ngayCapNhatTrangThaiOB: json["ngayCapNhatTrangThaiOB"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "datE_TIME": datETime,
        "accS_MTHD_KEY": accSMthdKey,
        "loaI_TB": loaITb,
        "thoigiaN_BD": thoigiaNBd,
        "thoigiaN_KT": thoigiaNKt,
        "tonG_TG": tonGTg,
        "sO_TONGDAI": sOTongdai,
        "nhA_MANG": nhAMang,
        "hO_TEN": hOTen,
        "diA_CHI": diAChi,
        "mA_TINH": mATinh,
        "reselleR_NAME": reselleRName,
        "btS_NAME": btSName,
        "mA_CHUONG_TRINH": mAChuongTrinh,
        "ten_kv": tenKv,
        "trangThaiOB": trangThaiOb,
        "tenNvOB": tenNvOb,
        "maNvOB": maNvOb,
    };
}
