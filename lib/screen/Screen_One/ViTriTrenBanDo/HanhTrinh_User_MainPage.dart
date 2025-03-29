// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:vnptapp/Components/Custom_LoadingButton.dart';
// import 'package:vnptapp/Components/Custom_ShowDialog.dart';
// import 'package:vnptapp/Components/LoadingScreen.dart';
// import 'package:vnptapp/Variable/Constant.dart';
// import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_MainPage.dart';
// import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Logic.dart'
//     as HanhTrinh_Logic;
// import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Modal.dart';

// class HanhTrinh_User_MainPage extends StatefulWidget {
//   @override
//   _HanhTrinh_User_MainPageState createState() => _HanhTrinh_User_MainPageState();
// }

// class _HanhTrinh_User_MainPageState extends State<HanhTrinh_User_MainPage> {
//   late Future<List<LocationData>> futureLocations;
//   List<String> ds_nv = [];
//   bool isLoading = false;
//   List<LatLng> _routePoints = [];
//   List<LocationData> locateData = [];
//   late final MapController _mapController;
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController endDateController = TextEditingController();
//   String? selectedEmployee;
//   Future<void> _selectDate(
//     BuildContext context,
//     TextEditingController controller,
//   ) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       setState(() {
//         controller.text = picked.toString().split(' ')[0]; // Format YYYY-MM-DD
//       });
//     }
//   }

//   @override
//   void initState() {
//     _mapController = MapController();
//     if (mounted) {
//       loadData();
//     }
//     super.initState();
//   }

//   void _focusOnRoute() {
//     List<LatLng> formattedRoutePoints =
//         _routePoints.map((point) {
//           return LatLng(point.latitude, point.longitude);
//         }).toList();
//     if (formattedRoutePoints.isEmpty) return;

//     // Tính toán bounding box (góc trái trên & góc phải dưới)
//     double minLat = formattedRoutePoints
//         .map((p) => p.latitude)
//         .reduce((a, b) => a < b ? a : b);
//     double maxLat = formattedRoutePoints
//         .map((p) => p.latitude)
//         .reduce((a, b) => a > b ? a : b);
//     double minLng = formattedRoutePoints
//         .map((p) => p.longitude)
//         .reduce((a, b) => a < b ? a : b);
//     double maxLng = formattedRoutePoints
//         .map((p) => p.longitude)
//         .reduce((a, b) => a > b ? a : b);
//     // print(formattedRoutePoints);

//     var bounds = LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));

//     // Cập nhật bản đồ để fit tất cả các điểm trong danh sách
//     _mapController.fitBounds(
//       bounds,
//       options: FitBoundsOptions(padding: EdgeInsets.all(20)),
//     );
//   }

//   Future<void> loadData() async {
//     setState(() {
//       isLoading = true; // Bật trạng thái loading
//     });

//     try {
//       String? userOne = shared_preferences.getString('user_one');
//       if (userOne != null) {
//         ds_nv = await HanhTrinh_Logic.load_ds_NV(userOne!);
//         print("Lỗi: Không tìm thấy user_one trong SharedPreferences");
//       }
//     } catch (e) {
//       print("Lỗi khi tải dữ liệu: $e");
//     } finally {
//       // Đóng hộp thoại loading
//       setState(() {
//         isLoading = false; // Tắt trạng thái loading
//       });
//     }
//   }

//   Future<void> loadMap() async {
//     if (startDateController.text.isEmpty ||
//         endDateController.text.isEmpty ||
//         selectedEmployee == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Vui lòng nhập đủ thông tin")));
//       return;
//     } else {
//       showDialog(
//         context: context,
//         barrierDismissible: false, // Không cho phép đóng khi chạm ra ngoài
//         builder:
//             (context) => AlertDialog(
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 10),
//                   Text("Đang tải dữ liệu..."),
//                 ],
//               ),
//             ),
//       );
//       try {
//         locateData = await HanhTrinh_Logic.LoadDataHanhTrinh(
//           startDateController.text,
//           endDateController.text,
//           selectedEmployee.toString(),
//         );
//         setState(() {
//           _routePoints =
//               locateData
//                   .map(
//                     (location) => LatLng(location.latitude, location.longitude),
//                   )
//                   .toList();
//           _focusOnRoute();
//         });
//       } catch (e) {
//         print("Lỗi khi tải dữ liệu: $e");
//       } finally {
//         // Đóng hộp thoại loading
//         if (Navigator.canPop(context)) {
//           Navigator.of(context).pop();
//         }
//       }
//     }
//   }



