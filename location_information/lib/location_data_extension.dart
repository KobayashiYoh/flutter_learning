import 'package:location/location.dart';

extension LocationDataExtension on LocationData {
  double get kilometerPerHour {
    final double meterPerSecond = speed ?? 0.0;
    return meterPerSecond * 3600 / 1000;
  }
}
