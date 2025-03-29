// ignore_for_file: file_names, camel_case_types
import 'dart:math';

import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vnptapp/Components/Custom_CopyRight_Bottom.dart';
import 'package:vnptapp/Components/Custom_AnimatedFAB.dart';
import 'package:vnptapp/Components/Custom_Text.dart';
import 'package:vnptapp/screen/Drawer/Drawer_MainPage.dart';
import 'package:vnptapp/screen/homepage/HomePage_Route.dart';
import '../../Variable/Constant.dart';

// // // ignore: camel_case_types

class HomePage_MainPage extends ConsumerWidget {
  const HomePage_MainPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    isDarkMode = ref.watch(appThemeProvider);
    return ScaffoldDraggable(
      button: TextButton(
        child: const Text('asdf'),
        onPressed: () {},
      ),
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Hệ thống BSC/KPI',
            ),
            // actions: const <Widget>[
            //   Padding(
            //     padding: EdgeInsets.only(right: 16.0),
            //     child: Icon(Icons.add_alert,
            //    //  color: Colors.white
            //      ),
            //   ),
            // ],
          ),
          body: Stack(
            children: [
              Container(
                width: widthOfDevice(context),
                height: heightOfDevice(context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/homepage.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Custom_CopyRight_Bottom()
            ],
          ),
          drawer: const Drawer_HomePage(),
        ),
      ),
    );
  }
}

