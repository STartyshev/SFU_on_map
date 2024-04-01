/*import 'package:flutter_projects/app_location.dart';
import 'package:flutter_projects/coordinates_class.dart';

class LocationService implements AppLocation {
  final defLocation = const StudCityCoordinates();

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<Coordinates> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return Coordinates(lat: value.latitude, long: value.longitude);
    }).catchError(
          (_) => defLocation,
    );
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}*/