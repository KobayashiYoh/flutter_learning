import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:location_information/location_util.dart';
import 'package:location_information/location_view.dart';
import 'package:location_information/target_location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationData _currentLocation = LocationData.fromMap({});
  double _distance = 0;

  void _setLocation(LocationData data) {
    setState(() {
      _currentLocation = data;
    });
  }

  void _setDistance(double distance) {
    setState(() {
      _distance = distance;
    });
  }

  void _locationListener(LocationData data) {
    print(data);
    print(data.altitude);
    _setLocation(data);
    final distance = Geolocator.distanceBetween(
      _currentLocation.latitude!,
      _currentLocation.longitude!,
      TargetLocation.latitude,
      TargetLocation.longitude,
    );
    _setDistance(distance);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('現在地から目的地までの距離'),
            Text(
              '${_distance.toStringAsFixed(2)}(m)',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 32.0),
            const Text('目的地'),
            const LocationView(
              latitude: TargetLocation.latitude,
              longitude: TargetLocation.longitude,
              altitude: TargetLocation.altitude,
            ),
            const SizedBox(height: 32.0),
            const Text('現在位置'),
            LocationView(
              latitude: _currentLocation.latitude!,
              longitude: _currentLocation.longitude!,
              altitude: _currentLocation.altitude!,
            ),
          ],
        ),
      ),
    );
  }
}
