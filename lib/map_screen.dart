import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/connection_between_widgets.dart';
import 'package:flutter_projects/coordinates_class.dart';
import 'package:flutter_projects/models/todo_item.dart';
import 'package:flutter_projects/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_projects/middle_of_points.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.building});

  final BuildingItem building;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late final YandexMapController mapController;
  late final BicycleResultWithSession drivingResultWithSession;
  PolylineMapObject? route;
  Point? constPoint;
  Point? endPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 64),
        height: 600,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5))
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: YandexMap(
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
              ),
            },
            onMapCreated: (controller) async {
              mapController = controller;
              checkPermission();
              KrasnoyarskCoordinates krasnoyarsk = const KrasnoyarskCoordinates();
              await mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                          latitude: krasnoyarsk.lat,
                          longitude: krasnoyarsk.long
                      ),
                      zoom: 12,
                    )
                ),
              );
            },
            onUserLocationAdded: (view) async {
              CameraPosition? userLocation = await mapController.getUserCameraPosition();
              Point startPoint = userLocation!.target;
              endPoint = Point(
                  latitude: widget.building.buildingCoordinates.lat,
                  longitude: widget.building.buildingCoordinates.long
              );
              if (widget.building.routePoints.isEmpty) {
                drivingResultWithSession = getDrivingResultWithSession(
                    startPoint: startPoint,
                    endPoint: endPoint!
                );
                var result = await drivingResultWithSession.result;
                route = PolylineMapObject(
                    mapId: MapObjectId('route ${result.routes?[0]}'),
                    polyline: Polyline(points: result.routes![0].geometry)
                );
              } else {
                route = PolylineMapObject(
                    mapId: MapObjectId('route ${widget.building.routePoints}'),
                    polyline: Polyline(points: widget.building.routePoints)
                );
              }
              Point middleOfTwoPoints = middleBetweenPoints(startPoint, endPoint!);
              double distance = Geolocator.distanceBetween(
                  startPoint.latitude,
                  startPoint.longitude,
                  endPoint!.latitude,
                  endPoint!.longitude
              );
              await mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                          latitude: middleOfTwoPoints.latitude,
                          longitude: middleOfTwoPoints.longitude
                      ),
                      zoom: () {
                        return 13.6 + (3040 - distance) / 100 * 0.00211;}.call(),
                    )
                ),
                animation: const MapAnimation(
                  type: MapAnimationType.linear,
                  duration: 0.3,
                ),
              );
              setState(() {});
              return view.copyWith(
                accuracyCircle: const CircleMapObject(
                    mapId: MapObjectId('circle'),
                    circle: Circle(
                        center: Point(latitude: 0, longitude: 0),
                        radius: 0
                    ),
                    isVisible: false
                ),
              );
            },
            mapObjects: route != null ? constPoint == null ?
            [
              PlacemarkMapObject(
                  mapId: MapObjectId('MapObject $endPoint'),
                  point: Point(
                      latitude: endPoint!.latitude,
                      longitude: endPoint!.longitude
                  ),
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage('images/map_icons/marker.png'),
                      )
                  )
              ),
              route!
            ] :
            [
              PlacemarkMapObject(
                  mapId: MapObjectId('MapObject $constPoint'),
                  point: Point(
                      latitude: constPoint!.latitude,
                      longitude: constPoint!.longitude
                  ),
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage('images/map_icons/marker.png'),
                      )
                  )
              ),
              PlacemarkMapObject(
                  mapId: MapObjectId('MapObject $endPoint'),
                  point: Point(
                      latitude: endPoint!.latitude,
                      longitude: endPoint!.longitude
                  ),
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage('images/map_icons/marker.png'),
                      )
                  )
              ),
              route!
            ] : [],
          ),
        ),
    );
  }

  Future<void> checkPermission() async {
    if (await Permission.location.request().isGranted) {
      await mapController.toggleUserLayer(visible: true);
    } else {
      await moveToCurrentLocation(const StudCityCoordinates());
    }
  }

  Future<void> moveToCurrentLocation(Coordinates coordinates) async {
    constPoint = Point(latitude: coordinates.lat, longitude: coordinates.long);
    endPoint = Point(
        latitude: widget.building.buildingCoordinates.lat,
        longitude: widget.building.buildingCoordinates.long
    );
    if (widget.building.routePoints.isEmpty) {
      drivingResultWithSession = getDrivingResultWithSession(
          startPoint: constPoint!,
          endPoint: endPoint!
      );
      final result = await drivingResultWithSession.result;
      route = PolylineMapObject(
          mapId: MapObjectId('route ${result.routes![0]}'),
          polyline: Polyline(points: result.routes![0].geometry)
      );
      if (widget.building.type == 'study'){
        Provider.of<AppData>(context, listen: false)
            .updateStudyBuildingsData(widget.building, null, null, result.routes![0].geometry);
      } else {
        Provider.of<AppData>(context, listen: false)
            .updateSportBuildingsData(widget.building, null, null, result.routes![0].geometry);
      }
    } else {
      route = PolylineMapObject(
          mapId: MapObjectId('route ${widget.building.routePoints}'),
          polyline: Polyline(points: widget.building.routePoints)
      );
    }
    double distance = Geolocator.distanceBetween(
        constPoint!.latitude,
        constPoint!.longitude,
        endPoint!.latitude,
        endPoint!.longitude
    );
    Point middleOfTwoPoints = middleBetweenPoints(constPoint!, endPoint!);
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
                latitude: middleOfTwoPoints.latitude,
                longitude: middleOfTwoPoints.longitude
            ),
            zoom: () {
              return 13.6 + (3040 - distance) / 100 * 0.09;}.call(),
          )
      ),
      animation: const MapAnimation(
        type: MapAnimationType.linear,
        duration: 0.3,
      ),
    );
    setState(() {});
  }

  //SuggestResultWithSession? x;
  //SearchResultWithSession? y;
  //BicycleResultWithSession? z;
  /*Driving*/BicycleResultWithSession getDrivingResultWithSession ({
    required Point startPoint, required Point endPoint
  }) {
    return /*YandexDriving*/YandexBicycle.requestRoutes(
        points: [
          RequestPoint(
              point: startPoint,
              requestPointType: RequestPointType.wayPoint,
          ),
          RequestPoint(
            point: endPoint,
            requestPointType: RequestPointType.wayPoint,
          )
        ],
        /*drivingOptions: const DrivingOptions(
          initialAzimuth: 0,
          routesCount: 3,
          avoidTolls: true,
          avoidPoorConditions: true,
          avoidUnpaved: false
        ),*/ bicycleVehicleType: BicycleVehicleType.bicycle,
    );
  }

}