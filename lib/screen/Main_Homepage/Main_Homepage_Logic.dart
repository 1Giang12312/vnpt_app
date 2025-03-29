// ignore_for_file: file_names
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_Route.dart';
import 'dart:convert';

Future<String> saveData(String long, String lat) async {
  try {
    // print(ApiEndPoint.baseUrl );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = Main_Homepage_Route.saveLocate;
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'latitude': lat,
          'longitude':long,
          'user_one': prefs.getString('user_one').toString()
        }));
    if (response.statusCode == 200) {

    }
    return response.statusCode.toString();
  } catch (e) {
    throw Exception('Lỗi khi đăng nhập vui lòng thử lại');
  }
}

