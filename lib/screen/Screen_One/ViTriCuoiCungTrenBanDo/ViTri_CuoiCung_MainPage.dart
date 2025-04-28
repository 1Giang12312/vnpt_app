import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vnptapp/Components/Custom_LoadingButton.dart';
import 'package:vnptapp/Components/Custom_Page_Transition.dart';
import 'package:vnptapp/Components/Custom_ShowDialog.dart';
import 'package:vnptapp/Components/LoadingScreen.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_HomePage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriCuoiCungTrenBanDo/ViTri_CuoiCung_Logic.dart' as ViTri_CuoiCung_Logic;
import 'package:vnptapp/screen/Screen_One/ViTriCuoiCungTrenBanDo/ViTri_CuoiCung_Route.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Detail_MainPage.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Logic.dart' as HanhTrinh_Logic;
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Modal.dart';

class ViTri_CuoiCung_MainPage extends StatefulWidget {
  @override
  _ViTri_CuoiCung_MainPageState createState() => _ViTri_CuoiCung_MainPageState();
}

class _ViTri_CuoiCung_MainPageState extends State<ViTri_CuoiCung_MainPage> {
  MapController? _mapController; // Khởi tạo nullable để kiểm soát
  List<LatLng> _routePoints = [];
  List<dynamic> dataList = []; // Danh sách dữ liệu lấy từ API
  bool isLoading = false;
  bool _isDisposed = false;
  double _currentZoom = 15.0; // Theo dõi mức zoom hiện tại
  int? selectedMarkerIndex; // Lưu chỉ số của Marker được nhấn

  @override
  void initState() {
    super.initState();
    _mapController = MapController(); // Khởi tạo trong initState
    print("initState: _mapController created");
    // Tự động gọi loadDS_NV_SoKM với ngày hôm nay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isDisposed) {
        _loadDataForToday();
      }
    });
  }

  // Hàm lấy ngày hôm nay và gọi loadDS_NV_SoKM
  Future<void> _loadDataForToday() async {
    final today = DateTime.now();
    final formattedDate = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    await loadDs_NV(formattedDate, formattedDate);
  }

  void _focusOnRoute() {
    if (_routePoints.isEmpty || !mounted || _isDisposed || _mapController == null) {
      print("FocusOnRoute skipped: empty points, unmounted, disposed, or null controller");
      return;
    }

    try {
      print("FocusOnRoute called, _mapController: $_mapController");
      double minLat = _routePoints.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
      double maxLat = _routePoints.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
      double minLng = _routePoints.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
      double maxLng = _routePoints.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

      var bounds = LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));

      if (!_isDisposed && _mapController != null) {
        _mapController!.fitBounds(
          bounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(20)),
        );
      }
    } catch (e) {
      if (mounted && !_isDisposed) {
        print("Lỗi khi focus bản đồ: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi khi focus bản đồ: $e")),
        );
      }
    }
  }

  Future<void> loadDs_NV(String startDate, String endDate) async {
    if (mounted && !_isDisposed) {
      setState(() {
        isLoading = true;
      });
    }

    if (mounted && !_isDisposed) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
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
    }

    try {
      dataList = await ViTri_CuoiCung_Logic.LoadDSTenNV(startDate, endDate);
      print("DataList: $dataList");
      print("RoutePoints: $_routePoints");
      if (mounted && !_isDisposed) {
        setState(() {
          _routePoints = dataList.map((data) {
            return LatLng(
              double.parse(data.latitude.toString()),
              double.parse(data.longitude.toString()),
            );
          }).toList();
        });
        // Đợi FlutterMap render xong trước khi focus
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isDisposed && _mapController != null) {
            _focusOnRoute();
          }
        });
      }
    } catch (e) {
      if (mounted && !_isDisposed) {
        print("Lỗi khi tải dữ liệu: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi khi tải dữ liệu: $e")),
        );
      }
    } finally {
      if (mounted && !_isDisposed) {
        setState(() {
          isLoading = false;
        });
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  // Hàm tính kích thước Text động
  Size _calculateTextSize(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 280.0);
    return textPainter.size;
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (_mapController != null) {
      _mapController!.dispose();
      print("dispose: _mapController disposed");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Main_HomePage()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Theo dõi vị trí'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (mounted && !_isDisposed) {
                _loadDataForToday();
              }
            },
            tooltip: 'Tải lại bản đồ',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bản đồ
            Expanded(
              child: dataList.isEmpty && !isLoading
                  ? Center(child: Text("Không có dữ liệu"))
                  : FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: _routePoints.isNotEmpty
                            ? _routePoints.first
                            : LatLng(37.55938, -122.4108),
                        zoom: _currentZoom,
                        onPositionChanged: (position, hasGesture) {
                          if (mounted && !_isDisposed) {
                            setState(() {
                              _currentZoom = position.zoom ?? _currentZoom;
                            });
                          }
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: dataList.asMap().entries.map((entry) {
                            int index = entry.key;
                            var data = entry.value;
                            // Tính kích thước Text cho thẻ tên
                            final textStyle = TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            );
                            final textSize = _calculateTextSize(
                              data.hoTen ?? 'Unknown',
                              textStyle,
                            );
                            final markerWidth = selectedMarkerIndex == index
                                ? (textSize.width + 16).clamp(50.0, 300.0)
                                : 40.0;
                            final markerHeight = selectedMarkerIndex == index ? 80.0 : 40.0;

                            return Marker(
                              point: LatLng(
                                double.parse(data.latitude.toString()),
                                double.parse(data.longitude.toString()),
                              ),
                              width: markerWidth,
                              height: markerHeight,
                              child: GestureDetector(
                                onTap: () {
                                  if (mounted && !_isDisposed) {
                                    setState(() {
                                      selectedMarkerIndex = selectedMarkerIndex == index ? null : index;
                                    });
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color:Colors.red,
                                      size: 25,
                                    ),
                                    if (selectedMarkerIndex == index)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(color: Colors.black, width: 0.5),
                                        ),
                                        child: Text(
                                          data.hoTen ?? 'Unknown',
                                          style: textStyle,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
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