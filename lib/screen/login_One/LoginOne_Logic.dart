// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnptapp/Models/NhanVien.dart';
import 'package:vnptapp/Models/SubModel/subModel_DemDangNhap.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/login_One/LoginOne_Route.dart';
import 'dart:convert';

import 'package:vnptapp/screen/login_One/Role_Model.dart';

// Future<int> login(String taikhoan, String matkhau) async {
//   try {
//     http.Response response = await http.post(Uri.parse(LoginScreen_Route.login),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(
//             <String, String>{'tenDangNhap': taikhoan, 'matKhau': matkhau}));
//     if (response.statusCode == 200) {
//       Map<String, dynamic> userMap = json.decode(response.body.toString());
//       localUser = User(
//         Id: userMap['id'],
//         TenDangNhap: userMap['tenDangNhap'],
//         MatKhau: userMap['matKhau'],
//         Ten: userMap['ten'],
//         Long: userMap['long'],
//         Lat: userMap['lat'],
//         DiaDiem: userMap['diaDiem'],
//         SoDienThoai: userMap['soDienThoai'],
//         Gmail: userMap['gmail'],
//       );
//       return response.statusCode;
//     } else {
//       return response.statusCode;
//     }
//   } catch (e) {
//     return -1;
//   }
// }
Future<String> rememberLogin(
  String taikhoan,
  String matkhau,
  String subUrlApi,
) async {
  try {
    String url = subUrlApi + LoginOne_Route.rememberLogin;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tenDangNhap': taikhoan,
        'matKhau': matkhau,
      }),
    );
    // if(response.statusCode == 200){
    //   return json.decode(response.body);
    // }else{
    //   return ""
    // }
    return response.body;
  } catch (e) {
    return "Lỗi khi đăng nhập";
  }
}

Future<String> loginWithODP(
  String taikhoan,
  String matkhau,
  String subUrlApi,
) async {
  try {
    // print(ApiEndPoint.baseUrl );
    String url = subUrlApi + LoginOne_Route.login;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tenDangNhap': taikhoan,
        'matKhau': matkhau,
      }),
    );
    if (json.decode(response.body)['message'] == 'Success') {
      jwt = json.decode(response.body)['token'];
      //print(jwt);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set jwt
      prefs.setString('jwt', jwt);
      //set odp
      prefs.setString('odp', json.decode(response.body)['odp']);
      //print(prefs.getString('odp'));
      jwtToNhanVien();
      //print(tenDonVi);
    }
    return json.decode(response.body)['message'];
  } catch (e) {
    throw Exception('Lỗi khi đăng nhập vui lòng thử lại');
  }
}

Future<String> getODPWithTaiKhoanNV(
  String taiKhoanNhanVien,
  String subUrlApi,
) async {
  try {
    String url =
        '$subUrlApi${LoginOne_Route.getODP}?taiKhoanNhanVien=$taiKhoanNhanVien';
    http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response.body;
  } catch (e) {
    throw Exception('Lỗi khi lấy ODP vui lòng thử lại');
  }
}

Future<String> forgetPasswordWithTaiKhoanNv(
  String taiKhoanNhanVien,
  String subUrlApi,
) async {
  try {
    String url =
        '$subUrlApi${LoginOne_Route.forgetPassWord}?taiKhoanNhanVien=$taiKhoanNhanVien';
    http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );
    return response.body;
  } catch (e) {
    throw Exception('Lỗi khi lấy mật khẩu vui lòng thử lại');
  }
}

Future<String> loginCounter(int nhanvienId, String subUrlApi) async {
  try {
    String url =
        '$subUrlApi${LoginOne_Route.loginCounter}?nhanvienId=$nhanvienId';
    http.Response response = await http.put(
      Uri.parse(url),
      headers: requestHeader,
    );
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return 'Fail';
    }
  } catch (e) {
    return 'Fail';
  }
}

Future<String> loginKiemTraInfor(
  int nhanvienId,
  subModel_DemDangNhap subddn,
  String subUrlApi,
) async {
  try {
    String url =
        '$subUrlApi${LoginOne_Route.kiemTraIdThietBiVaPhienBan}?nhanvien_id=$nhanvienId';
    http.Response response = await http.put(
      Uri.parse(url),
      headers: requestHeader,
      body: json.encode(<String, dynamic>{
        "idThietBi": subddn.idThietBi,
        "appPhienBan": subddn.appPhienBan,
        "tenThietBi": subddn.tenThietBi,
        "tenHangThietBi": subddn.tenHangThietBi,
        "heDieuHanh": subddn.heDieuHanh,
        "phienBanHeDieuHanh": subddn.phienBanHeDieuHanh,
      }),
    );
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.body;
    }
  } catch (e) {
    return 'Fail';
  }
}