//   Future<void> loadList() async {
//     if (startDateController.text.isEmpty ||
//         endDateController.text.isEmpty ||
//         selectedEmployee == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Vui lòng nhập đủ thông tin")));
//       return;
//     } else {
//       showDialog(
//         context: context,
//         barrierDismissible: false, // Không cho phép đóng khi chạm ra ngoài
//         builder:
//             (context) => AlertDialog(
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 10),
//                   Text("Đang tải dữ liệu..."),
//                 ],
//               ),
//             ),
//       );
//       try {
//         locateData = await HanhTrinh_Logic.LoadDataHanhTrinh(
//           startDateController.text,
//           endDateController.text,
//           selectedEmployee.toString(),
//         );
//         setState(() {
//           _routePoints =
//               locateData
//                   .map(
//                     (location) => LatLng(location.latitude, location.longitude),
//                   )
//                   .toList();
//           _focusOnRoute();
//         });
//       } catch (e) {
//         print("Lỗi khi tải dữ liệu: $e");
//       } finally {
//         // Đóng hộp thoại loading
//         if (Navigator.canPop(context)) {
//           Navigator.of(context).pop();
//         }
//       }
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/vnptangiang.jpg',
//               width: widthOfDevice(context) / 2,
//               height: heightOfDevice(context) / 3,
//             ),
//             LoadingScreen(nameOfLoadingScreen: 'Đang tải dữ liệu'),
//           ],
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => Main_Homepage_MainPage()),
//               (route) => false,
//             );
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text('Theo dõi hành trình'),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Chọn ngày bắt đầu
//             TextField(
//               controller: startDateController,
//               decoration: InputDecoration(
//                 labelText: "Ngày bắt đầu",
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () => _selectDate(context, startDateController),
//                 ),
//               ),
//             ),

//             // Chọn ngày kết thúc
//             TextField(
//               controller: endDateController,
//               decoration: InputDecoration(
//                 labelText: "Ngày kết thúc",
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () => _selectDate(context, endDateController),
//                 ),
//               ),
//             ),

//             // Chọn nhân viên
//             DropdownButton<String>(
//               value: selectedEmployee,
//               hint: Text("Chọn nhân viên"),
//               isExpanded: true,
//               items:
//                   ds_nv.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedEmployee = newValue;
//                 });
//               },
//             ),

//             // Nút tìm kiếm
//             ElevatedButton(onPressed: loadMap, child: Text("Tìm kiếm")),



//             // Danh sách kết quả
//             Expanded(

//               child: FlutterMap(
//                 mapController: _mapController,
//                 options: MapOptions(
//                   center:
//                       _routePoints.isNotEmpty
//                           ? _routePoints.first
//                           : LatLng(10.7769, 1.7009),
//                   zoom: 15,
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     userAgentPackageName: 'com.example.app',
//                     subdomains: ['a', 'b', 'c'],
//                   ),
//                   PolylineLayer(
//                     polylines: [
//                       Polyline(
//                         points: _routePoints,
//                         color: Colors.blue,
//                         strokeWidth: 4.0,
//                       ),
//                     ],
//                   ),
//                   MarkerLayer(
//                     markers:
//                         _routePoints.isNotEmpty
//                             ? [
//                               Marker(
//                                 point: _routePoints.first,
//                                 child: Icon(
//                                   Icons.location_on,
//                                   color: Colors.green,
//                                   size: 20,
//                                 ),
//                               ),
//                               Marker(
//                                 point: _routePoints.last,
//                                 child: Icon(
//                                   Icons.location_on,
//                                   color: Colors.red,
//                                   size: 20,
//                                 ),
//                               ),
//                             ]
//                             : [],
//                   ),
//                 ],
//               ),
//             ),
       
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:vnptapp/Components/Custom_LoadingButton.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/Components/Custom_ShowDialog.dart';
import 'package:vnptapp/Components/LoadingScreen.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_MainPage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Detail_MainPage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Logic.dart'
    as HanhTrinh_Logic;
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Modal.dart';

