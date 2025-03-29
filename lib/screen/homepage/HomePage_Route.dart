import 'package:flutter/material.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/TongHop/MainPage.dart';
import 'package:vnptapp/screen/Drawer/DiaBan/TongHopDieuHanhGiamHuy/MainPage.dart';

Widget buildCard(BuildContext context, int index) {
  return Container(
      height: 30,
      width: 30,
      color: Colors.white.withOpacity(0.5),
      child: MaterialButton(
        onPressed: () {
          navigateToDetailPage(context,index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            setIcon(index),
            Text(
              nameOfmenu(index), // Văn bản
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ));
  //  GestureDetector(
  //     onTap: () {
  //       navigateToDetailPage(context, index);
  //     },
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //        setIcon(index),
  //         Text(
  //           nameOfmenu(index), // Văn bản
  //           style: TextStyle(fontSize: 10.0),
  //         ),
  //       ],
  //     ),
  //   );
}

void navigateToDetailPage(BuildContext context, int index) {
  switch (index) {
    case 0:
      pageTrasition(context, TongHop_MainPage());
      break;
    case 1:
      pageTrasition(context, TongHopDieuHanhGiamHuy_MainPage());
  }
}

String nameOfmenu(int index) {
  switch (index) {
    case 0:
      return "Tổng hợp";
    case 1:
      return "Tổng hợp DHGH";
  }
  return "a";
}

Icon setIcon(int index) {
  switch (index) {
    case 0:
      return Icon(Icons.cabin);
    case 1:
      return Icon(Icons.broadcast_on_home);
  }
  return Icon(Icons.ac_unit);
}
