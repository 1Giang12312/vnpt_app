
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Screen_One/ViTriCuoiCungTrenBanDo/ViTri_CuoiCung_Modal.dart';
import 'package:vnptapp/screen/Screen_One/ViTriCuoiCungTrenBanDo/ViTri_CuoiCung_Route.dart';

Future<List<Modal_NV>> LoadDSTenNV(String ngay_bd,String ngay_kt) async {
  http.Response response;
  String url =  ViTri_CuoiCung_Rote.getTenNV;
  var responseStatus = '';
  try {
    
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
            "ngay_bd":ngay_bd,
            "ngay_kt":ngay_kt
        }));
    if (response.statusCode == 200) {
    // Giải mã JSON
    final Map<String, dynamic> data = json.decode(response.body);

    // Chuyển chuỗi "d" thành List
    List<dynamic> decodedList = json.decode(data['d']);

    // Parse từng phần tử thành Object LocationData
    return decodedList.map((item) => Modal_NV.fromJson(item)).toList();
    
  } else {
    throw Exception("Failed to load data");
  }
  } catch (e) {
    throw Exception('Không thể load');
  }
}