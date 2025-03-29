import 'dart:convert';

import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Model.dart';
import 'package:http/http.dart' as http;
import 'package:vnptapp/screen/Drawer/DiaBan/BaoHongNMK/Constant.dart';

Future<List<BaoHongNMK>> listBaoHongNMK(
    int pageNumber,
    int pageSize,
    var timeKey,
    var maNVTHNS,
    String keyWord,
    int chucDanh,
    String subUrlApi,
    String? nhanVienDonViID,
    var donviId) async {
  var responseStatus = '';
  try {
    http.Response response;
    String url =
        "$subUrlApi${BaoHongNMK_Constant.getListBaoHong}?timeKey=$timeKey&searchKey=$keyWord";
    // url =
    //     '$url?PageNumber=$pageNumber&PageSize=$pageSize&maNV=$maNV&keyword=$keyWord&nhanVienDonVi=$nhanVienDonViID';
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
          "pageNumber": pageNumber,
          "pageSize": pageSize,
          "tenDonVi": donviId,
          "nhanVienDonVi": nhanVienDonViID.toString(),
          "maNV": maNVTHNS,
          "chucDanh": chucDanh.toString()
        }));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      BaoHongNMK_Constant.totalPage = json.decode(response.body)['totalPage'];
      BaoHongNMK_Constant.totalItem = json.decode(response.body)['totalItem'];
      return jsonResponse.map((data) => BaoHongNMK.fromJson(data)).toList();
    } else if (response.reasonPhrase == "Unauthorized") {
      responseStatus = 'Unauthorized';
      throw Exception('Unauthorize');
    } else if (response.body == "Nhân viên không thuộc C3 nào") {
      throw Exception("Nhân viên không thuộc C3 nào");
    } else {
      throw Exception('Không thể load báo hỏng nhà mạng khác');
    }
  } catch (e) {
    if (responseStatus == 'Unauthorized') {
      throw Exception('Unauthorized');
    }
    if (e.toString() == "Exception: Nhân viên không thuộc C3 nào") {
      throw Exception("Nhân viên không thuộc C3 nào");
    }
    print(e.toString());
    throw Exception('Không thể load báo hỏng nhà mạng khác');
  }
}

Future<String> capNhatTrangThaiOB(int id, String tenNv, String maNv,
    bool trangThaiOB, String subUrlApi) async {
  http.Response response;
  String url =
      "$subUrlApi${BaoHongNMK_Constant.getListBaoHong}?id=$id&trangThaiOB=$trangThaiOB";
  response = await http.put(Uri.parse(url),
      headers: requestHeader,
      body: json.encode(<String, dynamic>{
        "pageNumber": 0,
        "pageSize": 0,
        "tenDonVi": "",
        "nhanVienDonVi": tenNv,
        "maNV": maNv,
        "chucDanh": 0
      }));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "Cập nhật thất bại vui lòng kiểm tra lại đường truyền";
  }
}

Future<BaoHongNMK> detailBaoHongNMK(
  int id,
  int chucDanh,
  String subUrlApi,
  String? nhanVienDonViID,
  var maNVTHNS,
) async {
  var responseStatus = '';
  try {
    http.Response response;
    String url = "$subUrlApi${BaoHongNMK_Constant.getDetailBaoHong}";
    // url =
    //     '$url?PageNumber=$pageNumber&PageSize=$pageSize&maNV=$maNV&keyword=$keyWord&nhanVienDonVi=$nhanVienDonViID';
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
          "pageNumber": id,
          "pageSize": 0,
          "tenDonVi": "",
          "nhanVienDonVi": nhanVienDonViID.toString(),
          "maNV": maNVTHNS,
          "chucDanh": chucDanh
        }));
    if (response.statusCode == 200) {
      var result = json.decode(response.body)['data'];
      BaoHongNMK baohong = BaoHongNMK.fromJson(result);
      return baohong;
    } else if (response.reasonPhrase == "Unauthorized") {
      responseStatus = 'Unauthorized';
      throw Exception('Unauthorize');
    } else if (response.body == "Nhân viên không thuộc C3 nào") {
      throw Exception("Nhân viên không thuộc C3 nào");
    } else {
      throw Exception('Không thể load báo hỏng nhà mạng khác');
    }
  } catch (e) {
    if (responseStatus == 'Unauthorized') {
      throw Exception('Unauthorized');
    }
    if (e.toString() == "Exception: Nhân viên không thuộc C3 nào") {
      throw Exception("Nhân viên không thuộc C3 nào");
    }
    throw Exception('Không thể load báo hỏng nhà mạng khác');
  }
}
