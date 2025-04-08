import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnptapp/Variable/Constant.dart';
import 'package:vnptapp/screen/Drawer_One/Drawer_One_MainPage.dart';
import 'package:vnptapp/screen/Main_Homepage/Main_Homepage_Logic.dart';

void main() {
  FlutterForegroundTask.initCommunicationPort();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const Main_HomePage());
  }
}

// Singleton service để quản lý vị trí
class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final ValueNotifier<Map<String, double>?> positionListenable = ValueNotifier(
    null,
  );
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isStreaming = false;

  Future<void> init() async {
    await _requestPermissions();
    _initForegroundTask();
    await _startForegroundTask();
    _startPositionStream();
  }

  Future<void> _requestPermissions() async {
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    if (Platform.isAndroid &&
        !await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }
  }

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Location Service Notification',
        channelDescription:
            'This notification appears when the location service is running.',
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: false,
        allowWifiLock: true,
      ),
    );
  }

  Future<void> _startForegroundTask() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Dịch vụ vị trí',
        notificationText: 'Đang chạy...',
        callback: startCallback,
      );
    }
  }

  Future<void> stopService() async {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    _isStreaming = false;
    await FlutterForegroundTask.stopService();
    print('Đã dừng dịch vụ vị trí.');
  }

  void _startPositionStream() {
    if (_isStreaming) return;

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen(
      (Position position) async {
        String login = await saveData_LongLat(
          position.longitude.toString(),
          position.latitude.toString(),
        );
        print('Position (Stream): ${position.latitude}, ${position.longitude}');
        positionListenable.value = {
          'latitude': position.latitude,
          'longitude': position.longitude,
        };
        
      },
      onError: (e) {
        print('Lỗi từ Position Stream: $e');
      },
    );
    _isStreaming = true;
  }

  void _onReceiveTaskData(Object data) {
    if (data is Map) {
      positionListenable.value = {
        'latitude': data['latitude'] as double,
        'longitude': data['longitude'] as double,
      };
    }
  }

  void registerCallback() {
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
  }

  void unregisterCallback() {
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(LocationTaskHandler());
}

class LocationTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    print('onStart(starter: ${starter.name})');
    await _getAndSendPosition();
  }

  @override
  void onRepeatEvent(DateTime timestamp) async {
    await _getAndSendPosition();
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('onDestroy');
  }
Future<void> _getAndSendPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('GPS bị tắt trong TaskHandler');
        FlutterForegroundTask.updateService(
          notificationTitle: 'Dịch vụ vị trí',
          notificationText: 'GPS bị tắt',
        );
        return;
      }

      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 15), // Tăng thời gian timeout lên 15s
        ).timeout(const Duration(seconds: 15), onTimeout: () {
          throw TimeoutException('Không thể lấy vị trí trong 15 giây');
        });
      } on TimeoutException catch (timeout) {
        print('Timeout khi lấy vị trí: $timeout');
        FlutterForegroundTask.updateService(
          notificationTitle: 'Dịch vụ vị trí',
          notificationText: 'Không thể lấy vị trí: Timeout',
        );
        return; // Thoát hàm mà không crash dịch vụ
      }

      if (position != null) {
        print('Position (TaskHandler): ${position.latitude}, ${position.longitude}');
        String login = await saveData_LongLat(
          position.longitude.toString(),
          position.latitude.toString(),
        );
        FlutterForegroundTask.updateService(
          notificationTitle: 'Dịch vụ vị trí',
          notificationText: 'Lat: ${position.latitude}, Long: ${position.longitude}',
        );
        FlutterForegroundTask.sendDataToMain({
          'latitude': position.latitude,
          'longitude': position.longitude,
        });
      }
    } catch (e) {
      print('Lỗi lấy vị trí từ TaskHandler: $e');
      FlutterForegroundTask.updateService(
        notificationTitle: 'Dịch vụ vị trí',
        notificationText: 'Lỗi: $e',
      );
    }
  }


}

class Main_HomePage extends StatefulWidget {
  const Main_HomePage({super.key});

  @override
  _Main_HomePageState createState() => _Main_HomePageState();
}

class _Main_HomePageState extends State<Main_HomePage> {
  late String user_one;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    user_one = shared_preferences.getString('user_one') ?? 'Guest';
    _locationService.registerCallback();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _locationService.init();
    });
  }

  @override
  void dispose() {
    _locationService.unregisterCallback();
    super.dispose();
  }

  resetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_one');
    prefs.remove('thoigian_login');
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: Scaffold(
        appBar: AppBar(title: Text('Xin chào, $user_one'), centerTitle: true),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildPositionText()),
              _buildServiceControlButtons(),
            ],
          ),
        ),
        drawer: const Drawer_One_MainPage(),
      ),
    );
  }

  Widget _buildPositionText() {
    return ValueListenableBuilder<Map<String, double>?>(
      valueListenable: _locationService.positionListenable,
      builder: (context, position, _) {
        if (position == null) {
          return const Center(
            child: Text('Đang chờ vị trí...', style: TextStyle(fontSize: 20)),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Vị trí hiện tại:', style: TextStyle(fontSize: 24)),
              Text(
                'Latitude: ${position['latitude']}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Longitude: ${position['longitude']}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceControlButtons() {
    buttonBuilder(String text, {VoidCallback? onPressed}) {
      return ElevatedButton(onPressed: onPressed, child: Text(text));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonBuilder('Bắt đầu lấy vị trí', onPressed: _locationService.init),
          buttonBuilder(
            'Dừng lấy vị trí',
            onPressed: _locationService.stopService,
          ),
        ],
      ),
    );
  }
}
