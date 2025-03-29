// ignore_for_file: file_names, camel_case_types
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vnptapp/Components/Custom_CopyRight_Bottom.dart';
import 'package:vnptapp/Components/Custom_AnimatedFAB.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/Components/Custom_Text.dart';
import 'package:vnptapp/screen/Drawer/Drawer_MainPage.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_Logic.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Admin_MainPage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_User_MainPage.dart';
import 'package:vnptapp/screen/homepage/HomePage_Route.dart';
import 'package:vnptapp/screen/login/LoginScreen_MainPage.dart';
import 'package:vnptapp/screen/login_One/LoginOne_MainPage.dart';
import '../../Variable/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnptapp/Variable/Constant.dart';

// // // ignore: camel_case_types

// class Main_Homepage_MainPage extends ConsumerWidget {
//   const Main_Homepage_MainPage({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     isDarkMode = ref.watch(appThemeProvider);
//     return ScaffoldDraggable(
//       button: TextButton(
//         child: const Text('asdf'),
//         onPressed: () {},
//       ),
//       child: DefaultTabController(
//         length: 6,
//         child: Scaffold(
//           body: Stack(
//             children: [
//               Container(
//                 width: widthOfDevice(context),
//                 height: heightOfDevice(context),
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/homepage.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                       },
//                       child: const Text("Chuyển đến Trang 1"),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                       },
//                       child: const Text("Chuyển đến Trang 2"),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           drawer: const Drawer_HomePage(),
//         ),
//       ),
//     );
//   }
// }

class Main_Homepage_MainPage extends StatefulWidget {
  const Main_Homepage_MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Main_Homepage_MainPageState createState() => _Main_Homepage_MainPageState();
}

class _Main_Homepage_MainPageState extends State<Main_Homepage_MainPage> {
  late String user_one;
  // Khởi tạo và quản lý dịch vụ nền
  // Future<void> initializeService() async {
  //   final service = FlutterBackgroundService();
  //   // Kiểm tra xem dịch vụ đã chạy chưa
  //   bool isRunning = await service.isRunning();
  //   if (isRunning) {
  //     print("Dịch vụ đã chạy trước đó, dừng dịch vụ cũ...");
  //     service.invoke("stopService"); // Dừng dịch vụ cũ
  //     await Future.delayed(const Duration(seconds: 1)); // Đợi 1 giây để đảm bảo dừng hoàn toàn
  //   }
  //   // Cấu hình dịch vụ
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       onStart: onStart,
  //       autoStart: true,
  //       isForegroundMode: true,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       autoStart: true,
  //       onForeground: onStart,
  //       onBackground: onIosBackground,
  //     ),
  //   );
  //   // Khởi động dịch vụ
  //   print("Khởi động dịch vụ mới...");
  //   service.startService();
  // }

  resetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_one');
    prefs.remove('thoigian_login');
  }

  // Yêu cầu quyền vị trí (gọi trong foreground)
  Future<void> requestLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Dịch vụ vị trí bị tắt, mở cài đặt...");
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print("Quyền vị trí bị từ chối");
        return;
      }
    }

    if (Platform.isAndroid && permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        print(
          "Vui lòng chọn 'Allow all the time' trong cài đặt để chạy trong nền.",
        );
        await Geolocator.openAppSettings();
        return;
      }
    }

    print("Quyền vị trí đã được cấp đầy đủ");
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    user_one = shared_preferences.getString('user_one');

    requestLocationPermissions();
    // initializeService();
    startListenLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Xin chào, $user_one')),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: widthOfDevice(context),
              height: heightOfDevice(context),
              decoration: const BoxDecoration(
                color: Color.fromARGB(97, 93, 117, 133),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (shared_preferences.getString('role') == 'Admin') {
                        print('admin');
                        pageTransitionRemoveAll(
                          context,
                          HanhTrinh_Admin_MainPage(),
                        );
                      } else {
                        print('user');
                        pageTransitionRemoveAll(
                          context,
                          HanhTrinh_User_MainPage(),
                        );
                      }
                    },
                    child: const Text("Theo dõi hành trình"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      pageTransitionRemoveAll(
                        context,
                        LoginScreen_MainPage(thongBao: ''),
                      );
                    },
                    child: const Text("App BSC"),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      resetUser();
                      pageTransitionRemoveAll(
                        context,
                        LoginOne_MainPage(thongBao: ''),
                      );
                    },
                    child: const Text("Đăng xuất"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hàm chạy khi dịch vụ bắt đầu (background)
void startListenLocation() async {
  print("Dịch vụ nền đã khởi động trong onStart");

  // if (service is AndroidServiceInstance) {
  //   service.setAsForegroundService();
  //   service.setForegroundNotificationInfo(
  //     title: "Dịch vụ lấy vị trí",
  //     content: "Đang chạy trong nền để lấy vị trí",
  //   );
  // }

  // Kiểm tra dịch vụ vị trí
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("Dịch vụ vị trí bị tắt");
    return;
  }

  // Kiểm tra quyền
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    print("Quyền vị trí bị từ chối vĩnh viễn");
    return;
  }
  if (permission != LocationPermission.always) {
    print(
      "Chưa có quyền 'Allow all the time'. Vui lòng cấp quyền trong cài đặt.",
    );
    return;
  }

  print("Bắt đầu lấy vị trí mỗi 5 giây...");
  // Lấy vị trí mỗi 5 giây
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.best,
          forceLocationManager: true, // Ép dùng Android Location Manager
        ),
      );
      print("Lat: ${position.latitude}, Long: ${position.longitude}");
      String login = await saveData(
        position.longitude.toString(),
        position.latitude.toString(),
      );
    } catch (e) {
      print("Lỗi khi lấy vị trí: $e");
    }
  });
}

// Xử lý background trên iOS
// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   print("Dịch vụ chạy trong background trên iOS");
//   return true;
// }