class HanhTrinh_User_MainPage extends StatefulWidget {
  @override
  _HanhTrinh_User_MainPageState createState() => _HanhTrinh_User_MainPageState();
}

class _HanhTrinh_User_MainPageState extends State<HanhTrinh_User_MainPage> {
  late Future<List<LocationData>> futureLocations;
  List<String> ds_nv = [];
  bool isLoading = false;
  List<LatLng> _routePoints = [];
  List<LocationData> locateData = [];
  late final MapController _mapController;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String? selectedEmployee;
  List<dynamic> dataList = []; // Danh sách dữ liệu lấy từ API
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().split(' ')[0]; // Format YYYY-MM-DD
      });
    }
  }

  @override
  void initState() {
    _mapController = MapController();
    // if (mounted) {
    //   loadData();
    // }
    super.initState();
  }

  void _focusOnRoute() {
    List<LatLng> formattedRoutePoints =
        _routePoints.map((point) {
          return LatLng(point.latitude, point.longitude);
        }).toList();
    if (formattedRoutePoints.isEmpty) return;

    // Tính toán bounding box (góc trái trên & góc phải dưới)
    double minLat = formattedRoutePoints
        .map((p) => p.latitude)
        .reduce((a, b) => a < b ? a : b);
    double maxLat = formattedRoutePoints
        .map((p) => p.latitude)
        .reduce((a, b) => a > b ? a : b);
    double minLng = formattedRoutePoints
        .map((p) => p.longitude)
        .reduce((a, b) => a < b ? a : b);
    double maxLng = formattedRoutePoints
        .map((p) => p.longitude)
        .reduce((a, b) => a > b ? a : b);
    // print(formattedRoutePoints);

    var bounds = LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));

    // Cập nhật bản đồ để fit tất cả các điểm trong danh sách
    _mapController.fitBounds(
      bounds,
      options: FitBoundsOptions(padding: EdgeInsets.all(20)),
    );
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true; // Bật trạng thái loading
    });

    try {
      String? userOne = shared_preferences.getString('user_one');
      if (userOne != null) {
        ds_nv = await HanhTrinh_Logic.load_ds_NV(userOne!);
        print("Lỗi: Không tìm thấy user_one trong SharedPreferences");
      }
    } catch (e) {
      print("Lỗi khi tải dữ liệu: $e");
    } finally {
      // Đóng hộp thoại loading
      setState(() {
        isLoading = false; // Tắt trạng thái loading
      });
    }
  }

  Future<void> loadMap() async {
    if (startDateController.text.isEmpty ||
        endDateController.text.isEmpty ||
        selectedEmployee == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng nhập đủ thông tin")));
      return;
    } else {
      showDialog(
        context: context,
        barrierDismissible: false, // Không cho phép đóng khi chạm ra ngoài
        builder:
            (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Đang tải dữ liệu..."),
                ],
              ),
            ),
      );
      try {
        locateData = await HanhTrinh_Logic.LoadDataHanhTrinh(
          startDateController.text,
          endDateController.text,
          selectedEmployee.toString(),
        );
        setState(() {
          _routePoints =
              locateData
                  .map(
                    (location) => LatLng(location.latitude, location.longitude),
                  )
                  .toList();
          _focusOnRoute();
        });
      } catch (e) {
        print("Lỗi khi tải dữ liệu: $e");
      } finally {
        // Đóng hộp thoại loading
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    }
  }



