import 'package:geolocator/geolocator.dart';

double calculateDistance({
  required double lat1,
  required double lon1,
  required double lat2,
  required double lon2,
}) {
  {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}