import 'dart:math';
import 'package:yandex_mapkit/yandex_mapkit.dart';

double degToRad(double a) {
  return pi / 180 * a;
}

double radToDeg(double a) {
  return 180 / pi * a;
}

List<double> pointToXYZ(Point point) {
  return [
    cos(degToRad(point.latitude)) * cos(degToRad(point.longitude)),
    cos(degToRad(point.latitude)) * sin(degToRad(point.longitude)),
    sin(degToRad(point.latitude))
  ];
}

Point xyzToPoint(List<double> xyz) {
  double x = xyz[0];
  double y = xyz[1];
  double z = xyz[2];
  return Point(
      latitude: radToDeg(atan2(z, sqrt(x*x + y*y))),
      longitude: radToDeg(atan2(y, x))
  );
}

List<double> middleXYZ(List<double> xyz1, List<double> xyz2) {
  return [
    (xyz1[0] + xyz2[0]) / 2.0,
    (xyz1[1] + xyz2[1]) / 2.0,
    (xyz1[2] + xyz2[2]) / 2.0
  ];
}

Point middleBetweenPoints(Point point1, Point point2) {
  return xyzToPoint(middleXYZ(pointToXYZ(point1), pointToXYZ(point2)));
}