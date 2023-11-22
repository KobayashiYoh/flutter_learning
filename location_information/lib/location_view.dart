import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  const LocationView({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.altitude,
  }) : super(key: key);
  final double latitude;
  final double longitude;
  final double altitude;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('緯度: $latitude'),
        Text('経度: $longitude'),
        Text('標高: $altitude'),
      ],
    );
  }
}
