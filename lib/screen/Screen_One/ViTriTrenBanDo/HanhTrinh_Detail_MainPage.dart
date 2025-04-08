import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vnptapp/Components/Custom_LoadingButton.dart';
import 'package:vnptapp/Components/Custom_ShowDialog.dart';
import 'package:vnptapp/Components/LoadingScreen.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Logic.dart'
    as HanhTrinh_Logic;
import 'package:vnptapp/screen/Screen_One/ViTriTrenBanDo/HanhTrinh_Modal.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class HanhTrinh_Detail_MainPage extends StatefulWidget {
  HanhTrinh_Detail_MainPage({
    super.key,
    required this.user_one,
    required this.ngay_bd,
    required this.ngay_kt,
  });
  String user_one;
  String ngay_bd;
  String ngay_kt;

  @override
  _HanhTrinh_Detail_MainPageState createState() =>
      _HanhTrinh_Detail_MainPageState();
}

class _HanhTrinh_Detail_MainPageState extends State<HanhTrinh_Detail_MainPage> {
  late Future<List<LocationData>> futureLocations;
  List<String> ds_nv = [];
  bool isLoading = false;
  List<LatLng> _routePoints = [];
  List<LocationData> locateData = [];
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String? selectedEmployee;
  List<dynamic> dataList = [];
  CancelableOperation? _loadMapOperation;
  bool _hasNetworkError = false;

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
    if (picked != null && mounted) {
      setState(() {
        controller.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        loadMap(widget.user_one, widget.ngay_bd, widget.ngay_kt);
      }
    });
  }

  void _focusOnRoute(MapController mapController) {
    if (!mounted || _routePoints.isEmpty) return;

    List<LatLng> formattedRoutePoints = _routePoints.map((point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();

    double minLat =
        formattedRoutePoints.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
    double maxLat =
        formattedRoutePoints.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
    double minLng =
        formattedRoutePoints.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
    double maxLng =
        formattedRoutePoints.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

    var bounds = LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));

    mapController.fitBounds(
      bounds,
      options: FitBoundsOptions(padding: EdgeInsets.all(20)),
    );
  }

  Future<void> loadMap(String user_one, String ngay_bd, String ngay_kt) async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      _hasNetworkError = false;
    });

    _loadMapOperation = CancelableOperation.fromFuture(
      HanhTrinh_Logic.LoadDataHanhTrinh(ngay_bd, ngay_kt, user_one),
    );

    try {
      locateData = await _loadMapOperation!.value;

      if (mounted) {
        setState(() {
          isLoading = false;
          _routePoints = locateData
              .map((location) => LatLng(location.latitude, location.longitude))
              .toList();
        });
      }
    } catch (e) {
      print("Lỗi khi tải dữ liệu: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
          _hasNetworkError = e.toString().contains('SocketException');
        });
      }
    }
    if (mounted) {
      print(_routePoints);
    }
  }

  @override
  void dispose() {
    _loadMapOperation?.cancel();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();

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

    if (_hasNetworkError) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Theo dõi hành trình'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Không thể tải bản đồ. Vui lòng kiểm tra kết nối mạng và thử lại.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  loadMap(widget.user_one, widget.ngay_bd, widget.ngay_kt);
                },
                child: Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_routePoints.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusOnRoute(mapController);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Theo dõi hành trình'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
       // Danh sách kết quả
            Expanded(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center:
                      _routePoints.isNotEmpty
                          ? _routePoints.first
                          : LatLng(10.7769, 1.7009),
                  zoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.app',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        color: Colors.blue,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers:
                        _routePoints.isNotEmpty
                            ? [
                              Marker(
                                point: _routePoints.first,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              Marker(
                                point: _routePoints.last,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ]
                            : [],
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