// class HomePage_MainPage extends ConsumerWidget {
//   const HomePage_MainPage({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     isDarkMode = ref.watch(appThemeProvider);
//     return Scaffold(
//         drawer: const Drawer_HomePage(),
//         body:
//          Container(
//           color: Colors.white.withOpacity(0.1),
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 backgroundColor: isDarkMode ? secondDaryColors : primaryColors,
//                 expandedHeight: heightOfDevice(context) + 50,
//                 floating: false,
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   title: SizedBox(
//                       width: widthOfDevice(context),
//                       child: const Text('')),
//                   background: Container(
//                     width: widthOfDevice(context),
//                     height: heightOfDevice(context),
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/homepage.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // SliverGrid(
//               //         gridDelegate:
//               //             const SliverGridDelegateWithFixedCrossAxisCount(
//               //           crossAxisCount: 3,
//               //         ),
//               //         delegate: SliverChildBuilderDelegate(
//               //           (BuildContext context, int index) {
//               //             return Container(
//               //                 decoration: BoxDecoration(
//               //                   borderRadius:
//               //                       BorderRadius.all(Radius.circular(20.0)),
//               //                 ),
//               //                 child: buildCard(context, index));
//               //           },
//               //           childCount: 15, // 3 cột x 10 hàng = 30 items
//               //     ),
//               //   )
//               SliverGrid(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 1.0,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return buildCard(context,index);
//                   },
//                   childCount: 15,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class HomePage_MainPage extends ConsumerWidget {
//   const HomePage_MainPage({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     isDarkMode = ref.watch(appThemeProvider);
//     return Scaffold(
//       appBar: AppBar(
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(
//               Icons.menu_rounded,
//               // color: Colors.white,
//             ),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         backgroundColor: isDarkMode ? secondDaryColors : primaryColors,
//         centerTitle: true,
//         title: const Text(
//           'Hệ thống BSC/KPI',
//           // style: TextStyle(color: Colors.white),
//         ),
//         // actions: const <Widget>[
//         //   Padding(
//         //     padding: EdgeInsets.only(right: 16.0),
//         //     child: Icon(Icons.add_alert,
//         //    //  color: Colors.white
//         //      ),
//         //   ),
//         // ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: widthOfDevice(context),
//                   height: heightOfDevice(context) - 90,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/homepage.jpg'),
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 0, // Dùng để đặt phần tử dưới cùng của stack
//                     child: Stack(
//                       children: [
//                         Container(
//                           height: 20,
//                           width: widthOfDevice(context),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20.0),
//                                   topRight: Radius.circular(20.0))),
//                         ),
//                         Positioned(
//                           left: widthOfDevice(context)/2 - 20,
//                           child: Container(
//                             width: 40,
//                             height: 6,
//                             decoration: BoxDecoration(
//                               color: Colors.blue.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         )
//                       ],
//                     )),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 )
//               ],
//             ),
//             const Custom_CopyRight_Bottom(),
//           ],
//         ),
//       ),
//       drawer: const Drawer_HomePage(),
//     );
//   }
// }

// class HomePage_MainPage extends ConsumerWidget {
//   const HomePage_MainPage({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     isDarkMode = ref.watch(appThemeProvider);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: isDarkMode ? secondDaryColors : primaryColors,
//         centerTitle: true,
//         title: const Text(
//           'Hệ thống BSC/KPI',
//           // style: TextStyle(color: Colors.white),
//         ),
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(
//               Icons.menu_rounded,
//               // color: Colors.white,
//             ),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//       ),
//       drawer: const Drawer_HomePage(),
//       body: DraggableBottomSheet(
//         minExtent: heightOfDevice(context)/10,
//         useSafeArea: false,
//         curve: Curves.easeIn,
//         previewWidget: _previewWidget(context),
//         expandedWidget: _expandedWidget(context),
//         backgroundWidget: _backgroundWidget(context),
//         maxExtent: MediaQuery.of(context).size.height * 0.8,
//           duration: const Duration(milliseconds: 50),
//         onDragging: (pos) {},
//       ),
//     );
//   }

//   Widget _backgroundWidget(BuildContext context) {
//     return Stack(
//       children: [
//         // Image.asset(
//         //   'assets/homepage.jpg',
//         // ),
//         Container(
//           width: widthOfDevice(context),
//           height: heightOfDevice(context),
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/homepage.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         // ElevatedButton(
//         //   onPressed: () {
//         //     _showBottomSheet(context);
//         //   },
//         //   child: Text('Open Bottom Sheet'),
//         // ),
//         const Custom_CopyRight_Bottom()
//       ],
//     );
//   }

//   Widget _previewWidget(BuildContext context) {
//     return Container(
//         height: 50,
//         width: widthOfDevice(context),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.4),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(children: <Widget>[
//           Container(
//             width: 40,
//             height: 6,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ]));
//   }

//   Widget _expandedWidget(BuildContext context) {
//     return Container(
//         height: heightOfDevice(context),
//         width: heightOfDevice(context),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.4),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Wrap(
//           children: [
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Card(
//                       child: Text('asdf'),
//                     ),
//                     Card(child: Text('asdf')),
//                     Card(child: Text('asdf')),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ));
//   }
// }



// class HomePage_MainPage extends StatefulWidget {
//   const HomePage_MainPage({super.key});
//   @override
//   State<HomePage_MainPage> createState() => _HomePage_MainPageState();
// }
// class _HomePage_MainPageState extends State<HomePage_MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldDraggable(
//       button: TextButton(
//         child: Text('asdf'),
//         onPressed: () {},
//       ),
//       child: DefaultTabController(
//         length: 6,
//         child: Scaffold(
//           appBar: AppBar(
//             leading: Builder(
//               builder: (context) => IconButton(
//                 icon: const Icon(
//                   Icons.menu_rounded,
//                   color: Colors.white,
//                 ),
//                 onPressed: () => Scaffold.of(context).openDrawer(),
//               ),
//             ),
//             backgroundColor: primaryColors,
//             centerTitle: true,
//             title: const Text(
//               'Hệ thống BSC/KPI',
//               style: TextStyle(color: Colors.white),
//             ),
//             actions: const <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(right: 16.0),
//                 child: Icon(Icons.add_alert, color: Colors.white),
//               ),
//             ],
//           ),
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
//               Column(
//                 children: [
//                   MaterialButton(
//                     onPressed: () async {
//                       SharedPreferences prefs1 =
//                           await SharedPreferences.getInstance();
//                       final setTheme = prefs1.setInt('themeMode', 0);
//                       final setColor = prefs1.setInt('theme', 0);
//                       final indexTheme = prefs1.getInt('themeMode');
//                       final indexColor = prefs1.getInt('themeMode');
//                       setState(() {});
//                       ThemeProvider(indexTheme!, indexColor!)
//                           .toggleTheme(indexTheme);
//                     },
//                     child: Text('sdfa'),
//                   ),
//                   MaterialButton(
//                     onPressed: () async {
//                       SharedPreferences prefs1 =
//                           await SharedPreferences.getInstance();
//                       final setTheme = prefs1.setInt('themeMode', 1);
//                       final setColor = prefs1.setInt('theme', 1);
//                       final indexTheme = prefs1.getInt('themeMode');
//                       final indexColor = prefs1.getInt('themeMode');
//                       setState(() {});
//                       ThemeProvider(indexTheme!, indexColor!)
//                           .toggleTheme(indexTheme);
//                     },
//                     child: Text('asda'),
//                   ),
//                 ],
//               ),
//               const Custom_CopyRight_Bottom()
//             ],
//           ),
//           drawer: const Drawer_HomePage(),
//         ),
//       ),
//     );
//   }
// }
