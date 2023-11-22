import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_information/location_util.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationData _locationData = LocationData.fromMap({});

  void _setLocation(LocationData data) {
    setState(() {
      _locationData = data;
    });
  }

  void _locationListener(LocationData data) {
    _setLocation(data);
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await LocationUtil.initLocation(_locationListener);
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
            Text('緯度: ${_locationData.latitude}'),
            Text('経度: ${_locationData.longitude}'),
            Text('標高: ${_locationData.altitude}'),
          ],
        ),
      ),
    );
  }
}
