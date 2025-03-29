// ignore_for_file: file_names
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_Route.dart';
import 'dart:convert';

import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Modal.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Route.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/NhanVien_SoKM_Model.dart';





Future<String> saveData(String long, String lat) async {
  
  try {
    String url = Main_Homepage_Route.saveLocate;
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'latitude': lat,
          'longitude':long,
          'user_one': shared_preferences.getString('user_one')
        }));
    if (response.statusCode == 200) {

    }
    return response.statusCode.toString();
  } catch (e) {
    throw Exception('Lỗi khi đăng nhập vui lòng thử lại');
  }
}
Future<List<LocationData>> LoadDataHanhTrinh(String ngay_bd,String ngay_kt,String user_one) async {
  http.Response response;
  String url =  HanhTrinh_Route.get_ds_Vi_Tri;
  var responseStatus = '';
  try {
    
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
            'user_one':user_one,
            "ngay_bd":ngay_bd,
            "ngay_kt":ngay_kt
        }));
    if (response.statusCode == 200) {
    // Giải mã JSON
    final Map<String, dynamic> data = json.decode(response.body);

    // Chuyển chuỗi "d" thành List
    List<dynamic> decodedList = json.decode(data['d']);

    // Parse từng phần tử thành Object LocationData
    return decodedList.map((item) => LocationData.fromJson(item)).toList();
  } else {
    throw Exception("Failed to load data");
  }
  } catch (e) {
    if (responseStatus == 'Unauthorized') {
      throw Exception('Unauthorized');
    }
    // print(e);
    throw Exception('Không thể load');
  }
}

Future<List<NhanVien_SoKM_Model>> LoadDS_NV_SoKM(String ngay_bd,String ngay_kt) async {
  http.Response response;
  String url =  HanhTrinh_Route.get_ds_NV_SoKM;
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
    return decodedList.map((item) => NhanVien_SoKM_Model.fromJson(item)).toList();
    
  } else {
    throw Exception("Failed to load data");
  }
  } catch (e) {
    throw Exception('Không thể load');
  }
}




Future<List<NhanVien_SoKM_Model>> LoadDS_NV_Ngay_SoKM(String ngay_bd,String ngay_kt) async {
  http.Response response;
  String url =  HanhTrinh_Route.get_ds_NV_Ngay_SoKM;
  var responseStatus = '';
  try {
    
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
            "user_one":shared_preferences.getString('user_one'),
            "ngay_bd":ngay_bd,
            "ngay_kt":ngay_kt
        }));
    if (response.statusCode == 200) {
    // Giải mã JSON
    final Map<String, dynamic> data = json.decode(response.body);

    // Chuyển chuỗi "d" thành List
    List<dynamic> decodedList = json.decode(data['d']);

    // Parse từng phần tử thành Object LocationData
    return decodedList.map((item) => NhanVien_SoKM_Model.fromJson(item)).toList();
    
  } else {
    throw Exception("Failed to load data");
  }
  } catch (e) {
    throw Exception('Không thể load');
  }
}
Future<List<String>> load_ds_NV(String user_one) async {
  http.Response response;
  String url =  HanhTrinh_Route.get_ds_NV;
  var responseStatus = '';
  try {
    response = await http.post(Uri.parse(url),
        headers: requestHeader,
        body: json.encode(<String, dynamic>{
            'user_one':user_one
        })
        );
    if (response.statusCode == 200) {



    final Map<String, dynamic> data = json.decode(response.body);

      // Giải mã JSON

      // Giải mã chuỗi JSON bên trong "d"
      List<dynamic> jsonData = json.decode(data['d']);

      // Lấy danh sách các giá trị "user_one"
      List<String> decodedList = jsonData.map((e) => e['user_one'] as String).toList();

    // Parse từng phần tử thành Object LocationData
    return decodedList;
  } else {
    throw Exception("Failed to load data");
  }
  } catch (e) {
    if (responseStatus == 'Unauthorized') {
      throw Exception('Unauthorized');
    }
    // print(e);
    throw Exception('Không thể load hệ số sản lượng VT_CNTT');
  }
}