Future<void> LoadDS_NV() async {
    if (startDateController.text.isEmpty ||
        endDateController.text.isEmpty ||
        selectedEmployee == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng nhập đủ thông tin")));
      return;
    } else {
      showDialog(
        context: context,
        barrierDismissible: false, // Không cho phép đóng khi chạm ra ngoài
        builder:
            (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Đang tải dữ liệu..."),
                ],
              ),
            ),
      );
      try {
        locateData = await HanhTrinh_Logic.LoadDataHanhTrinh(
          startDateController.text,
          endDateController.text,
          selectedEmployee.toString(),
        );
        setState(() {
          _routePoints =
              locateData
                  .map(
                    (location) => LatLng(location.latitude, location.longitude),
                  )
                  .toList();
          _focusOnRoute();
        });
      } catch (e) {
        print("Lỗi khi tải dữ liệu: $e");
      } finally {
        // Đóng hộp thoại loading
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    }
  }


  Future<void> loadDS_NV_Ngay_SoKM() async {
    print('asds');
    if (startDateController.text.isEmpty ||
        endDateController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng nhập đủ thông tin")));
      return;
    } else {
      showDialog(
        context: context,
        barrierDismissible: false, // Không cho phép đóng khi chạm ra ngoài
        builder:
            (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Đang tải dữ liệu..."),
                ],
              ),
            ),
      );
      try {
        dataList = await HanhTrinh_Logic.LoadDS_NV_Ngay_SoKM(
          startDateController.text,
          endDateController.text
        );
        setState(() {
          print(dataList);
        });
      } catch (e) {
        print("Lỗi khi tải dữ liệu: $e");
      } finally {
        // Đóng hộp thoại loading
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/vnptangiang.jpg',
              width: widthOfDevice(context) / 2,
              height: heightOfDevice(context) / 3,
            ),
            LoadingScreen(nameOfLoadingScreen: 'Đang tải dữ liệu'),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Main_Homepage_MainPage()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Theo dõi hành trình'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Chọn ngày bắt đầu
            TextField(
              controller: startDateController,
              decoration: InputDecoration(
                labelText: "Ngày bắt đầu",
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, startDateController),
                ),
              ),
            ),

            // Chọn ngày kết thúc
            TextField(
              controller: endDateController,
              decoration: InputDecoration(
                labelText: "Ngày kết thúc",
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, endDateController),
                ),
              ),
            ),

            // // Chọn nhân viên
            // DropdownButton<String>(
            //   value: selectedEmployee,
            //   hint: Text("Chọn nhân viên"),
            //   isExpanded: true,
            //   items:
            //       ds_nv.map((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       selectedEmployee = newValue;
            //     });
            //   },
            // ),

            // Nút tìm kiếm
            ElevatedButton(onPressed: loadDS_NV_Ngay_SoKM, child: Text("Tìm kiếm")),
            // // Danh sách kết quả
            // Expanded(
            //   child: FlutterMap(
            //     mapController: _mapController,
            //     options: MapOptions(
            //       center:
            //           _routePoints.isNotEmpty
            //               ? _routePoints.first
            //               : LatLng(10.7769, 1.7009),
            //       zoom: 15,
            //     ),
            //     children: [
            //       TileLayer(
            //         urlTemplate:
            //             "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            //         userAgentPackageName: 'com.example.app',
            //         subdomains: ['a', 'b', 'c'],
            //       ),
            //       PolylineLayer(
            //         polylines: [
            //           Polyline(
            //             points: _routePoints,
            //             color: Colors.blue,
            //             strokeWidth: 4.0,
            //           ),
            //         ],
            //       ),
            //       MarkerLayer(
            //         markers:
            //             _routePoints.isNotEmpty
            //                 ? [
            //                   Marker(
            //                     point: _routePoints.first,
            //                     child: Icon(
            //                       Icons.location_on,
            //                       color: Colors.green,
            //                       size: 20,
            //                     ),
            //                   ),
            //                   Marker(
            //                     point: _routePoints.last,
            //                     child: Icon(
            //                       Icons.location_on,
            //                       color: Colors.red,
            //                       size: 20,
            //                     ),
            //                   ),
            //                 ]
            //                 : [],
            //       ),
            //     ],
            //   ),
            // ),
      
      
      
          Expanded(
              child:
               dataList.isEmpty
                  ? Center(child: Text("Không có dữ liệu"))
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final item = dataList[index];
                        return Card(
                          child: ListTile(
                            title: Text("Ngày: ${DateFormat('yyyy-MM-dd').format(item.date)}"),
                            subtitle: Text("Số KM đã đi: ${item.total_distance_km} km"),
                            trailing: ElevatedButton(
                              onPressed: () {
                                pageTrasition(context,HanhTrinh_Detail_MainPage(user_one: item.user_one,ngay_bd: DateFormat('yyyy-MM-dd').format(item.date),ngay_kt:  DateFormat('yyyy-MM-dd').format(item.date)));
                                print("User được bấm: ${item.user_one}");
                              },
                              child: Text("Chi tiết"),
                            ),
                          ),
                        );
                      },
                    ),)
          ],
        ),
      ),
    );
  }
}
