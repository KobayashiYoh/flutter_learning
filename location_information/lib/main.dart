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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData _locationData = LocationData.fromMap({});

  void _updateLocation() async {
    Location location = Location();
    final locationData = await location.getLocation();
    setState(() {
      _locationData = locationData;
    });
  }

  Future<void> _initLocation() async {
    Location location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _updateLocation();
    });

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('緯度: ${_locationData.latitude}'),
            Text('経度: ${_locationData.longitude}'),
            Text('標高: ${_locationData.altitude}（m）'),
            Text('速度: ${_locationData.speed}（m/s）'),
            Text('デバイスの水平方向の移動方向: ${_locationData.heading}（°）'),
            Text('isMock: ${_locationData.isMock}'),
          ],
        ),
      ),
    );
  }
}
