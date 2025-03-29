// // ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

// class HeSoSanLuongVT_CNTT {
//   late String? timekey;
//   late String? nhanvien_pbh;
//   late String? nhanvien_smcs;
//   late String? nhanvien_chucdanh;
//   late double? ke_hoach;
//   late int? sl_fiber;
//   late double? fiber_quy_doi;
//   late int? sl_mytv;
//   late double? mytv_quy_doi;
//   late int? sl_mesh;
//   late double? mesh_quy_doi;
//   late int? sl_camera;
//   late double? camera_quy_doi;
//   late int? sl_ddts;
//   late double? doanh_thu_ddts;
//   late double? ddts_quy_doi;
//   late int? sl_ddtt;
//   late double? doanh_thu_ddtt;
//   late double? ddtt_quy_doi;
//   late double? tong_diem;
//   late double? he_so_quy_doi;
//   late double? he_so_p1;
//   late double? he_so_p2;
//   HeSoSanLuongVT_CNTT({
//     required this.timekey,
//     required this.nhanvien_pbh,
//     required this.nhanvien_smcs,
//     required this.nhanvien_chucdanh,
//     required this.ke_hoach,
//     required this.sl_fiber,
//     required this.fiber_quy_doi,
//     required this.sl_mytv,
//     required this.mytv_quy_doi,
//     required this.sl_mesh,
//     required this.mesh_quy_doi,
//     required this.sl_camera,
//     required this.camera_quy_doi,
//     required this.sl_ddts,
//     required this.doanh_thu_ddts,
//     required this.ddts_quy_doi,
//     required this.sl_ddtt,
//     required this.doanh_thu_ddtt,
//     required this.ddtt_quy_doi,
//     required this.tong_diem,
//     required this.he_so_quy_doi,
//     required this.he_so_p1,
//     required this.he_so_p2,
//   });
//   factory HeSoSanLuongVT_CNTT.fromJson(Map<String, dynamic> json) {
//     return HeSoSanLuongVT_CNTT(
//         timekey: json['timekey'],
//         nhanvien_pbh: json['nhanvienPbh'],
//         nhanvien_smcs: json['nhanvienSmcs'],
//         nhanvien_chucdanh: json['nhanvienChucdanh'],
//         ke_hoach: double.parse(json['keHoach'].toString()),
//         sl_fiber: json['slFiber'],
//         fiber_quy_doi: double.parse(json['fiberQuyDoi'].toString()),
//         sl_mytv: json['slMytv'],
//         mytv_quy_doi: double.parse(json['mytvQuyDoi'].toString()),
//         sl_mesh: json['slMesh'],
//         mesh_quy_doi: double.parse(json['meshQuyDoi'].toString()),
//         sl_camera: json['slCamera'],
//         camera_quy_doi: double.parse(json['cameraQuyDoi'].toString()),
//         sl_ddts: json['slDdts'],
//         doanh_thu_ddts: double.parse(json['doanhThuDdts'].toString()),
//         ddts_quy_doi:  double.parse(json['ddtsQuyDoi'].toString()),
//         sl_ddtt: json['slDdtt'],
//         doanh_thu_ddtt: double.parse( json['doanhThuDdtt'].toString()),
//         ddtt_quy_doi:  double.parse(json['ddttQuyDoi'].toString()),
//         tong_diem:  double.parse(json['tongDiem'].toString()),
//         he_so_quy_doi:  double.parse(json['heSoQuyDoi'].toString()),
//         he_so_p1:  double.parse(json['heSoP1'].toString()),
//         he_so_p2:  double.parse(json['heSoP2'].toString()));
//   }
// }


class HeSoSanLuongVtCntt {
    String? timekey;
    String? nhanvienPbh;
    String? nhanvienSmcs;
    String? nhanvienHoten;
    String? nhanvienChucdanh;
    double? tongDiem;
    double? fiberQuyDoi;
    double? mytvQuyDoi;
    double? meshQuyDoi;
    double? cameraQuyDoi;
    double? ddtsQuyDoi;
    double? ddttQuyDoi;
    double? heSoQuyDoi;
    double? heSoP1;
    double? heSoP2;

    HeSoSanLuongVtCntt({
        this.timekey,
        this.nhanvienPbh,
        this.nhanvienSmcs,
        this.nhanvienHoten,
        this.nhanvienChucdanh,
        this.tongDiem,
        this.fiberQuyDoi,
        this.mytvQuyDoi,
        this.meshQuyDoi,
        this.cameraQuyDoi,
        this.ddtsQuyDoi,
        this.ddttQuyDoi,
        this.heSoQuyDoi,
        this.heSoP1,
        this.heSoP2,
    });

    factory HeSoSanLuongVtCntt.fromJson(Map<String, dynamic> json) => HeSoSanLuongVtCntt(
        timekey: json["timekey"],
        nhanvienPbh: json["nhanvienPbh"],
        nhanvienSmcs: json["nhanvienSmcs"],
        nhanvienHoten: json["nhanvienHoten"],
        nhanvienChucdanh: json["nhanvienChucdanh"],
        tongDiem: json["tongDiem"]?.toDouble(),
        fiberQuyDoi: json["fiberQuyDoi"]?.toDouble(),
        mytvQuyDoi: json["mytvQuyDoi"]?.toDouble(),
        meshQuyDoi: json["meshQuyDoi"]?.toDouble(),
        cameraQuyDoi: json["cameraQuyDoi"]?.toDouble(),
        ddtsQuyDoi: json["ddtsQuyDoi"]?.toDouble(),
        ddttQuyDoi: json["ddttQuyDoi"]?.toDouble(),
        heSoQuyDoi: json["heSoQuyDoi"]?.toDouble(),
        heSoP1: json["heSoP1"]?.toDouble(),
        heSoP2: json["heSoP2"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "timekey": timekey,
        "nhanvienPbh": nhanvienPbh,
        "nhanvienSmcs": nhanvienSmcs,
        "nhanvienHoten": nhanvienHoten,
        "nhanvienChucdanh": nhanvienChucdanh,
        "tongDiem": tongDiem,
        "fiberQuyDoi": fiberQuyDoi,
        "mytvQuyDoi": mytvQuyDoi,
        "meshQuyDoi": meshQuyDoi,
        "cameraQuyDoi": cameraQuyDoi,
        "ddtsQuyDoi": ddtsQuyDoi,
        "ddttQuyDoi": ddttQuyDoi,
        "heSoQuyDoi": heSoQuyDoi,
        "heSoP1": heSoP1,
        "heSoP2": heSoP2,
    };
}