Future<String> login_oneBSS(String taikhoan, String matkhau) async {
  try {
    // print(ApiEndPoint.baseUrl);
    String url = LoginOne_Route.login_One;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': taikhoan,
        'password': matkhau,
      }),
    );
    Map<String, dynamic> result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Parse JSON
      // Lấy giá trị "secretCode"
      //get role đưa vào share_preferences  
      try {
          // print(ApiEndPoint.baseUrl );
          String url = LoginOne_Route.getRole;
          http.Response response = await http.post(
            Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{'user_one': taikhoan}),
          );
          Map<String, dynamic> result = jsonDecode(response.body);
          if (response.statusCode == 200) {
          // Giải mã JSON


            final Map<String, dynamic> jsonData = jsonDecode(response.body);

            // Bước 2: Giải mã chuỗi JSON trong key "d"
            final List<dynamic> dataList = jsonDecode(jsonData['d']);

            // Bước 3: Trích xuất giá trị "role"
            if (dataList.isNotEmpty) {
              String role = dataList[0]['role'];  // Lấy giá trị "role" của phần tử đầu tiên
              print("Role: $role");
              shared_preferences.setString('role',role);
            }else{
              shared_preferences.setString('role','User');
            }
        }
      } catch (e) {
        shared_preferences.setString('role','User');
        throw Exception('Lỗi khi đăng nhập vui lòng thử lại');
      }

      String secretCode = result["data"]["secretCode"];

      shared_preferences.setString('secretCode', secretCode);

      shared_preferences.setString('user_one', taikhoan);
      shared_preferences.setString('thoigian_login', DateTime.now().toString());
      print(shared_preferences.getString('user_one'));
      print(shared_preferences.getString('thoigian_login'));
    }
    return response.statusCode.toString();
  } catch (e) {
    throw Exception('Lỗi khi đăng nhập vui lòng thử lại');
  }
}

// Future identity(int id) async {
//   try {
//     http.Response response = await http.get(
//         Uri.parse('${AppUsers.getUserByID}${id}'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         });
//     if (response.statusCode == 200) {
//       // no content
//       //var data = jsonDecode(response.body.toString());
//       Map<String, dynamic> userMap = json.decode(response.body.toString());
//       localUser = User(
//         Id: userMap['id'],
//         TenDangNhap: userMap['tenDangNhap'],
//         MatKhau: userMap['matKhau'],
//         Ten: userMap['ten'],
//         Long: userMap['long'],
//         Lat: userMap['lat'],
//         DiaDiem: userMap['diaDiem'],
//       );
//     } else {
//       print('failed');
//       //hiện thông báo
//     }
//     //return User();
//     //return User();
//   } catch (e) {
//     print(e);
//     //return User();
//     //return User();
//   }
// }
// Future<void> loginWithTimeout(String taiKhoan, String matKhau) async {
//   try {
//     await Future.delayed(Duration(seconds: 5), () {
//       login(taiKhoan, matKhau);
//     }).timeout(Duration(seconds: 5));
//   } catch (error) {
//     print('Lỗi: $error');
//   }
// }
// Future<void> loginErrorHandle(BuildContext context) async {
//   if (localCodeRequest.localCode == 404) {
//     ShowDialog('Lỗi', 'Không tìm thấy tài khoản', context);
//   } else if (localCodeRequest.localCode == 503) {
//     ShowDialog('Lỗi', 'Lỗi kết nối mạng(503)', context);
//   } else if (localCodeRequest.localCode == 0) {
//     ShowDialog('Lỗi', 'Lỗi kết nối mạng', context);
//   } else if (localCodeRequest.localCode == 400) {
//     ShowDialog('Lỗi', 'Sai thông tin đăng nhập', context);
//   } else {
//     ShowDialog('Lỗi', 'Kiểm tra lại internet và thông tin đăng nhập', context);
//   }
// }
// Future<bool> isLoginSucess() async {
//   if (localCodeRequest.localCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }
jwtToNhanVien() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> decodedToken = JwtDecoder.decode(
    prefs.getString('jwt')!,
  );
  localNhanVien.nhanvien_taikhoan = decodedToken['manhanvien'];
  localNhanVien.nhanvien_manv = decodedToken['manhanvien'];
  localNhanVien.nhanvien_id = int.tryParse(decodedToken['id']);
  localNhanVien.nhanvien_hoten = decodedToken['hoten'];
  localNhanVien.nhanvien_didong = decodedToken['sdt'];
  localNhanVien.nhanvien_donvi = int.tryParse(decodedToken['donvi_id']);
  localNhanVien.diachi = decodedToken['diachi'];
  localNhanVien.nhanvien_manv_thns = decodedToken['ma_NhanVien_THNS'];
  localNhanVien.nhanvien_chucdanh = int.tryParse(decodedToken['chucdanh']);
  localNhanVien.nhanvien_id = int.tryParse(decodedToken['nhanvien_id']);
  localNhanVien.nhanvien_smcs = decodedToken['nhanvien_smcs'];
  nhanvien_TenDonVi = decodedToken['tenDonVi'];
  nhanvien_TenDonVi2 = decodedToken['tendonvi2'];
  nhanvien_DonVi_MoTa = decodedToken['donvi_mota'];
  nhanvien_donvi_Pttb = decodedToken['madonvi_pttb'];
  nhanvien_khuvuc_id = decodedToken['khuvuc_c4_id'];
  // print(tenDonVi);
}
