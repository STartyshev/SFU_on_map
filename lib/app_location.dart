import 'package:flutter_projects/coordinates_class.dart';

abstract class AppLocation {
  Future<Coordinates> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}