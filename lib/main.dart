// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/Variable/Riverpod_Instance.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:vnptapp/screen/homepage/HomePage_MainPage.dart';
import 'package:vnptapp/screen/login/LoginScreen_MainPage.dart';
import 'package:vnptapp/screen/login_One/LoginOne_MainPage.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vnptapp/screen/login_One_OTP/Login_One_OTP_MainPage.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();


  SharedPreferences prefs = await SharedPreferences.getInstance();
  shared_preferences = prefs;
  prefs.setString('jwt',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJraHV2dWNfYzRfaWQiOiItMSIsIm5oYW52aWVuX3NtY3MiOiJ0YW1sbS5hZ2ciLCJkb252aV9tb3RhIjoiUEJIIEFuIFBow7oiLCJ0ZW5kb252aTIiOiJQaMOybmcgQkhLViBBbiBQaMO6IiwidGVuRG9uVmkiOiJQaMOybmcgQsOhbiBow6BuZyBBbiBQaMO6IiwibmhhbnZpZW5faWQiOiI0MTciLCJjaHVjZGFuaCI6IjQ2IiwibWFuaGFudmllbiI6InRhbWxtLmFnZyIsImlkIjoiNDE3IiwiaG90ZW4iOiJMw6ogTWluaCBUw6JtIiwic2R0IjoiMDkxOTM5NTAwMCIsImRvbnZpX2lkIjoiOSIsImRpYWNoaSI6IuG6pXAgVOG6r2MgVHLDumMsIE5oxqFuIEjhu5lpLCBBbiBQaMO6LCBBbiBHaWFuZyIsIm1hX05oYW5WaWVuX1RITlMiOiJWTlAwMDYwODEiLCJtYWRvbnZpX3B0dGIiOiI0MDM0MiIsImRvbnZpX21hIjoiQVBVIiwiZXhwIjoxNzA2MzMxODU5LCJpc3MiOiJWTlBULUJTQ0FQUCIsImF1ZCI6IkJTQ0FQUCJ9.mHdqfIvLV8Va66EjUyZL6x3Dm5e08MiDUipnFqA-Cf0');
  // prefs.setString('jwt','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuaGFudmllbl9zbWNzIjoiZ2lhbmd2dC5hZ2ciLCJkb252aV9tb3RhIjoiUGjDsm5nIMSQSE5WIiwidGVuZG9udmkyIjoibnVsbCIsInRlbkRvblZpIjoiUGjDsm5nIMSQaeG7gXUgaMOgbmggLSBOZ2hp4buHcCB24bulIiwibmhhbnZpZW5faWQiOiI4ODQiLCJjaHVjZGFuaCI6IjEwIiwibWFuaGFudmllbiI6ImdpYW5ndnQuYWdnIiwiaWQiOiI4ODQiLCJob3RlbiI6IlbGsMahbmcgVHLGsOG7nW5nIEdpYW5nIiwic2R0IjoiMDgzNjI4MzE2OCIsImRvbnZpX2lkIjoiMTMiLCJkaWFjaGkiOiI2OC81RSDEkMO0bmcgVGjhu4tuaCAyLCBN4bu5IFBoxrDhu5tjLCBMb25nIFh1ecOqbiwgdOG7iW5oIEFuIEdpYW5nIiwibWFfTmhhblZpZW5fVEhOUyI6IkNUVjA4Mzk0OSIsImV4cCI6MTcwMTY5Mjc4NywiaXNzIjoiVk5QVC1CU0NBUFAiLCJhdWQiOiJCU0NBUFAifQ.2Cdk9uukRckCzR_Vp2JDLoCwhSIJn7tHtFyylMnnGyo');
  if (shared_preferences.getBool('darklightmode') == null ||
      prefs.getString('jwt') == null) {
    shared_preferences.setBool('darklightmode', false);
    prefs.setString('jwt',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJraHV2dWNfYzRfaWQiOiItMSIsIm5oYW52aWVuX3NtY3MiOiJnaWFuZ3Z0LmFnZyIsImRvbnZpX21vdGEiOiJQaMOybmcgxJBITlYiLCJ0ZW5kb252aTIiOiJudWxsIiwidGVuRG9uVmkiOiJQaMOybmcgxJBp4buBdSBow6BuaCAtIE5naGnhu4dwIHbhu6UiLCJuaGFudmllbl9pZCI6Ijg4NCIsImNodWNkYW5oIjoiMTAiLCJtYW5oYW52aWVuIjoiZ2lhbmd2dC5hZ2ciLCJpZCI6Ijg4NCIsImhvdGVuIjoiVsawxqFuZyBUcsaw4budbmcgR2lhbmciLCJzZHQiOiIwODM2MjgzMTY4IiwiZG9udmlfaWQiOiIxMyIsImRpYWNoaSI6IjY4LzVFIMSQw7RuZyBUaOG7i25oIDIsIE3hu7kgUGjGsOG7m2MsIExvbmcgWHV5w6puLCB04buJbmggQW4gR2lhbmciLCJtYV9OaGFuVmllbl9USE5TIjoiQ1RWMDgzOTQ5IiwibWFkb252aV9wdHRiIjoiMCIsImRvbnZpX21hIjoiREhOViIsImV4cCI6MTcwNjA3MDQyOCwiaXNzIjoiVk5QVC1CU0NBUFAiLCJhdWQiOiJCU0NBUFAifQ.bRbM02qU4aaG23s0Up39ANRcSI58XPX_PBZUozLN5nY');
  }
  // print(shared_preferences.getBool('darklightmode').toString());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp(prefs: prefs)));
 
  //   MaterialApp(
  //       theme: ThemeData(
  //           colorSchemeSeed: const Color(0x00005aab), useMaterial3: true),
  //       // home: LoginScreen_MainPage(
  //       //   thongBao: '',
  //       //   prefs: prefs,
  //       // )),
  // localizationsDelegates: [
  //   GlobalWidgetsLocalizations.delegate,
  //   GlobalMaterialLocalizations.delegate,
  //   MonthYearPickerLocalizations.delegate,
  // ],
  //       debugShowCheckedModeBanner: false,
  //       home: const HomePage_MainPage()),
  //       //   home: LoginScreen_MainPage(thongBao: 'Unauthorized',)),
  // home: LoginScreen_MainPage(
  //   thongBao: '',
  //   prefs: prefs,
  // )),
  // );
}
var Riverpod_Instance = riverpod_instance();

// ignore: must_be_immutable
class MyApp extends ConsumerWidget {
  MyApp({super.key, required this.prefs});
  SharedPreferences prefs;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        // theme: getAppTheme(context, ref.watch(appThemeProvider)),
        theme: ref.watch(appThemeProvider)
            ? ThemeData.dark(useMaterial3: true)
            // .copyWith(
            //     pageTransitionsTheme: const PageTransitionsTheme(
            //       builders: <TargetPlatform, PageTransitionsBuilder>{
            //         TargetPlatform.android: ZoomPageTransitionsBuilder(),
            //       },
            //     ),
            //   )
            : ThemeData(
                colorSchemeSeed: const Color(0x00005aab), useMaterial3: true)
        //  colorSchemeSeed: const Color(0x00005aab), useMaterial3: true)
        //   .copyWith(
        //   pageTransitionsTheme: const PageTransitionsTheme(
        //     builders: <TargetPlatform, PageTransitionsBuilder>{
        //       TargetPlatform.android: ZoomPageTransitionsBuilder(),
        //     },
        //   ),
        // )
        ,
       //  theme: getAppTheme(context, ref.watch(appThemeProvider)),
        // home: LoginScreen_MainPage(
        //   thongBao: '',    
        // ));
    //  home: LoginScreen_MainPage(thongBao: '',  ));
    home: LoginOne_MainPage(thongBao: '', ));
    // home: Login_One_OTP_MainPage());

  }
}
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vnptapp/Components/theme.dart';
// import 'package:vnptapp/screen/homepage/HomePage_MainPage.dart';
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Hive.initFlutter();
//   // Hive.registerAdapter(AccountAdapter());
//   HttpOverrides.global = MyHttpOverrides();
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs1 = await SharedPreferences.getInstance();
//   final indexTheme = prefs1.getInt('themeMode') ?? 0;
//   int indexColor = prefs1.getInt('theme') ?? 0;
//   runApp(MyApp(indexTheme: indexTheme, indexColor: indexColor));
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.indexTheme, required this.indexColor});
//   final indexTheme;
//   final indexColor;
//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (context) => ThemeProvider(indexTheme, indexColor),
//         builder: (context, child) {
//           final themeProvider = Provider.of<ThemeProvider>(context);
//           return MaterialApp(
//             darkTheme: ThemeClass.darkTheme,
//             theme: ThemeClass.lightTheme,
//             themeMode: themeProvider.themeMode,
//             debugShowCheckedModeBanner: false,
//             home: HomePage_MainPage(),
//           );
//         },
//       );
// }
