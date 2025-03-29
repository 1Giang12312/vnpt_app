// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vnptapp/Models/ThuLaoPhatTrienChamSocDUQ.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Drawer/QuanLySanLuong/ThuLaoPhatTrienChamSocDUQ/Route.dart';
import 'package:vnptapp/screen/Drawer/QuanLySanLuong/ThuLaoPhatTrienChamSocDUQ/Variable.dart';

Future<List<ThuLaoPhatTrienChamSocDuq>> listThuLao(
    int pageNumber,
    int pageSize,
    String timeKey,
    var searchKey,
    var tenDonVi,
    String tendonviNhanvien,
    String maNhanVien,
    String chucDanh,
    String subUrlApi) async {
  var responseStatus = '';
  http.Response response;

  String url =
      subUrlApi + ThuLaoPhatTrienChamSocDUQ_Route.getListThuLaoPhatTrien;
  try {
    url = '$url?timeKey=$timeKey&searchKey=$searchKey';
    // print(url);
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
          "pageNumber": pageNumber,
          "pageSize": pageSize,
          "tenDonVi": tenDonVi,
          "nhanVienDonVi": tendonviNhanvien,
          "maNV": maNhanVien,
          "chucDanh": chucDanh
        }));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      ThuLaoPhatTrienChamSocDUQ_Variable.totalPage =
          json.decode(response.body)['totalPage'];
      ThuLaoPhatTrienChamSocDUQ_Variable.totalItem =
          json.decode(response.body)['totalItem'];
      return jsonResponse
          .map((data) => ThuLaoPhatTrienChamSocDuq.fromJson(data))
          .toList();
    } else if (response.reasonPhrase == "Unauthorized") {
      responseStatus = 'Unauthorized';
      throw Exception('Unauthorize');
    } else {
      throw Exception('Không thể load hệ số sản lượng VT_CNTT');
    }
  } catch (e) {
    if (responseStatus == 'Unauthorized') {
      throw Exception('Unauthorized');
    }
    // print(e);
    throw Exception('Không thể load hệ số sản lượng VT_CNTT');
  }
}
