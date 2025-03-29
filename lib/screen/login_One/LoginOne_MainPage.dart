// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vnptapp/Components/Custom_CopyRight_Bottom.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/Components/Custom_SizedBox.dart';
import 'package:vnptapp/Components/Custom_Text.dart';
import 'package:vnptapp/Components/Custom_ShowDialog.dart';
import 'package:vnptapp/Components/LoadingScreen.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_MainPage.dart';
import 'package:vnptapp/screen/homepage/HomePage_MainPage.dart';
import 'package:vnptapp/screen/login_One/LoginOne_Logic.dart';
import 'package:vnptapp/screen/login_One_OTP/Login_One_OTP_MainPage.dart';
import 'package:vnptapp/Components/Custom_LoadingButton.dart';

// ignore: must_be_immutable, camel_case_types
class LoginOne_MainPage extends StatefulWidget {
  LoginOne_MainPage({super.key, required this.thongBao
      //  , required this.prefs
      });
  String thongBao;
  // SharedPreferences prefs;
  @override
  State<LoginOne_MainPage> createState() => _LoginOne_MainPageState();
}

// ignore: camel_case_types
class _LoginOne_MainPageState extends State<LoginOne_MainPage> {
  TextEditingController taiKhoanController = TextEditingController();
  TextEditingController matKhauController = TextEditingController();
  login_function() async {
    if (mounted) {
      // String url = await checkLocalConnectionApi();
      if (taiKhoanController.text == '' || taiKhoanController.text.isEmpty) {
        ShowDialog('Lỗi', 'Hãy nhập thông tin tài khoản!', context);
      } else if (matKhauController.text == '' ||
          matKhauController.text.isEmpty) {
        ShowDialog('Lỗi', 'Hãy nhập thông tin mật khẩu!', context);
      } else {
        try {
          String login =
              await Future.delayed(const Duration(seconds: 2), () async {
            return await login_oneBSS(
                taiKhoanController.text, matKhauController.text);
          });
          if (login == '200') {
                // pageTransitionRemoveAll(context, Login_One_OTP_MainPage());
                pageTransitionRemoveAll(context, Main_Homepage_MainPage());

          } else {
            ShowDialog('Lỗi', 'Vui lòng kiểm tra lại tài khoản, mật khẩu và thử lại trong ít phút!', context);
          }
        } catch (e) {
          ShowDialog('Lỗi', 'Không có kết nối!', context);
        }
      }
    }
  }
  login_auto() async{
    if(mounted){
      Future.delayed(Duration.zero, () {
    setState(() {
        pageTransitionRemoveAll(context, Main_Homepage_MainPage());

    });
  });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {  
      _obscureText = !_obscureText;
    });
  });
  }

  @override
  void initState() {
        if(shared_preferences.getString('user_one') != null && shared_preferences.getString('thoigian_login') != null){
 print(shared_preferences.getString('user_one'));
        var timeStr = shared_preferences.getString('thoigian_login');
        DateTime dt = DateTime.parse(timeStr).toLocal();
        DateTime dtPlus24h = dt.add(Duration(hours: 24));
         DateTime now = DateTime.now();
        if (dtPlus24h.isAfter(now) &&
        shared_preferences.getString('user_one') != null
        ) {
          print(shared_preferences.getString('thoigian_login'));
          login_auto();
    }
        }
       
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.prefs.getString('matkhau') != null &&
    //     widget.prefs.getString('taikhoan') != null) {
    if (shared_preferences.getString('matkhau') != null &&
        shared_preferences.getString('taikhoan') != null) {
      return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/vnptangiang.jpg',
            width: widthOfDevice(context) / 2,
            height: heightOfDevice(context) / 3,
          ),
          LoadingScreen(nameOfLoadingScreen: 'Đang đăng nhập'),
        ],
      ));
    }
   return Scaffold(
        // appBar: AppBar(
        //     backgroundColor: primaryColors,
        //     title: Text_huge_light(title: 'HỆ THỐNG BSC/KPI')),
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          SizedBox(
            // width: widthOfDevice(context),
            // height: isLandScape(context)
            //     ? heightOfDevice(context) < 290
            //         ? heightOfDevice(context) * 1.5
            //         : heightOfDevice(context)
            //     : widget.thongBao == ''
            //         ? heightOfDevice(context) - heightOfAppBar(context)
            //         : heightOfDevice(context),
            height: heightOfDevice(context),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  isLandScape(context)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/VNPT-Logo-PNG-3.png',
                              width: widthOfDevice(context) / 6,
                              height: heightOfDevice(context) / 6,
                            ),
                            // Image.asset(
                            //   'assets/loginlogo.jpg',
                            //   width: 50,
                            //   height: heightOfDevice(context) / 10,
                            // ),
                          ],
                        )
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  height: heightOfDevice(context) / 10,
                                  width: widthOfDevice(context),
                                  color: isDarkMode
                                      ? secondDaryColors
                                      : primaryColors,
                                  child:
                                      //  Row(
                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                      //   children: [
                                      //     Text_large_light(
                                      //       title: "HỆ THỐNG BSC/KPI",
                                      //     ),
                                      //   ],
                                      // )
                                      Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text_large_dark(
                                        title: "Đăng nhập",
                                      ),
                                    ],
                                  )),
                            ),
                            // isSmallHeight() == true
                            //     ? Image.asset(
                            //         'assets/vnptangiang.jpg',
                            //         width: 100,
                            //         height: 100,
                            //       )
                            //     :
                            Image.asset(
                              'assets/vnptangiang.jpg',
                              width: widthOfDevice(context) / 4,
                              height: heightOfDevice(context) / 6,
                            ),
                            // isSmallHeight() == true
                            //     ? Image.asset(
                            //         'assets/loginlogo.jpg',
                            //         width: 50,
                            //         height: 50,
                            //       )
                            //     :
                            // Image.asset(
                            //   'assets/loginlogo.jpg',
                            //   width: widthOfDevice(context) / 6,
                            //   height: heightOfDevice(context) / 10,
                            // ),
                          ],
                        ),
                  widget.thongBao != ''
                      ? Text_medium_dark(title: 'Thông báo: ${widget.thongBao}')
                      : const Text(''),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: widthOfDevice(context) / 1.1,
                    height: heightOfDevice(context) / 12,
                    child: TextFormField(
                      controller: taiKhoanController,
                      decoration: const InputDecoration(
                        labelText: "Tài khoản",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Tài khoản không được để trống";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SmallHeightSizedBox(),
                  SizedBox(
                    width: widthOfDevice(context) / 1.1,
                    height: heightOfDevice(context) / 12,
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: matKhauController,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mật khẩu không được để trống";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Custom_LoadingButtonLight(
                        nameOfLoadingButton: 'Đăng nhập',
                        func: login_function,
                      )
                    ],
                  ),
                  const SmallHeightSizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
 
  }
}
