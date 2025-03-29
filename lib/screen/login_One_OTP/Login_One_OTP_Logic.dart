// // ignore_for_file: file_names

// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vnptapp/GlobalFunction/InternetChecker.dart';
import 'package:vnptapp/Models/SubModel/subModel_DemDangNhap.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/ODPScreen/ODPScreen_Route.dart';
import 'package:vnptapp/screen/login/LoginScreen_Logic.dart';
import 'package:vnptapp/screen/login/LoginScreen_Route.dart';
import 'package:vnptapp/screen/login_One_OTP/Login_One_OTP_Route.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Future sendAndSaveOTP(String phoneNumber) async {
//   String substring = phoneNumber.substring(1);
//   try {
//     // ignore: unused_local_variable
//     http.Response response = await http.post(
//         Uri.parse('${OTPScreen_Route.sendAndSaveOTP}?phoneNumber=%2B$substring'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         );
//   } catch (e) {
//     throw Exception(e);
//   }
// }
// // ignore: non_constant_identifier_names
// Future<int> AuthOTP(String phoneNumber,String otpCode) async {
//   try {
//     http.Response response = await http.post(
//         Uri.parse(OTPScreen_Route.authOTP),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(<String, String>{
//           'otpCode': otpCode,
//           'phoneNumber':  phoneNumber
//         }));
//    return response.statusCode;
//   } catch (e) {
//     return -1;
//   }
// }

//login nếu không thành công thì cho nhập odp

Future<String> OTPLogin(String otp) async {
  try {
    // print(ApiEndPoint.baseUrl );
    String url = Login_One_OTP_Route.otp_API;
     http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
       'Accept': '*/*',
            'Accept-Language': 'vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5',
            'Connection': 'keep-alive',
            'Content-Type': 'application/json',
            'Cookie': r'_hjSessionUser_1160287=eyJpZCI6IjJiZjg5NjQ5LTRkZTYtNTc1My05OWViLTI0MjNmZTM1MTJkYiIsImNyZWF0ZWQiOjE2OTk5NTA1OTY3MjIsImV4aXN0aW5nIjp0cnVlfQ==; _fbp=fb.1.1699950596731.46747267; _tt_enable_cookie=1; _ga_0NK7BQ2F5C=GS1.2.1706519269.2.0.1706519269.0.0.0; _ga_YB3ZBPNTX2=GS1.2.1707124014.1.0.1707124014.0.0.0; _ga_F9HL65897E=GS1.1.1710759940.27.0.1710759940.0.0.0; _ga_E81TGK6000=GS1.1.1710759940.27.0.1710759940.0.0.0; _ga_TFG0BKYWYY=GS1.1.1710759940.27.0.1710759940.60.0.0; _ga_PN88XMGHZE=GS1.1.1710759940.27.0.1710759940.60.0.0; _ga_PV5SH6TZGK=GS1.1.1715993983.10.0.1715993986.57.0.0; _ga_1QG2JMFPQ6=GS1.1.1715993983.10.0.1715993986.0.0.0; _ga_TLS0XWV0R1=GS1.1.1715993983.10.0.1715993986.0.0.0; _ga_V7F4HJVJMP=GS1.1.1715993983.10.0.1715993986.57.0.0; _ga_BK4XYPZ095=GS1.1.1725929022.7.0.1725929029.0.0.0; _ga_35Q5E2T2NT=GS1.1.1729764683.1.0.1729764731.0.0.0; _ga_EZ5F1ZPH8T=GS1.1.1729764683.1.0.1729764731.0.0.0; CJM_G=1f8e4e84c54c3a70386d63317e29f9ea; _ttp=k2iGj8nR6JGNgr1CKbRC8TAUCfu.tt.1; _gcl_aw=GCL.1732869425.CjwKCAiA6aW6BhBqEiwA6KzDc4vuznQb8-DLCPxnfZAQykkYBiYtJOFxs7Osj5hnhXHEB9tlWsRy5RoCNwMQAvD_BwE; _gcl_gs=2.1.k1$i1732869422$u78196097; _ga_0C701HT196=GS1.2.1733735164.63.0.1733735164.0.0.0; __zi=3000.SSZzejyD3j0xdgMwmLiCX2NGgwA21nwEEiBfi9GKNvLzZ-Ymtr5Tcds0w_hOKLVVUOVcyzHPLzeo.1; _ga_QJJ84EXDSN=GS1.1.1735545741.9.1.1735545858.0.0.0; _ga_6T70PSBJEM=GS1.1.1735545741.9.1.1735545858.0.0.0; _ga=GA1.1.108507494.1699950597; _ga_672YZVPPG6=GS1.1.1735545861.3.1.1735546160.60.0.0; _gcl_au=1.1.871273225.1737073581; _ga_BFVVXDGX3E=GS1.1.1737419666.84.1.1737419736.0.0.0; JSESSIONID=7A7746D13DA2CAB488DCA1B559730A3D',
            'Mac-address': 'WEB',
            'Origin': 'https://onebss.vnpt.vn',
            'Referer': 'https://onebss.vnpt.vn/',
            'Sec-Fetch-Dest': 'empty',
            'Sec-Fetch-Mode': 'cors',
            'Sec-Fetch-Site': 'same-site',
            'Token-id': '97388db0-6ce9-11ea-bc55-0242ac130003',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
            'sec-ch-ua': '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
            'sec-ch-ua-mobile': '?0',
            'sec-ch-ua-platform': '"Windows"'
        },
        body: jsonEncode(<String, String>{
            'grant_type': 'password',
            'client_id': 'clientapp',
            'client_secret': 'password',
            'otp': otp,
            'secretCode': shared_preferences.getString('secretCode').toString(),
        }));
        print(shared_preferences.getString('secretCode'));
    Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String access_token = result['access_token'];

      // jwt = json.decode(response.body)['token'];
       Map<String, dynamic> decodedToken = JwtDecoder.decode(access_token);

      shared_preferences.setString('user_one', decodedToken['ma_nhanvien_ccbs']);
      shared_preferences.setString('thoigian_login', DateTime.now());
      print(shared_preferences.getString('user_one'));
      print(shared_preferences.getString('thoigian_login'));

      //lưu user và thời gian đăng nhập, nếu thời gian hiện tại - thời gian đăng nhập < 24h thì nhảy thẳng vô màn hình chính
    }
    return response.statusCode.toString();
  } catch (e) {
    throw Exception('Lỗi khi đăng nhập vui lòng thử lại');
  }
}