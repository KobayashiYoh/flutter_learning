import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

extension LocationDataExtensions on LocationData {
  double get kilometerPerHour {
    final double meterPerSecond = speed ?? 0.0;
    return meterPerSecond * 3600 / 1000;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LocationData _locationData = LocationData.fromMap({});

  void _updateLocation() async {
    Location location = Location();
    final locationData = await location.getLocation();
    setState(() {
      _locationData = locationData;
    });
  }

  Future<void> _initLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    Location location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _updateLocation();
    });
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _updateLocation();
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await _initLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('位置情報取得アプリ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('緯度: ${_locationData.latitude?.toStringAsFixed(4)}'),
            Text('経度: ${_locationData.longitude?.toStringAsFixed(4)}'),
            Text('標高: ${_locationData.altitude?.toStringAsFixed(2)}（m）'),
            Text(
              '速度: ${_locationData.kilometerPerHour.toStringAsFixed(2)}（km/h）',
            ),
            Text(
              'デバイスの水平方向の移動方向: ${_locationData.heading?.toStringAsFixed(2)}（°）',
            ),
            Text('isMock: ${_locationData.isMock}'),
          ],
        ),
      ),
    );
  }
}
