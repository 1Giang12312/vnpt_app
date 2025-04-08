// ignore_for_file: file_names, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/Components/Custom_ShowDialog.dart';
import 'package:vnptapp/Components/Custom_Text.dart';
import 'package:vnptapp/GlobalFunction/InternetChecker.dart';
import 'package:vnptapp/Models/NhanVien.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Drawer/Drawer_Logic.dart';
import 'package:vnptapp/screen/Drawer/profile/ProfileScreen_MainPage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Admin_MainPage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_User_MainPage.dart';
import 'package:vnptapp/screen/login/LoginScreen_MainPage.dart';
import 'package:vnptapp/screen/login_One/LoginOne_MainPage.dart';

// ignore: camel_case_types
class Drawer_One_MainPage extends StatefulWidget {
  const Drawer_One_MainPage({super.key});
  @override
  State<Drawer_One_MainPage> createState() => _Drawer_One_MainPageState();
}

bool loadingWebBsc = false;

// ignore: camel_case_types
class _Drawer_One_MainPageState extends State<Drawer_One_MainPage> {
  resetUser() async {
    shared_preferences.remove('user_one');
    shared_preferences.remove('thoigian_login');
  }

  // void loginFunction() async {
  //   try {
  //     User user = await getUIByID(localUser.Id.toString())
  //         .timeout(Duration(seconds: waitOfTimeOut()));
  //     setState(() {
  //       isLoading = false;
  //     });
  //     if (user != User()) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //             builder: (context) => ProfileScreen(
  //                   user: user,
  //                 )),
  //       );
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       ShowDialog('Lỗi', 'Không có kết nối!', context);
  //     }
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     ShowDialog('Lỗi', 'Không có kết nối!', context);
  //   }
  // }
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthOfDevice(context) / 1.5,
      child: Drawer(
        backgroundColor:
            isDarkMode
                ? const Color(0xFF1C1B1F)
                : const Color.fromARGB(255, 212, 232, 249),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height:
                  isLandScape(context)
                      ? heightOfDevice(context) / 5
                      : heightOfDevice(context) / 6,
            ),
            ListTile(
              title: Text_medium_dark(title: 'Theo dõi hành trình'),
              onTap: () async {
                if (shared_preferences.getString('role') == 'Admin') {
                  print('admin');
                  pageTransitionRemoveAll(context, HanhTrinh_Admin_MainPage());
                } else {
                  print('user');
                  pageTransitionRemoveAll(context, HanhTrinh_User_MainPage());
                }
              },
            ),

            ListTile(
              title: Text_medium_dark(title: 'App BSC'),
              onTap: () async {
                pageTransitionRemoveAll(
                  context,
                  LoginScreen_MainPage(thongBao: ''),
                );
              },
            ),
            ListTile(
              title: Text_medium_dark(title: 'Đăng xuất'),
              onTap: () async {
                resetUser();
                pageTransitionRemoveAll(
                  context,
                  LoginOne_MainPage(thongBao: ''),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
