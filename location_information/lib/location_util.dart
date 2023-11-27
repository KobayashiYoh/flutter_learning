import 'dart:async';

import 'package:location/location.dart';

/// 位置情報packageのLocationに関するユーティリティクラスです。
class LocationUtil {
  static final Location _location = Location();

  ///　位置情報の取得が可能かどうか確認する。
  static Future<void> _checkServiceEnabled() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
  }

  /// 位置情報の権限が許可されているかどうか確認する。
  static Future<void> _checkLocationPermission() async {
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  /// 位置情報を取得に必要な初期化処理を行う。
  static Future<void> initLocation(void Function(LocationData)? listen) async {
    try {
      await _checkServiceEnabled();
      await _checkLocationPermission();
    } catch (e) {
      throw Exception('Failed to fetch location data: $e');
    }
    _location.onLocationChanged.listen(listen);
  }
}
