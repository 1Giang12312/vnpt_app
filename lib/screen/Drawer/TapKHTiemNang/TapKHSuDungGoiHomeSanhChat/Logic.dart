import 'dart:convert';

import 'package:vnptapp/Models/TapKHSuDungGoiHomeSanhChat.dart';
import 'package:http/http.dart' as http;
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Drawer/TapKHTiemNang/TapKHSuDungGoiHomeSanhChat/Route.dart';
import 'package:vnptapp/screen/Drawer/TapKHTiemNang/TapKHSuDungGoiHomeSanhChat/Variable.dart';

Future<List<TapKhSuDungGoiHomeSanhChat>> getListTapKh(
    int pageNumber,
    int pageSize,
    var donViId,
    int nhanVienDonVi,
    String maNVSmcs,
    String chucDanh,
    var searchKey,
    String subUrlApi) async {
  var responseStatus = '';
  String url = subUrlApi + TapKHSuDungGoiHomeSanhChat_Route.getListTapKh;
  try {
    url = '$url?searchKey=$searchKey';
    //    print(url);
    http.Response response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
          "pageNumber": pageNumber,
          "pageSize": pageSize,
          "tenDonVi": donViId,
          "nhanVienDonVi": nhanVienDonVi.toString(),
          "maNV": maNVSmcs,
          "chucDanh": chucDanh
        }));
    if (response.statusCode == 200) {
      TapKHSuDungGoiHomeSanhChat_Variable.totalItem =
          json.decode(response.body)['totalItem'];
      TapKHSuDungGoiHomeSanhChat_Variable.totalPage =
          json.decode(response.body)['totalPage'];
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((data) => TapKhSuDungGoiHomeSanhChat.fromJson(data))
          .toList();
    } else if (response.reasonPhrase == 'Unauthorized') {
      responseStatus = "Unauthorized";
      throw Exception("Unauthorize");
    } else {
      throw Exception(
          "Lỗi khi tải danh sách tập khách hàng sử dụng gói home sành chất");
    }
  } catch (e) {
    if (responseStatus == "Unauthorized") {
      throw Exception("Unauthorized");
    } else {
      throw Exception(
          "Lỗi khi tải danh sách tập khách hàng sử dụng gói home sành chất");
    }
  }
}
